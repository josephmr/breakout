extends StaticBody2D
class_name Brick

@export_range(1, 10) var hits: int = 1
@export var cracks: CompressedTexture2D
@onready var _hits: int = 0

@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	var sprite_2d_material = sprite_2d.material
	if sprite_2d_material is ShaderMaterial:
		if sprite_2d.region_enabled:
			var rect = sprite_2d.region_rect
			sprite_2d_material.set_shader_parameter("region", true)
			sprite_2d_material.set_shader_parameter(
				"region_rect", Vector4(rect.position.x, rect.position.y, rect.size.x, rect.size.y)
			)
			sprite_2d_material.set_shader_parameter("cracks", cracks)


func hit() -> void:
	_hits += 1
	if _hits >= hits:
		GameEvents.brick_destroyed.emit()
		queue_free()

	var sprite_2d_material = sprite_2d.material
	if sprite_2d_material is ShaderMaterial:
		sprite_2d_material.set_shader_parameter("hits", float(_hits) / (hits - 1))
