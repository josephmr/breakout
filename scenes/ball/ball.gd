extends CharacterBody2D
class_name Ball

@export var speed = 200


func _ready() -> void:
	velocity = Vector2.DOWN * speed


func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if not collision:
		return

	var collider = collision.get_collider()
	if collider is Paddle:
		velocity = velocity.bounce(collision.get_normal())
		# If we collide with top face of paddle, then rotate bounce based on distance from center
		# to give player more control over direction of ball
		if collision.get_normal() == Vector2.UP:
			var shape = collision.get_collider_shape() as CollisionShape2D
			var distance = shape.global_position.x - collision.get_position().x
			velocity = velocity.rotated(deg_to_rad(distance / -2.))
	else:
		velocity = velocity.bounce(collision.get_normal())

	if collider is Brick:
		collider.hit()
