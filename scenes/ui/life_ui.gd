extends CanvasLayer

@export var heart_scene: PackedScene
@export var life_manager: LifeManager

@onready var hbox_container: HBoxContainer = %LivesContainer


func _ready() -> void:
	life_manager.lives_changed.connect(_on_lives_changed)
	_render_lives(life_manager.current_lives)


func _render_lives(lives: int) -> void:
	var rendered_hearts = hbox_container.get_children()
	var needed_hearts = lives - rendered_hearts.size()

	if needed_hearts > 0:
		for i in needed_hearts:
			var heart = heart_scene.instantiate()
			hbox_container.add_child(heart)
	elif needed_hearts < 0:
		for i in abs(needed_hearts):
			rendered_hearts.reverse()
			hbox_container.remove_child(rendered_hearts[i])


func _on_lives_changed(current_lives: int, max_lives: int) -> void:
	_render_lives(current_lives)
