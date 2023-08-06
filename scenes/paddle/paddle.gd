extends CharacterBody2D
class_name Paddle

const ACCELERATION = 25
const MAX_SPEED = 160


func _physics_process(delta: float) -> void:
	var x_axis = Input.get_axis("move_left", "move_right")
	if x_axis:
		velocity.x += x_axis * ACCELERATION
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	else:
		var left = velocity.x < 0
		velocity.x += sign(velocity.x) * -1 * ACCELERATION
		velocity.x = min(0, velocity.x) if left else max(0, velocity.x)

	move_and_collide(velocity * delta)
