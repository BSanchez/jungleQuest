extends "res://Player/states/state.gd"

export var MAX_AIR_JUMP = 1
var air_jump_count = 0
var remaining_jump_time = 0

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
  .enter()

func update(delta):
  if owner.is_on_floor():
    owner.velocity.y = 0
    air_jump_count = 0
    emit_signal('request_transition', 'run')



func handle_event(event):
  if event.is_action_pressed('jump') && air_jump_count < MAX_AIR_JUMP:
    air_jump_count += 1
    emit_signal('request_transition', 'jump')
  .handle_event(event)

func resume():
  owner.get_node('AnimatedSprite').animation = 'jump'
  owner.get_node('AnimatedSprite').stop()
  owner.get_node('AnimatedSprite').frame = 1
  .resume()
