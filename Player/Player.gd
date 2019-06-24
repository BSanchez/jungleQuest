extends KinematicBody2D

const FLOOR: Vector2 = Vector2(0, -1)
var velocity: Vector2 = Vector2(0, 0)
var on_a_climbable: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
  pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass

func _physics_process(delta):
  move_and_slide(velocity, FLOOR)

func _on_climbable_body_entered(body):
  if body == self:
    on_a_climbable = true

func _on_climbable_body_exited(body):
  if body == self:
    on_a_climbable = false
