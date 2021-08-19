extends KinematicBody2D

var up = Vector2.UP
var velocity = Vector2.ZERO
var move_speed = 400
var gravity = 1200
var jump_force = -360
var is_grounded
var health = 3
var hurted = false

var knockback_dir = 1
var knockback_int = 600

onready var raycasts = $Raycasts

func _ready():
	pass

func _physics_process(delta:float)->void:
	velocity.y += gravity *delta
	velocity.x = 0
	if !hurted:
		_get_input()
		
	velocity = move_and_slide(velocity,up)
	
	is_grounded = _check_is_ground()
	
	for plataforms in get_slide_count():
		var collision = get_slide_collision(plataforms)
		if collision.collider.has_method("collide_with"):
			collision.collider.collide_with(collision, self)
			
	
	_set_animation()

func _get_input():
	velocity.x = 0
	var move_direction = int(Input.is_action_pressed("move_right"))-int(Input.is_action_pressed("move_left"))
	velocity.x = lerp(velocity.x, move_speed * move_direction, 0.2)
	
	if move_direction !=0:
		$Texture.scale.x = move_direction
		knockback_dir = move_direction

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
	if velocity.y > 0 and !is_grounded:
		anim = "Fall" 
	if hurted :
		anim = "hit"
	if $AnimationPlayer.assigned_animation != anim:
		$AnimationPlayer.play(anim) 


func _knockback():
	velocity.x = -knockback_dir * knockback_int
	velocity = move_and_slide(velocity)

func _on_Hurtbox_body_entered(body):
	health -= 1
	hurted = true
	_knockback()
	get_node("Hurtbox/collision").set_deferred("disabled", true)
	yield(get_tree().create_timer(0.5),"timeout")
	get_node("Hurtbox/collision").set_deferred("disabled", false)
	hurted = false
	if health < 1:
		queue_free()
		get_tree().reload_current_scene()
