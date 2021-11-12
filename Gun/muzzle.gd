extends Sprite3D


func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		if not visible:
			show()


func _on_Timer_timeout():
	var sprite = get_node_or_null("Pivot/Gun/Sprite3D")
