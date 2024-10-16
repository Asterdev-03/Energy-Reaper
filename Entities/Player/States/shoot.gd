extends State

@export var move_state: State
@export var idle_state: State
@export var shielding_state: State

func process_input(_event: InputEvent) -> State:
	# Get movement input
	parent.direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	# Attack input logic
	if not Input.is_action_pressed("attack"):
		if parent.direction:
			return move_state
		else:
			return idle_state
	
	# Deploy shield on input
	if parent.can_change_weapon and Input.is_action_just_pressed("deploy_shield"):
		parent.switch_weapon_to(WeaponManager.Types.SHIELD)
		return shielding_state
	
	return null


func process_frame(_delta: float) -> State:
	# Attack Logic
	if not parent.on_cooldown:
		shoot()
	
	return null


func shoot() -> void:
	# Get direction where to be fired
	var attack_direction: Vector2 = (parent.get_global_mouse_position() - parent.position).normalized()
	
	WeaponManager.attack(attack_direction)
	
	parent.on_cooldown = true
	$"../../Timers/LaserCooldownTimer".start()
