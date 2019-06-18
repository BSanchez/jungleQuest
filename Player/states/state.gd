# Abstract base class for states
extends Node

signal request_transition(next_state_name)

func _ready():
  owner = get_node('../..')

func enter():
  pass

func resume():
  pass

func leave():
  pass

func update(delta: float):
  pass

# TODO trouver quel est la classe des events
func handle_event(event):
  pass

func on_animation_finished(anim_name):
  pass
