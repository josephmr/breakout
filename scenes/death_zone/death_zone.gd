extends Area2D
class_name DeathZone


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Ball:
		GameEvents.life_lost.emit()
		body.queue_free()
