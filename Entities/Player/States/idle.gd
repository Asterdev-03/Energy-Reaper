extends State

@export var move_state: State
@export var shoot_state: State
@export var slash_state: State
@export var shielding_state: State


func enter() -> void:
	super()
	parent.direction = Vector2.ZERO


func process_input(_event: InputEvent) -> State:
	# Get movement input
	parent.direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	if parent.direction != Vector2.ZERO:
		return move_state
	
	# Change weapon
	if parent.can_change_weapon:
		if Input.is_action_just_pressed("deploy_gun"):
			parent.switch_weapon_to(WeaponManager.Types.GUN)
		if Input.is_action_just_pressed("deploy_sword"):
			parent.switch_weapon_to(WeaponManager.Types.SWORD)
		if Input.is_action_just_pressed("deploy_shield"):
			parent.switch_weapon_to(WeaponManager.Types.SHIELD)
			return shielding_state
	
	# ------------ NOTE : TEMPORARY LOGIC TO PICKUP WEAPONS ---------------------
	if Input.is_action_just_pressed("equip"):
		WeaponManager.update_weapon()
	
	# Attack Logic
	if Input.is_action_just_pressed("attack"):
		if WeaponManager.prev_weapon == WeaponManager.Types.GUN:
			return shoot_state
		elif WeaponManager.prev_weapon == WeaponManager.Types.SWORD:
			return slash_state
	
	return null


