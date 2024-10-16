class_name Enemies
extends CharacterBody2D

@onready var state_machine = $StateMachine

var is_vulnerable: bool = true
var on_cooldown: bool = false
var is_player_nearby: bool = false
var can_attack: bool = false

var health: int
var speed: int
var weapon: Node2D

func _ready() -> void:
	# Initialie the state machine and passes reference of the enemy entity to the states
	state_machine.starting_state = $StateMachine/idle
	state_machine.init(self, null)

func _process(delta) -> void:
	state_machine.process_frame(delta)
	$State.text = str(state_machine.current_state.name)

func _physics_process(_delta) -> void:
	#state_machine.process_physics(delta)
	pass

func on_hit(value: int) -> void:
	if is_vulnerable:
		health -= value
		if health <= 0:
			queue_free()
		
		is_vulnerable = false
		$Timers/InvinsibilityTimer.start()


func _on_notice_area_body_entered(_body) -> void:
	is_player_nearby = true


func _on_notice_area_body_exited(_body) -> void:
	is_player_nearby = false


func _on_attack_area_body_entered(_body) -> void:
	can_attack = true


func _on_attack_area_body_exited(_body) -> void:
	can_attack = false


func _on_attack_cooldown_timer_timeout() -> void:
	on_cooldown = false


func _on_invinsibility_timer_timeout() -> void:
	is_vulnerable = true


