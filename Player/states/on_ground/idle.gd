extends 'on_ground.gd'

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
  animatedSprite.animation = 'idle'
  animatedSprite.stop()
  owner.velocity.x = 0
  .enter()

func resume():
  enter()
  .resume()

func update(delta: float):
  if !animatedSprite.playing:
    animationTimer += delta
    if animationTimer >= DELAY_BEFORE_PLAYING_ANIMATION:
      animationTimer -= DELAY_BEFORE_PLAYING_ANIMATION
      animatedSprite.play()
  .update(delta)
  
# TODO trouver quel est la classe des events
func handle_event(event):
  if event.is_action_pressed('jump'):
    emit_signal('request_transition', 'jump')
  if event.is_action_pressed('ui_left') || event.is_action_pressed('ui_right'):
    emit_signal('request_transition', 'run')
  if event.is_action_pressed('ui_up') && owner.on_a_climbable:
    emit_signal('request_transition', 'climb')
  .handle_event(event)

func on_animation_finished(anim_name):
  animatedSprite.frame = 0
  animatedSprite.stop()
