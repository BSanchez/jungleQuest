extends "in_air.gd"

# Jumps
export var GRAVITY: int = 10

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
  owner.get_node('AnimatedSprite').frame = 1
  .enter()

func update(delta):
  owner.velocity.y += GRAVITY
  if owner.velocity.y < 0:
    owner.get_node('AnimatedSprite').frame = 1
  else:
    owner.get_node('AnimatedSprite').frame = 2
  .update(delta)
