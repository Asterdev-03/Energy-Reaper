extends Node

signal player_stats_changed

var max_energy: int = 100
var player_position: Vector2
var is_player_vulnerable: bool = true
var player_invinsibility_timer: float = 0.8

var energy: int = max_energy:
	set(value):
		if value > energy:
			# Energy gain logic
			energy = min(value, max_energy)
		else:
			# Energy depletion logic
			if is_player_vulnerable:
				energy = max(0,value)
				is_player_vulnerable = false
				start_player_invinsibility_timer()
		
		# Emit stats changed signal to Player UI
		player_stats_changed.emit()


func start_player_invinsibility_timer():
	await get_tree().create_timer(player_invinsibility_timer).timeout
	is_player_vulnerable = true


