extends RigidBody

var pitch : float = 8;
var roll : float = 2;
var yaw : float = 8;
var speed : float = 0;

# Manual controls
var m_roll : float = 60;
var m_pitch : float = 70;
var m_yaw : float = 60;

var isEnemy =false

# Variable to toggle manual controls
# Torque is multiplied by it, so if it's 0, no torque will be applied
# Value is 0 if manual controls enabled, or 1 if manual controls disabled
var m_enabled_p : float = 1; 
var m_enabled_r : float = 1; 
var m_enabled_y : float = 1; 

onready var target = get_parent().get_node("TargetPivotPivot/TargetPivot/Target");

var hp = 500

func damage(dmg = 4):
	hp -= dmg
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	keyboardMove(delta);
	
	turnTowards();
	
	# Dampen angular and linear velocity
	add_torque(-angular_velocity * 50);
	
	add_central_force(-linear_velocity);

# Rotate towards the point
func turnTowards():
	# Convert target's location to local world position
	var local = to_local(target.global_transform.origin);

	var enabled : float = m_enabled_r * m_enabled_p * m_enabled_y;
	# Add torque towards the target. This torque should *probably* be the ideal torque, so
	# some counter torque needs to be added if no dampening is added

	# This turns the body in the offset in the y direction around the x axis
	# and the offset in the x direction around the y axis 
	add_torque((local.y * global_transform.basis.x * pitch + -local.x * global_transform.basis.y * yaw) * enabled);
	
	# Roll towards turn
	#print(local.y)
	#if(abs(local.x) >= 1.0):
	#	add_torque(global_transform.basis.z * local.y * 2 * enabled);
	#else:
	#	add_torque(global_transform.basis.z * -rotation.z * 60 * enabled);
	
# Additional keyboard controls
func keyboardMove(delta):
	if(Input.is_key_pressed(KEY_E)):
		yaw(-1);
	elif(Input.is_key_pressed(KEY_Q)):
		yaw(1);
	else:
		m_enabled_y = 1;	
		
	if(Input.is_key_pressed(KEY_W)):
		pitch(-1);
	elif(Input.is_key_pressed(KEY_S)):
		pitch(1);
	else:
		m_enabled_p = 1;	
		
	if(Input.is_key_pressed(KEY_D)):
		roll(-1);
	elif(Input.is_key_pressed(KEY_A)):
		roll(1);
	else:
		m_enabled_r = 1;	
	
	if(Input.is_key_pressed(KEY_SPACE)):
		add_central_force(-global_transform.basis.z * 25);
		
	var currentSpeed = linear_velocity.length();
	add_central_force(-global_transform.basis.z * (speed - currentSpeed));

func yaw(dir : float):
	add_torque(global_transform.basis.y * dir * m_yaw);
	m_enabled_y = 0;
	
func roll(dir : float):
	add_torque(global_transform.basis.z * dir * m_roll);
	m_enabled_r = 0;
	
func pitch(dir : float):
	add_torque(global_transform.basis.x * dir * m_pitch);
	m_enabled_p = 0;
	
