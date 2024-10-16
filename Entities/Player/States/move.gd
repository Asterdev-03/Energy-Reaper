extends State

@export var idle_state: State
@export var shoot_state: State
@export var slash_state: State
@export var shielding_state: State

func process_input(_event: InputEvent) -> State:
	# Get movement input
	parent.direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	# Change weapon
	if parent.can_change_weapon:
		if Input.is_action_just_pressed("deploy_gun"):
			parent.switch_weapon_to(WeaponManager.Types.GUN)
		if Input.is_action_just_pressed("deploy_sword"):
			parent.switch_weapon_to(WeaponManager.Types.SWORD)
		if Input.is_action_just_pressed("deploy_shield"):
			parent.switch_weapon_to(WeaponManager.Types.SHIELD)
			return shielding_state
	
	# Attack Logic
	if Input.is_action_pressed("attack"):
		if WeaponManager.current_weapon == WeaponManager.Types.GUN:
			return shoot_state
		elif WeaponManager.current_weapon == WeaponManager.Types.SWORD:
			return slash_state
	
	return null


func process_frame(_delta: float) -> State:
	# Change to idle state if no movement
	if parent.direction == Vector2.ZERO:
		return idle_state
	
	# Movement logic
	parent.velocity = parent.direction * parent.speed
	parent.move_and_slide()
	
	return null

