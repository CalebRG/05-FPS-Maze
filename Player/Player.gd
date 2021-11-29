extends KinematicBody

onready var Camera = $Pivot/Camera
onready var rc = $Pivot/RayCast
onready var flash = $Pivot/Gun/Flash
onready var Decal = preload("res://Player/Decal.tscn")

var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002
var mouse_range = 1.2

var velocity = Vector3()

func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("forward"):
		input_dir += -Camera.global_transform.basis.z
	if Input.is_action_pressed("back"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_pressed("left"):
		input_dir += -Camera.global_transform.basis.x
	if Input.is_action_pressed("right"):
		input_dir += Camera.global_transform.basis.x
	if Input.is_action_just_pressed("flash"):
		if $Pivot/SpotLight.is_visible():
			$Pivot/SpotLight.hide()
		else:
			$Pivot/SpotLight.show()
	if Input.is_action_just_pressed("test"):
		get_tree().reload_current_scene()
	input_dir = input_dir.normalized()
	return input_dir
	

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)

func _physics_process(delta):
	velocity.y += gravity * delta
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if Input.is_action_just_pressed("shoot") and !flash.visible:
		flash.shoot()
		var sound = get_node_or_null("/root/Game/GUN")
		if sound != null:
			sound.playing = true
		if rc.is_colliding():
			var c = rc.get_collider()
			var decal = Decal.instance()
			rc.get_collider().add_child(decal)
			decal.global_transform.origin = rc.get_collision_point()
			decal.look_at(rc.get_collision_point() + rc.get_collision_normal(), Vector3.UP)
			if c.is_in_group("Enemy"):
				sound = get_node_or_null("/root/Game/ZombieScreech")
				if sound != null:
					sound.playing = true
				c.queue_free()
