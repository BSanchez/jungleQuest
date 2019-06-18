extends 'res://Player/states/state.gd'

export var DELAY_BEFORE_PLAYING_ANIMATION: int = 5

var animationTimer: float = 0
var animatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	animatedSprite = owner.get_node('AnimatedSprite')
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func enter():
	animatedSprite.frame = 0
	animatedSprite.play('idle')
	.enter()

func resume():
	enter()
	.resume()

func update(delta: float):
	if animatedSprite.playing:
		return

	animationTimer += delta
	if animationTimer >= DELAY_BEFORE_PLAYING_ANIMATION:
		animationTimer -= DELAY_BEFORE_PLAYING_ANIMATION
		animatedSprite.play()

# TODO trouver quel est la classe des events
func handle_event(event):
	if event.is_action_pressed('jump'):
		emit_signal('request_transition', 'jump')
	.handle_event(event)

func on_animation_finished(anim_name):
	animatedSprite.frame = 0
	animatedSprite.stop()
