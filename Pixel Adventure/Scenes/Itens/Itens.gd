extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_itens_body_entered(body):
	$Anim.play("collected")


func _on_Anim_animation_finished(anim_name):
	if anim_name == "collected":
		queue_free()
