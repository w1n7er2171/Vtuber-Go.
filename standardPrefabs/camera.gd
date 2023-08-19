extends CharacterBody3D

@onready var camera = $Camera3D
@onready var ui = get_tree().get_first_node_in_group("UI")

const SPEED = 5.0
const JUMP_VELOCITY = 3.0

var canControl = false
var cameraControl = false
var testArr = []
var look_sens = ProjectSettings.get_setting("player/look_sens")

func _physics_process(delta):

	if Input.is_action_just_pressed("f_4"):
		canControl = !canControl
		testArr.append(cameraControl)
		ui.get_child(0).text = str(testArr, "\n and current: ", canControl)

	if canControl:
		# Handle Jump.
		if Input.is_action_pressed("moveSPACE"):
			velocity.y = JUMP_VELOCITY
		elif Input.is_action_pressed("moveSHIFT"):
			velocity.y = -JUMP_VELOCITY
		else: velocity.y = 0

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("moveA", "moveD", "moveW", "moveS")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()

		if Input.is_action_just_pressed("RMB"):
			cameraControl = !cameraControl
			if cameraControl:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			elif !cameraControl:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

		if Input.is_action_just_released("MWU"):
			camera.fov -= 1
		elif Input.is_action_just_released("MWD"):
			camera.fov += 1

	elif canControl == false:
		cameraControl = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pass

func _input(event):
	if event is InputEventMouseMotion and canControl and cameraControl:
		rotate_y(-event.relative.x * look_sens)
		camera.rotate_x(-event.relative.y * look_sens)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
		pass
