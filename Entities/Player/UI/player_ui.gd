extends CanvasLayer

func _ready():
	GameManager.connect("player_stats_changed", update_player_stats)
	update_player_stats()

# Updates all the stats displayed on the Player UI
func update_player_stats():
	update_player_energy()


# Updates energy
func update_player_energy():
	$Label.text = "Energy: " + str(GameManager.energy)
	
	#if GameManager.energy <= 0:
		#queue_free()
