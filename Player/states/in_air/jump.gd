extends "in_air.gd"

# Jumps
export var JUMP_POWER: int = 60
export var MAX_JUMP_TIME: float = 0.1

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
  owner.get_node('AnimatedSprite').frame = 0
  owner.velocity.y = -JUMP_POWER
  remaining_jump_time = MAX_JUMP_TIME
  .enter()

func update(delta):
  if Input.is_action_pressed('jump') && remaining_jump_time > 0:
    remaining_jump_time -= delta
  else:
    emit_signal('request_transition', 'fall')
