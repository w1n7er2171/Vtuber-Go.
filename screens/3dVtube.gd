extends Node3D

@onready var UI = $UI

const ScreenResolution = Vector2(1280,720)

func _init():
	DisplayServer.window_set_size(ScreenResolution)

func _ready():
	UI.visible = false

func _input(event):
	if Input.is_action_just_pressed("f_3"):
		UI.visible = !UI.visible
		if UI.visible:
			$billboardMesh.mesh.material.albedo_color = Color(0, 1, 0) # giving color to chromakey
			$billboardMesh.mesh.size = Vector2(4,4) # making chromakey a 4 by 4 meter square
		elif !UI.visible:
			pass
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		pass

func _process(delta):
	pass
