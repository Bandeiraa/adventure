extends Node3D
class_name CharacterCamera

const _MOUSE_SENSIBILITY: float = 0.003

@export_category("Variables")
@export var _y_min_rotation: float = 15
@export var _y_max_rotation: float = -45

@export_category("Objects")
@export var _offset: Node3D = null

func _unhandled_input(_event) -> void:
	if _event is InputEventMouseMotion:
		rotate_y(-_event.relative.x * _MOUSE_SENSIBILITY)
		_offset.rotate_x(-_event.relative.y * _MOUSE_SENSIBILITY)
		_offset.rotation.x = clamp(
			_offset.rotation.x, 
			deg_to_rad(_y_max_rotation), 
			deg_to_rad(_y_min_rotation)
		)
