extends KinematicBody2D

export var MOTION_SPEED = 50
const IDLE_SPEED = 10
var RayNode
var PlayerAnimNode
var anim = ""
var animNew = ""


func _ready():
	set_physics_process(true)
	RayNode = get_node("RayCast2D")
	PlayerAnimNode = get_node("AnimatedSprite")
	
func _physics_process(delta):
	
	var motion = Vector2()
	
	if (Input.is_action_pressed("ui_up")):
		motion += Vector2(0, -1)
		RayNode.set_rotation_degrees(180)
		
	if (Input.is_action_pressed("ui_down")):
		motion += Vector2(0, 1)
		RayNode.set_rotation_degrees(0)
	if ( Input.is_action_pressed("ui_left")):
		motion += Vector2(-1, 0)
		RayNode.set_rotation_degrees(-90)
		
	if ( Input.is_action_pressed("ui_right")):
		motion += Vector2(1, 0)
		RayNode.set_rotation_degrees(90)
	
	motion = motion.normalized()*MOTION_SPEED*delta
	move_and_collide(motion)
	
	if(motion.length() > IDLE_SPEED * 0.009):
		
		if (Input.is_action_pressed("ui_up")):
			anim="Walk_U"
		if (Input.is_action_pressed("ui_down")):
			anim="Walk_D"
		if ( Input.is_action_pressed("ui_left")):
			anim="Walk_L"
		if ( Input.is_action_pressed("ui_right")):
			anim="Walk_R"
		
	else:
		if (RayNode.get_rotation_degrees() == 180):
			anim = "Idle_U"
		if (RayNode.get_rotation_degrees() == 0):
			anim = "Idle_D"
		if (RayNode.get_rotation_degrees() == -90):
			anim = "Idle_L"
		if (RayNode.get_rotation_degrees() == 90):
			anim = "Idle_R"
	
	if anim != animNew:
		animNew = anim
		PlayerAnimNode.play(anim)
