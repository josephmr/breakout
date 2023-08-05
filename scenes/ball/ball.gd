extends CharacterBody2D
class_name Ball

@export var speed = 200

@onready var trail_particles: GPUParticles2D = $TrailParticles

var idle := true


func _ready() -> void:
	trail_particles.emitting = false
	_attach_to_paddle()


func _attach_to_paddle() -> void:
	var paddle = get_tree().get_first_node_in_group("paddle")
	if paddle:
		global_position = paddle.global_position + Vector2.UP * 12


func _handle_idle() -> void:
	if Input.is_action_just_pressed("start"):
		idle = false
		velocity = Vector2.UP * speed
		trail_particles.emitting = true
	else:
		_attach_to_paddle()


func _physics_process(delta: float) -> void:
	if idle:
		_handle_idle()
		return

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
