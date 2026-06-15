extends CharacterBody2D

const SPEED = 60
var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var ray_cast_floor_left: RayCast2D = $RayCastFloorLeft
@onready var ray_cast_floor_right: RayCast2D = $RayCastFloorRight
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Flip on wall collision
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false

	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true

	# Flip when no floor ahead (edge detection)
	if not ray_cast_floor_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false

	if not ray_cast_floor_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true

	velocity.x = direction * SPEED
	move_and_slide()
