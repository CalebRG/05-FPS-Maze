extends KinematicBody

export var speed = 100
var space_state
var target

func _ready():
	space_state = get_world().direct_space_state
	$AnimationPlayer.play("Run")
	$AnimationPlayer.play("Idle")

func _physics_process(delta):
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider.is_in_group("Player"):
			look_at(target.global_transform.origin, Vector3.UP)
			$AnimationPlayer.play("Run")
			move_to_target(delta)
		else:
			$AnimationPlayer.play("Idle")


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		target = body
		print(body.name + " entered")

func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		target = null
		$AnimationPlayer.play("Idle")
		print(body.name + " exited")
		

func move_to_target(delta):
	var direction = (target.transform.origin - transform.origin).normalized()
	move_and_slide(direction * speed * delta, Vector3.UP)
	
func set_color_red():
	null

func set_color_green():
	null

func _on_Killzone_body_entered(body):
	if body.is_in_group("Bullet"):
		queue_free()
