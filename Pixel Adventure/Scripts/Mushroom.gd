extends KinematicBody2D

export var speed = 64
export var health = 1
var velocity  = Vector2.ZERO
var move_direction = -1
var gravity = 1200
var hitted = false

func _physics_process(delta):
	velocity.x = speed * move_direction
	velocity.y += gravity * delta
	
	if move_direction == 1:
		$Texture.flip_h = true
	else:
		$Texture.flip_h = false
	_set_animation()
	velocity = move_and_slide(velocity)

func _on_Anim_animation_finished(anim_name):
	if anim_name == "Idle":
		$RayCast2D.scale.x *= -1
		move_direction *= -1
		$Anim.play("Run")


func _set_animation():
	var anim = "Run"
	if $RayCast2D.is_colliding():
		anim = "Idle"
	elif velocity.x != 0:
		anim = "Run"
	if hitted:
		anim = "Hit" 
	if $Anim.assigned_animation != anim:
		$Anim.play(anim) 

func _on_Hitbox_body_entered(body):
	hitted = true
	health -= 1
	body.velocity.y = body.jump_force/2
	yield(get_tree().create_timer(0.2), "timeout")
	hitted = false
	if health < 1:
		queue_free()
		get_node("Hitbox/collision").set_deferred("disabled", true)
