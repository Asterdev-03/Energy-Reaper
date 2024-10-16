extends Node

@onready var state_label: Label = $"../State"

var starting_state: State
var current_state: State

# Initialize the state machine by giving each child state a reference to the
# parent object it belongs and enter default starting_state
func init(parent: CharacterBody2D, animation: AnimatedSprite2D) -> void:
	for child in get_children():
		child.parent = parent
		child.animation = animation
	
	# Initialize to default state
	change_state(starting_state)


# Change to new state by first calling any exit logic of current state
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	
	state_label.text =  str(new_state.name)
	#print(new_state.name)
	
	current_state = new_state
	current_state.enter()


# Pass through functions for the Entity to call,
# handling state changes as needed
func process_input(event: InputEvent) -> void:
	var new_state: State = current_state.process_input(event)
	if new_state:
		change_state(new_state)


func process_frame(delta: float) -> void:
	var new_state: State = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)


func process_physics(delta: float) -> void:
	var new_state: State = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)



