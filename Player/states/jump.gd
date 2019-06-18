extends "res://Player/states/state.gd"

# Jumps
export var JUMP_POWER: int = 60
export var MAX_JUMP_TIME: float = 0.1
export var GRAVITY: int = 10
export var MAX_AIR_JUMP = 1

var air_jump_count = 0
var remaining_jump_time = 0
var animatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	animatedSprite = owner.get_node('AnimatedSprite')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func enter():
	animatedSprite.frame = 0
	animatedSprite.animation = 'jump'
	animatedSprite.stop()
	owner.velocity.y = -JUMP_POWER
	remaining_jump_time = MAX_JUMP_TIME
	.enter()

func update(delta):
	if Input.is_action_pressed('jump') && remaining_jump_time > 0:
		remaining_jump_time -= delta
	else:
		owner.velocity.y += GRAVITY
		if owner.velocity.y < 0:
			animatedSprite.frame = 1
		else:
			animatedSprite.frame = 2

	if owner.is_on_floor():
		owner.velocity.y = 0
		air_jump_count = 0
		emit_signal('request_transition', 'idle')

func handle_event(event):
	if event.is_action_pressed('jump') && air_jump_count < MAX_AIR_JUMP:
		air_jump_count += 1
		enter()

func resume():
	animatedSprite.animation = 'jump'
	.resume()