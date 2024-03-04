extends CharacterBody3D
class_name Character

@export_category("Variables")
@export var _gravity: float = 9.8
@export var _walk_speed: float = 2.0
@export var _jump_speed: float = 7.0

@export_category("Objects")
@export var _body: CharacterBody
@export var _camera_offset: CharacterCamera

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
func _physics_process(_delta: float) -> void:
	if not is_on_floor():
		velocity.y -= _gravity * _delta
		
	_jump()
	_move()
	move_and_slide()
	#_body.animate(velocity)
	
	
func _move() -> void:
	var _input_direction: Vector2 = (
		Input.get_vector(
			"move_left", "move_right", 
			"move_forward", "move_backward"
		)
	)
	
	var _direction: Vector3 = transform.basis * Vector3(
		_input_direction.x, 0, _input_direction.y
	).normalized()
	
	_direction = _direction.rotated(Vector3.UP, _camera_offset.rotation.y)
	
	if _direction:
		velocity.x = _direction.x * _walk_speed
		velocity.z = _direction.z * _walk_speed
		_body.apply_rotation(velocity)
		return
		
	velocity.x = move_toward(velocity.x, 0, _walk_speed)
	velocity.z = move_toward(velocity.z, 0, _walk_speed)
	
	
func _jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = _jump_speed
