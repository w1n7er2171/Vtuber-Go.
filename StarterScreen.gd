extends Control

const ScreenResolution = Vector2(640,480)

func _init():
	DisplayServer.window_set_size(ScreenResolution)
	pass

func _on_load_pressed():
	get_tree().change_scene_to_file("res://screens/3dVtube.tscn")
	pass # Replace with function body.
