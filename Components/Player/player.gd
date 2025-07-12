extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var move_vector := Vector3.ZERO

func _input(event):
	# Handle analog movement
	if event is InputEventJoypadMotion:
		# Check if this motion event is part of the move action
		if event.is_action("move"):
			# Left stick horizontal movement
			if event.axis == JOY_AXIS_LEFT_X:
				print("X axis: ", event.axis_value)
				move_vector.x = event.axis_value
			# Left stick vertical movement
			elif event.axis == JOY_AXIS_LEFT_Y:
				print("Y axis: ", event.axis_value)
				move_vector.z = event.axis_value

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	if move_vector.length() > 0:
		velocity.x = move_vector.x * SPEED
		velocity.z = move_vector.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
