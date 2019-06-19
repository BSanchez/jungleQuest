extends KinematicBody2D

const FLOOR: Vector2 = Vector2(0, -1)
var velocity: Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func _physics_process(delta):
	move_and_slide(velocity, FLOOR)
	# TODO ajouter des wall jump
	# TODO ajouter un dash
	# TODO ajouter le fait de grimper ou se freiner en glissant sur un mur
	# TODO un stomp
