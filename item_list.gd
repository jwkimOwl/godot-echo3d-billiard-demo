extends ItemList

@onready
var node3d = get_node("/root/Simulator/Node3D")
@onready
var reset_button = get_node("/root/Simulator/Node2D/Control/Button")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	node3d.connect("ball_in",_on_ball_in)
	reset_button.connect("reset_simulation",_reset)
	select_mode = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_ball_in(ball_number):
	print("ball ",ball_number," in")
	if ball_number>0:
		self.select(ball_number-1,false)

func _reset():
	for i in range(15):
		self.deselect(i)
