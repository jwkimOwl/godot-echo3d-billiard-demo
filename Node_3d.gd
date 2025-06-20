extends Node3D


signal ball_in

var ball_nodes = []
var balls_on_table = []

var ball_position=[	Vector3(0, 16, -12),
					Vector3(0.77*(0),	16,	8+1.33*0),
					Vector3(0.77*(-1),	16,	8+1.33*1),
					Vector3(0.77*(1),	16,	8+1.33*1),
					Vector3(0.77*(-2),	16,	8+1.33*2),
					Vector3(0.77*(0),	16,	8+1.33*2),
					Vector3(0.77*(2),	16,	8+1.33*2),
					Vector3(0.77*(-3),	16,	8+1.33*3),
					Vector3(0.77*(-1),	16,	8+1.33*3),
					Vector3(0.77*(1),	16,	8+1.33*3),
					Vector3(0.77*(3),	16,	8+1.33*3),
					Vector3(0.77*(-4),	16,	8+1.33*4),
					Vector3(0.77*(-2),	16,	8+1.33*4),
					Vector3(0.77*(0),	16,	8+1.33*4),
					Vector3(0.77*(2),	16,	8+1.33*4),
					Vector3(0.77*(4),	16,	8+1.33*4),]

@onready
var in_detector = get_node("InDetector")
@onready
var reset_button = get_node("/root/Simulator/Node2D/Control/Button")
var table_node
var table_node_load:PackedScene



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_node("/root/Simulator/AssetLoader").asset_downloaded
	load_table()
	load_balls()
	in_detector.connect("body_entered",_on_hole_in)
	reset_button.connect("reset_simulation",_on_reset_simulation)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func load_table():
	print("start loading table")
	var gltf_document := GLTFDocument.new()
	var gltf_state := GLTFState.new()
	var error := gltf_document.append_from_file("res://assets/Billiard Table.glb", gltf_state)
	if error != OK:
		return
	
	var glb_model = gltf_document.generate_scene(gltf_state)
	glb_model.position=Vector3(0,8,0)
	glb_model.scale=Vector3(20,20,20)
	
	add_child(glb_model)
	'''
	var table_material = PhysicsMaterial.new()

	# Enable absorbency
	table_material.absorbent = true
	table_material.bounce=0.2
	

	# Assign the material to your object
	var tabletop_material=glb_model
	tabletop_material=glb_model.get_node("Sketchfab_model")
	tabletop_material=glb_model.get_node("Sketchfab_model").get_node("root")
	tabletop_material=glb_model.get_node("Sketchfab_model").get_node("root").get_node("GLTF_SceneRootNode")
	tabletop_material=glb_model.get_node("Sketchfab_model").get_node("root").get_node("GLTF_SceneRootNode").get_node("Tabletop_1-col")
	tabletop_material=glb_model.get_node("Sketchfab_model").get_node("root").get_node("GLTF_SceneRootNode").get_node("Tabletop_1-col").get_node("Object_8-col")
	#tabletop_material.physics_material_override = table_material # Replace $Ball with the path to your object

	add_child(glb_model)
	print(glb_model.get_tree_string_pretty())
	#return
	table_node_load=load("res://assets/Billiard Table.glb")
	while table_node_load == null:
		await get_tree().create_timer(0.1).timeout
		table_node_load=load("res://assets/Billiard Table.glb")
		print("still null")
	table_node=table_node_load.instantiate()
	table_node.position=Vector3(0,8,0)
	table_node.scale=Vector3(20,20,20)
	# Create a new PhysicsMaterial
	add_child(table_node)
	visible = true
'''

func load_balls():
	for i in range(16):
		print("start loading ball ",i)
		var ball_node=preload("./ball.tscn").instantiate()
		ball_node.ball_number = i
		ball_node.position = ball_position[i]
		ball_nodes.append(ball_node)
		balls_on_table.append(true)
		add_child(ball_node)
		visible = true

func _on_hole_in(body) :
	#print(body.get_class())
	if body.get_class() == "RigidBody3D":
		remove_child(body)
		emit_signal("ball_in",body.ball_number)
	pass

func _on_reset_simulation():
	for item in get_children():
		if item.get_class() == "RigidBody3D":
			remove_child(item)
	load_balls()
