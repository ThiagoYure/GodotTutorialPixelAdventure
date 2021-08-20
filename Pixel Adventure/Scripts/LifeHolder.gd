extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var life_size = 32

# Called when the node enters the scene tree for the first time.
func on_change_life(player_health):
	$icon.rect_size.x = player_health * life_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
