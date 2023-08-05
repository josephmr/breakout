extends Node2D

@export var life_manager: LifeManager
@export var end_screen_scene: PackedScene

@onready var bricks: TileMap = $Bricks
@onready var total_bricks: int = bricks.get_used_cells(0).size()


func _ready() -> void:
	GameEvents.brick_destroyed.connect(_on_brick_destroyed)
	life_manager.game_over.connect(_on_life_manager_game_over)


func _show_end_screen(success: bool = true) -> void:
	var end_screen = end_screen_scene.instantiate() as EndScreen
	end_screen.success = success
	add_child(end_screen)


func _on_life_manager_game_over() -> void:
	_show_end_screen(false)


func _on_brick_destroyed() -> void:
	total_bricks -= 1
	if total_bricks == 0:
		_show_end_screen()
