extends Node2D

onready var plataform = $plataform
onready var tween = $tween

export var speed = 3.0
export var horizontal = true
export var distance = 160

var follow = Vector2.ZERO

const WAIT_DURATION = 1.0


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_start_tween()

func _start_tween():
	var move_direction = Vector2.RIGHT * distance if horizontal else Vector2.UP * distance
	var duration = move_direction.length() / float(speed * 16)
	tween.interpolate_property(
		self, "follow", Vector2.ZERO, move_direction, 
		duration,Tween.TRANS_LINEAR, tween.EASE_IN_OUT, WAIT_DURATION
	)
	tween.interpolate_property(
		self, "follow", move_direction, Vector2.ZERO, 
		duration,Tween.TRANS_LINEAR, tween.EASE_IN_OUT, duration + WAIT_DURATION * 2
	)
	tween.start()
	
func _physics_process(delta):
	plataform.position = plataform.position.linear_interpolate(follow, 0.05)
