extends Timer


func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		$Sprite3D.show()
