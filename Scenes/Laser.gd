extends MeshInstance


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var hitEnemy = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
var time = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform.origin.z -= 100 * delta
	time += delta
	
	if time > 2:
		get_parent().queue_free()



func _on_Area_body_entered(body):
	if (body.get("isEnemy") != null):
		if (body.isEnemy == hitEnemy):
			body.damage()
			get_parent().queue_free()
	else:
		get_parent().queue_free()
