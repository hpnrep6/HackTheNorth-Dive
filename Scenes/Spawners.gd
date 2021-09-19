extends Spatial

onready var enemies = get_parent().get_node("Enemies")

onready var e1 = preload("res://Scenes/Enemy.tscn")
onready var e2 = preload("res://Scenes/Enemy2.tscn")
onready var e3 = preload("res://Scenes/Enemy3.tscn")
onready var e4 = preload("res://Scenes/Enemy4.tscn")

onready var sP = get_children()

var eA = []
# Called when the node enters the scene tree for the first time.
func _ready():
	eA = [e1, e2, e3, e4]

var cD = 10
var t = 5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t -= delta
	
	if (t < 0):
		t = cD
		cD -= 0.5
		cD = max(3, cD)
		spawn()

onready var rN = RandomNumberGenerator.new()

func spawn():

	rN.randomize()
	
	var r = rN.randi_range(0, 3)

	var e = eA[r].instance()
	
	enemies.add_child(e)
	
	rN.randomize()
	var p = rN.randi_range(0, sP.size() - 1)
	var loc = sP[p]
	
	e.transform.origin = loc.global_transform.origin
	
