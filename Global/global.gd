extends Node

var player
var core

onready var l1 = load("res://Audio/l1.ogg")
onready var l2 = load("res://Audio/l2.wav")
onready var e = load("res://Audio/end.wav")
onready var s = load("res://Audio/specter.ogg")

var a 

func _ready():
	a = AudioStreamPlayer.new()
	add_child(a)
	a.stream = s
	a.volume_db = -8
	a.play()
	pass
