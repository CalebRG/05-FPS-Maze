extends Area



func _on_Area_body_entered(body):
	if body.name == "Player":
		var exit = get_node_or_null("/root/Game/Maze/Exit")
		if exit != null:
			exit.unlock()
			queue_free()


func _ready():
	$AnimationPlayer.play("Spin")
