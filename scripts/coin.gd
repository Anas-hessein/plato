extends Area2D

@onready var hud: Node = %HUD
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var collected: bool = false  # ← flag

func _on_body_entered(body: Node2D) -> void:
	if body.name != "player":
		return
	if collected:  # ← ignore if already collected
		return
	collected = true
	$CollisionShape2D.set_deferred("disabled", true)
	hud.add_point()
	animation_player.play("pickuo")
	await animation_player.animation_finished
	queue_free()
