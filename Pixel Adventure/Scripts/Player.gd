extends KinematicBody2D

var velocity = Vector2.ZERO
var move_speed = 400
var gravity = 1200
var jump_force = -360
var is_grounded
onready var raycasts = $Raycasts

func _ready():
	pass

func _physics_process(delta:float)->void:
	velocity.y += gravity *delta
	_get_input()
		
	velocity = move_and_slide(velocity)
	
	is_grounded = _check_is_ground()
	
	_set_animation()

func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right"))-int(Input.is_action_pressed("move_left"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
	if move_direction !=0:
		$Texture.scale.x = move_direction

func _input(event):
	if event.is_action_pressed("jump") and is_grounded:
		velocity.y = jump_force

func _check_is_ground():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func _set_animation():
	var anim = "idle"
	if !is_grounded:
		anim = "jump"
	elif velocity.x != 0:
		anim = "run"
	if $AnimationPlayer.assigned_animation != anim:
		$AnimationPlayer.play(anim) 