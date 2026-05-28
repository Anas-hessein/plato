extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	if body.name != "player":
		return
	print("you dead")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").set_deferred("disabled", true)  # ← disable, not free
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().get_root().get_node("levels").call_deferred("_respawn")
