extends State

@export var move_state: State
@export var idle_state: State
@export var shoot_state: State
@export var slash_state: State

var can_move: bool

func enter() -> void:
	super()
	can_move = false


func process_input(_event: InputEvent) -> State:
	if parent.direction == Vector2.ZERO or is_movement_action_released():
		can_move = true
	
	# Get movement input
	if can_move:
		parent.direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if parent.can_change_weapon:
		# Switching weapon logic
		if Input.is_action_just_pressed("deploy_gun"):
			parent.switch_weapon_to(WeaponManager.Types.GUN)
			return idle_state
		if Input.is_action_just_pressed("deploy_sword"):
			parent.switch_weapon_to(WeaponManager.Types.SWORD)
			return idle_state
		
		# Attack logic
		if Input.is_action_pressed("attack"):
			if WeaponManager.prev_weapon == WeaponManager.Types.GUN:
				parent.switch_weapon_to(WeaponManager.Types.GUN)
				return shoot_state
			elif WeaponManager.prev_weapon == WeaponManager.Types.SWORD:
				parent.switch_weapon_to(WeaponManager.Types.SWORD)
				return slash_state
	
	return null


func process_frame(_delta: float) -> State:
	# Change to move state on movement input is true
	# Also change weapon to previous weapon before changing to move state
 	# This logic is used to correctly transition between states: move -> shielding -> move
	# Transition from shiedling to move only if player has released pressing movement input
	# during shielding and then press input again
	if can_move and parent.can_change_weapon and parent.direction != Vector2.ZERO:
		parent.switch_weapon_to(WeaponManager.prev_weapon)
		return move_state
	
	return null


# This method is to identify whether player has released pressing the movement input
func is_movement_action_released() -> bool:
	return Input.is_action_just_released("move_up") \
		or Input.is_action_just_released("move_down")   \
		or Input.is_action_just_released("move_left") \
		or Input.is_action_just_released("move_right")

