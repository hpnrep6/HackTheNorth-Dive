extends RigidBody

export var targetPlayer = true

export var pitch : float = 20;
export var roll : float = 20;
export var yaw : float = 20;
export var speed : float = 20;

export var coolDown : float = 1;

onready var laser = preload("res://Scenes/ELaser.tscn")

var isEnemy = true

onready var f = $Spatial
export var hp = 100

var offset = 1000
# Variable to toggle manual controls
# Torque is multiplied by it, so if it's 0, no torque will be applied
# Value is 0 if manual controls enabled, or 1 if manual controls disabled
var m_enabled_p : float = 1; 
var m_enabled_r : float = 1; 
var m_enabled_y : float = 1; 

func damage(dmg = 20):
	hp -= dmg
	if (hp <= 0):
		queue_free()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	turnTowards();
	
	# Dampen angular and linear velocity
	add_torque(-angular_velocity * 50);
	
	add_central_force(-linear_velocity);
	
	var currentSpeed = linear_velocity.length();
	add_central_force(-global_transform.basis.z * (speed - currentSpeed));
	
	shoot(delta)

var time = 0
onready var a = $AudioStreamPlayer3D

func _ready():
	a.stream = Global.l2
	a.max_db = 5.0
	
func shoot(delta):
	if (!targetPlayer):
		return
	
	time -= delta
	#print(offset)
	if (offset >= 3):
		return
		
	if (time < 0):
		time = coolDown
		a.play()
		var l = laser.instance()
		get_parent().add_child(l)
		l.transform.origin = f.global_transform.origin
		l.transform.basis = transform.basis
		

# Rotate towards the point
func turnTowards():
	var target
	if (targetPlayer):
		target = Global.player
	else:
		target = Global.core
	
	if (!target):
		return
	
	if (targetPlayer):
		target = target.get_node("Aircraft")

	# Convert target's location to local world position
	var local = to_local(target.global_transform.origin);

	offset = abs(local.x) + abs(local.y)

	var enabled : float = m_enabled_r * m_enabled_p * m_enabled_y;
	# Add torque towards the target. This torque should *probably* be the ideal torque, so
	# some counter torque needs to be added if no dampening is added
	local.x = min(local.x, 5)
	local.y = min(local.y, 5)
	# This turns the body in the offset in the y direction around the x axis
	# and the offset in the x direction around the y axis 
	add_torque((local.y * global_transform.basis.x * pitch + -local.x * global_transform.basis.y * yaw) * enabled);

	# Roll towards turn
	#print(local.y)
	#if(abs(local.x) >= 1.0):
	#	add_torque(global_transform.basis.z * local.y * 2 * enabled);
	#else:
	#	add_torque(global_transform.basis.z * -rotation.z * 60 * enabled);

