extends "on_ground.gd"

export var SPEED: int = 50
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func enter():
	owner.get_node('AnimatedSprite').play('run')
	.enter()

func update(delta):
	if Input.is_action_pressed('ui_right'):
		owner.velocity.x = SPEED
	elif Input.is_action_pressed('ui_left'):
		owner.velocity.x = -SPEED
	else:
		emit_signal('request_transition', 'idle')

	.update(delta)
