extends Spatial

var mouseHomingMultiplier : float = 0.01;
var mouseSensitivity : float = 0.05;

onready var target = $Target
onready var pivot = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);

func _input(event):
	if event is InputEventMouseMotion:
		pivot.rotate_y(deg2rad(-event.relative.x * mouseSensitivity))
		rotate_x(deg2rad(-event.relative.y * mouseSensitivity))
		rotation.x = clamp(rotation.x, deg2rad(-90), deg2rad(90))
		
