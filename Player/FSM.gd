extends Node
signal state_changed(current_state)

export(NodePath) var START_STATE

var states_list = {}
# TODO trouver comment typer ça pour que seul une State puisse aller dedans
var states_stack = []
var current_state = null

# Active est un setter permettant d'activer/désactiver les physics et inputs,
# ainsi qu'init la first scène.
var active: bool = false setget set_active#, get_active
func set_active(value):
  active = value
  set_physics_process(false) # Si true, _physics_process sera appelé et transmis à la current_state
  set_process_input(false) # Si true, _input sera appelé et transmis sous la forme d'event. Noter l'inversion, c'est dégueu.
  
  # Si on vient de d'activer la statemachine, on init. Sinon, on vide le stack et la current_state
  if value == true:
    _change_state(START_STATE.get_name(START_STATE.get_name_count() - 1))
  else:
    # IDEA Devrait-on leave la current_state avant ?
    states_stack = []
    current_state = null 

func _ready():
  for child in get_children():
    states_list[child.name] = child
    #child.connect("finished", self, "_change_state")
  set_active(true) # REMAINDER Attention, les setters et getters en godot ne sont appelé que depuis l'exterieur, on doit appeler directement le setter

# On transmet les inputs à la state en cours
func _input(event):
  current_state.dispatch(event)

# On transmet les inputs à la state en cours
func _physics_process(delta):
  current_state.update(delta)

# On transmet le _on_animation_finish  
func _on_animation_finished(anim_name):
  if not active:
    return
  current_state._on_animation_finished(anim_name)

# Enfin, on change la state en cours quand on en a besoin
func _change_state(state_name):
  if not active:
    return

  # On nettoie la state en cours si elle existe
  if current_state:
    current_state.exit()
    if state_name == 'previous':
      states_stack.pop_front()
    else:
      states_stack[0] = states_list[state_name]
  else:
    states_stack.push_front(states_list[state_name])
    
  current_state = states_stack[0]
  get_node('../state_name').text = current_state.name
  # emit_signal('state_changed', current_state)
  
  # Pour différencier une entrée (legit' d'une entrée retour
  if state_name == 'previous':
    current_state.resume()
  else:
    current_state.enter()
