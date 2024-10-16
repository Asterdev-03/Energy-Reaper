extends State

@export var move_state: State


func process_frame(_delta: float) -> State:
	parent.look_at(GameManager.player_position)
	
	# Attack logic
	if not parent.on_cooldown:
		var player_direction: Vector2 = (GameManager.player_position - parent.position).normalized()
		$"../../RustyGun".on_shoot(player_direction)
		parent.on_cooldown = true
		$"../../Timers/AttackCooldownTimer".start()
	
	# If player moves away from attack range, change to move state
	if not parent.can_attack:
		return move_state
	
	return null


