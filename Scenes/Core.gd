extends Spatial

var isCore = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var l = $OmniLight
onready var d = $OmniLight2
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.core = self

var tD = 0
var hp = 300

func damage():
	tD = 0.5
	l.visible = false
	d.visible = true
	hp -= 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (tD > 0):
		tD -= delta
		
		if (tD <= 0):
			l.visible = true
			d.visible = false
