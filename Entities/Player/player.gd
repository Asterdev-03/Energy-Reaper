class_name Player
extends CharacterBody2D

@onready var state_machine: Node = $StateMachine
@onready var state: Label = $State


@export var speed: int = 150

var on_cooldown: bool = false
var can_change_weapon: bool = true
var direction: Vector2


func _ready() -> void:
	# Add Player Tools positions where each weapon is to be placed to Weapon Manager
	WeaponManager.init($GunPosition, $SwordPosition, $ShieldPosition)
	
	# Initialie the state machine and passes reference of the enemy entity to the states
	state_machine.starting_state = $StateMachine/idle
	state_machine.init(self, null)


func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)


func _process(delta) -> void:
	# Set player position to Game manager
	GameManager.player_position = position
	
	# Player should look at the mouse
	look_at(get_global_mouse_position())
	
	state_machine.process_frame(delta)


func _physics_process(_delta) -> void:
	#state_machine.process_physics(delta)
	pass


# Switches weapon to provided weapon type and start weapon_change timer
func switch_weapon_to(type: WeaponManager.Types) -> void:
	can_change_weapon = false
	WeaponManager.switch_weapon(type)
	$Timers/WeaponChangeTimer.start()


func on_hit(damage_value) -> void:
	GameManager.energy -= damage_value


func _on_laser_cooldown_timer_timeout() -> void:
	on_cooldown = false


func _on_weapon_change_timer_timeout() -> void:
	can_change_weapon = true
