extends State

@export var move_state: State

func enter() -> void:
	super()
	parent.velocity = Vector2.ZERO


func process_frame(_delta: float) -> State:
	if parent.is_player_nearby:
		return move_state
	return null


