extends KinematicBody2D

const SPEED: int = 50
const GRAVITY: int = 10

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const FLOOR: Vector2 = Vector2(0, -1)
var velocity: Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func _physics_process(delta):
	move_and_slide(velocity, FLOOR)
	# Nettoyer cette merde : les touches doivent appeler des actions
	# qui existent sous la forme de fonctions
	if Input.is_action_pressed('ui_right'):
		velocity.x = SPEED
		$AnimatedSprite.play()
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed('ui_left'):
		velocity.x = -1 * SPEED
		$AnimatedSprite.play()
		$AnimatedSprite.flip_h = true
	else:
		velocity.x = 0

	# TODO ajouter des wall jump
	# TODO ajouter un dash
	# TODO ajouter le fait de grimper ou se freiner en glissant sur un mur
	# TODO un stomp