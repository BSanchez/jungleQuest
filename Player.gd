extends KinematicBody2D

const SPEED: int = 50
const GRAVITY: int = 10
const JUMP_POWER: int = 100
const FLOOR: Vector2 = Vector2(0, -1)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity: Vector2 = Vector2(0, 0)

# Jumps
const MAX_AIR_JUMP = 1
var airJumpCount = 0


# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func jump():
  velocity.y -= JUMP_POWER

func _physics_process(delta):
  # Nettoyer cette merde : les touches doivent appeler des actions
  # qui existent sous la forme de fonctions
  if Input.is_action_pressed("ui_right"):
    velocity.x = SPEED
    $AnimatedSprite.play()
    $AnimatedSprite.flip_h = false
  elif Input.is_action_pressed("ui_left"):
    velocity.x = -1 * SPEED
    $AnimatedSprite.play()
    $AnimatedSprite.flip_h = true
  else:
    $AnimatedSprite.frame = 0
    $AnimatedSprite.stop()
    velocity.x = 0
    
  # TODO ajouter des air jump
  # TODO ajouter des wall jump
  # TODO ajouter un dash
  # TODO ajouter le fait de grimper ou se freiner en glissant sur un mur
  # TODO pouvoir controller la hauteur des saut en gérant le temps passé sur la touche
  # TODO un stomp
  
  if is_on_floor():
    velocity.y = 0
    if Input.is_action_pressed("ui_select"):
      velocity.y -= JUMP_POWER
  else:
    velocity.y += GRAVITY
  move_and_slide(velocity, FLOOR)
