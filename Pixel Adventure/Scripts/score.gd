extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	text = "000" + String(GameManager.fruits)
	if GameManager.fruits >= 10:
		text = "00" + String(GameManager.fruits)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
