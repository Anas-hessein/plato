extends Node2D

var level: int = 1
var current_level_root: Node = null

func _ready() -> void:
	_load_level(level)

func _load_level(level_number: int) -> void:
	# No more levels → game complete
	if level_number > 3:  # ← change 3 to however many levels you have
		print("You win!")
		get_tree().change_scene_to_file("res://seances/win_screen.tscn")  # or load a win screen scene
		return
	
	if current_level_root:
		current_level_root.queue_free()
	
	var level_path = "res://seances/level_%s.tscn" % level_number
	print("Loading: ", level_path)
	
	current_level_root = load(level_path).instantiate()
	add_child(current_level_root)
	current_level_root.name = "Level"
	
	var exit = current_level_root.get_node_or_null("exit")
	if exit:
		print("Exit found in level ", level_number)
		exit.body_entered.connect(_on_exit_body_entered)
	else:
		print("WARNING: no exit in level ", level_number)
		
func _respawn() -> void:
	_load_level(level)  # ← reloads current level, not level 1

func _on_exit_body_entered(body: Node2D) -> void:
	print("Exit touched by: ", body.name)
	if not body is CharacterBody2D:  # ← only accept physics bodies, not TileMap
		return
	if body.name == "player":
		level += 1
		print("Loading level: ", level)
		call_deferred("_load_level", level)
