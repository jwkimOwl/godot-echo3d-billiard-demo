extends RigidBody3D

var ball_number
var force=null
var init_mouse_drag_position=null
var held=false
var force_arrow
@onready
var camera = get_node("/root/Simulator/Node3D/Camera3D")
@onready
var in_detector = get_node("/root/Simulator/Node3D/InDetector")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	var gltf_document := GLTFDocument.new()
	var gltf_state := GLTFState.new()
	var error
	if ball_number == 0:
		error = gltf_document.append_from_file("res://assets/Billiard Ball Clube.glb", gltf_state)
	else:
		error = gltf_document.append_from_file("res://assets/Billiard Ball "+str(ball_number)+".glb", gltf_state)
	
	var glb_model = gltf_document.generate_scene(gltf_state)
	visible=true
	glb_model.scale=Vector3(0.04,0.04,0.04)
	
	add_child(glb_model)
	visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not held and force != null:
		apply_impulse(force/30)
		force=null
		init_mouse_drag_position=null
		remove_child(force_arrow)
	



func _on_ball_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseMotion:
		if event.button_mask==1:
			if init_mouse_drag_position == null:
				init_mouse_drag_position=event_position
				force_arrow=Line2D.new()
				force_arrow.set_points([camera.unproject_position(position),camera.unproject_position(position)])
				add_child(force_arrow)
			force=event_position-init_mouse_drag_position
			force_arrow.set_points([camera.unproject_position(position),camera.unproject_position(position)+20*Vector2(-force.z,force.x)])
			held=true
	else:
		held=false
		remove_child(force_arrow)
