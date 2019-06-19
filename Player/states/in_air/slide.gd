extends "in_air.gd"

# Jumps
export var GRAVITY: int = 10
export var JUMP_IMPLUSE: int = 30
var direction: int
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func enter():
	owner.get_node('AnimatedSprite').animation = 'slide'
	owner.get_node('AnimatedSprite').stop()
	# air_jump_count = 0
	direction = owner.get_slide_collision(0).normal.x
	owner.velocity.x /= 10
	owner.get_node('AnimatedSprite').flip_h = direction < 0
	.enter()

func leave():
	owner.get_node('AnimatedSprite').flip_h = owner.velocity.x < 0
	.leave()

func handle_event(event):
	if event.is_action_pressed('jump'):
		owner.velocity.x = JUMP_IMPLUSE * direction
		emit_signal('request_transition', 'jump')
	if event.is_action_pressed('ui_down'):
		owner.velocity.x = 0
		emit_signal('request_transition', 'fall')
	.handle_event(event)

func update(delta):
	owner.velocity.y += GRAVITY
	owner.velocity.y *= 0.5
	if !owner.is_on_wall():
		emit_signal('request_transition', 'fall')
	.update(delta)
