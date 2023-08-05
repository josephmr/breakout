extends Node
class_name LifeManager

signal lives_changed(current_lives: int, max_lives: int)
signal game_over

@export_range(1, 10) var max_lives: int = 1
@export var ball_scene: PackedScene

@onready var current_lives = max_lives


func _ready() -> void:
	GameEvents.life_lost.connect(_on_life_lost)
	_spawn_ball()


func _spawn_ball() -> void:
	var ball = ball_scene.instantiate()
	owner.add_child.call_deferred(ball)


func _on_life_lost() -> void:
	if current_lives == 0:
		return

	current_lives -= 1
	lives_changed.emit(current_lives, max_lives)
	if current_lives == 0:
		game_over.emit()
	else:
		_spawn_ball()
