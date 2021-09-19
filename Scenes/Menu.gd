extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass # Replace with function body.

onready var r = $TextureRect
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	

	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")
