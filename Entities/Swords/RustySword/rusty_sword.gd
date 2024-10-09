extends Sword


# Called when the node enters the scene tree for the first time.
func _ready():
	slash_damage = 40
	$SlashArea/CollisionShape2D.disabled = true


