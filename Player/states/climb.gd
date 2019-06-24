extends "state.gd"

export var SPEED: int = 20
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
  owner.get_node('AnimatedSprite').play('climb-up')
  .enter()

func update(delta):
  if !owner.on_a_climbable:
    emit_signal('request_transition', 'fall')
    return
    
  if Input.is_action_pressed('ui_up'):
    owner.velocity.y = -SPEED
  elif Input.is_action_pressed('ui_down'):
    owner.velocity.y = SPEED * 1.5
  elif Input.is_action_pressed('ui_left') || Input.is_action_pressed('ui_right'):
    owner.velocity.x = -30 if Input.is_action_pressed('ui_left') else 30
    emit_signal('request_transition', 'jump')
    return
  else:
    owner.velocity.y = 0

  if owner.velocity.y < 0:
    owner.get_node('AnimatedSprite').play('climb-up')
  else:
    owner.get_node('AnimatedSprite').play('climb-down')
  .update(delta)
