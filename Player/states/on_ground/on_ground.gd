extends "res://Player/states/state.gd"

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
  owner.velocity.y = 10

func update(delta): 
  if owner.velocity.x != 0:
    owner.get_node('AnimatedSprite').flip_h = owner.velocity.x < 0
  .update(delta)

  if !owner.is_on_floor():
    emit_signal('request_transition', 'fall')
  .update(delta)
  
func handle_event(event):
  if event.is_action_pressed('jump'):
    emit_signal('request_transition', 'jump')
  .handle_event(event)
