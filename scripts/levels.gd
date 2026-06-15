extends Node2D

var level: int = 1
var current_level_root: Node = null


const LEVELS = [
	"res://seances/level_1.tscn",
	"res://seances/level_2.tscn",
	"res://seances/level_3.tscn",
	"res://seances/level_4.tscn",
	"res://seances/level_5.tscn",
	"res://seances/level_6.tscn",
	"res://seances/level_7.tscn",
	"res://seances/level_8.tscn",
	"res://seances/level_9.tscn",
	"res://seances/level_10.tscn",
	"res://seances/level_11.tscn",
	"res://seances/level_12.tscn",
	"res://seances/level_13.tscn",
	"res://seances/level_14.tscn",
	"res://seances/level_15.tscn",
	"res://seances/level_16.tscn",

]

func _ready() -> void:
	add_to_group("level_manager")
	_load_level(level)

func _load_level(level_number: int) -> void:

	var level_index = level_number - 1

	if level_index >= LEVELS.size():
		print("You win!")
		get_tree().change_scene_to_file("res://seances/win_screen.tscn")
		return

	if current_level_root:
		current_level_root.queue_free()

	var level_path = LEVELS[level_index]
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
	_load_level(level)

func _on_exit_body_entered(body: Node2D) -> void:
	print("Exit touched by: ", body.name)
	if not body is CharacterBody2D:
		return
	if body.name == "player":
		level += 1
		print("Loading level: ", level)
		call_deferred("_load_level", level)
