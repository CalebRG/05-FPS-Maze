extends Control

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		if visible:
			hide()
			get_tree().paused = false
		else:
			show()
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Quit_pressed():
	get_tree().quit()

func _on_Reload_pressed():
	get_tree().reload_current_scene()
	if visible:
		hide()
		get_tree().paused = false
	
