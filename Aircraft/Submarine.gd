extends Spatial

onready var l1 = $Aircraft/L1
onready var l2 = $Aircraft/L2
onready var laser = preload("res://Scenes/Laser.tscn")
onready var aircraft = $Aircraft
onready var p = $AudioStreamPlayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self
	p.stream = Global.l1
	p.pitch_scale = 0.8
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("m1"):
		fire()
	pass

func fire():
	var laserf = laser.instance()
	add_child(laserf)
	laserf.transform.origin = l1.global_transform.origin
	laserf.transform.basis = aircraft.transform.basis
	
	laserf = laser.instance()
	add_child(laserf)
	laserf.transform = l2.global_transform
	
	p.play()
