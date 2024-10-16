extends State

@export var idle_state: State
@export var attack_state: State


func process_frame(_delta: float) -> State:
	if not parent.is_player_nearby:
		return idle_state
	
	if parent.can_attack:
		return attack_state
	
	# Movement logic
	parent.look_at(GameManager.player_position)
	var player_direction: Vector2 = (GameManager.player_position - parent.position).normalized()
	parent.velocity = player_direction * parent.speed * int(parent.is_player_nearby)
	parent.move_and_slide()
	
	return null

