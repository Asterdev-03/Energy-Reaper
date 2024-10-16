class_name State
extends Node

@export var animation_name: String

## Holds reference to parent so that it can be controlled by the state
var parent: CharacterBody2D
var animation: AnimatedSprite2D

# Play animation or do a task when moving to this state
func enter() -> void:
	if animation_name:
		animation.play(animation_name)

# Play animation or do a task when exiting from this state
func exit() -> void:
	pass


func process_input(_event: InputEvent) -> State:
	return null


func process_frame(_delta: float) -> State:
	return null


func process_physics(_delta: float) -> State:
	return null


