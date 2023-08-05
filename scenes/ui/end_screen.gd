extends CanvasLayer
class_name EndScreen

@export var success: bool = true

@onready var title_label: Label = %TitleLabel
@onready var continue_button: Button = %ContinueButton
@onready var level_select_button: Button = %LevelSelectButton
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	get_tree().paused = true
	if not success:
		title_label.text = "You Lost! :("
		continue_button.text = "Retry"
	continue_button.pressed.connect(_on_continue_button_pressed)
	level_select_button.pressed.connect(_on_level_select_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_continue_button_pressed() -> void:
	pass


func _on_level_select_button_pressed() -> void:
	pass
