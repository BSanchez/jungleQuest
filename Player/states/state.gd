# Abstract base class for states
extends Node

func enter():
  pass
  
func resume():
  pass
  
func leave():
  pass

func update(delta: float):
  pass
    
# TODO trouver quel est la classe des events
func dispatch(event):
  pass
  
func on_animation_finished(anim_name):
  pass
