extends Spatial

var space_state
var target


func _ready():
	space_state = get_world().direct_space_state


func _physics_process(delta):
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider.is_in_group("Player"):
			look_at(target.global_transform.origin, Vector3.UP)
