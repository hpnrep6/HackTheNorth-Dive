extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var p = $RichTextLabel
onready var c = $RichTextLabel2
onready var e = $End
onready var s = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	s.stream = Global.e
	pass # Replace with function body.

var t = 10
var pl = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if (Global.player):
		var hp = Global.player.get_node("Aircraft").hp
		
		
		if (hp <= 0):
			e.visible = true
			t -= delta
			
			if (!pl):
				pl = true
				s.play()
				
			if (t < 0):
				t = 100
				end()
				return

		p.text = str(max(0,hp))
		
	if (Global.core):
		
		var hp = Global.core.hp
		
		
		if (hp <= 0):
			e.visible = true
			t -= delta
			
			if (!pl):
				pl = true
				s.play()
				
			if (t < 0):
				t = 100
				end()
				return
				
		c.text = str(max(hp, 0))
		
func end():
	get_tree().change_scene("res://Scenes/Menu.tscn")
