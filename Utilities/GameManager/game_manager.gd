extends Node

var max_health: int = 100
var player_position: Vector2
var is_player_vulnerable: bool = true
var player_invinsibility_timer: float = 0.8

var health: int = max_health:
	set(value):
		if value > health:
			health = min(value, max_health)
		else:
			if is_player_vulnerable:
				health = value
				is_player_vulnerable = false
				start_player_invinsibility_timer()


func start_player_invinsibility_timer():
	await get_tree().create_timer(player_invinsibility_timer).timeout
	is_player_vulnerable = true
