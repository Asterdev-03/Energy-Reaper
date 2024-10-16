extends State

@export var move_state: State


func process_frame(_delta: float) -> State:
	# Attack logic
	if not parent.on_cooldown:
		$"../../RustySword".on_slash()
		parent.on_cooldown = true
		$"../../Timers/AttackCooldownTimer".start()
	
	# If player moves away from attack range, change to move state
	if not parent.can_attack:
		return move_state
	
	return null


