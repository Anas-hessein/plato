extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.name != "player":
		return
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").set_deferred("disabled", true)
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().get_first_node_in_group("level_manager").call_deferred("_respawn")
