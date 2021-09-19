extends Spatial

var startRot;
#onready var aircraft = get_parent().get_node("Aircraft");

# Called when the node enters the scene tree for the first time.
func _ready():
	startRot = global_transform.basis;


