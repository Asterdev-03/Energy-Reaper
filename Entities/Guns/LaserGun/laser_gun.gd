extends Gun

@onready var LASER_SCENE: PackedScene = preload("res://Entities/Projectiles/Laser/laser.tscn")


func _ready() -> void:
	fire_energy = 40
	fire_damage = 40


# Creates laser with custom properties for laser gun
func create_laser(attack_direction: Vector2, starting_position: Vector2) -> Area2D:
	var laser = LASER_SCENE.instantiate() as Area2D
	laser.position = starting_position
	laser.rotation = attack_direction.angle() 
	laser.linear_direction = attack_direction
	laser.damage = fire_damage
	laser.modulate = Color(1,0,0)
	
	return laser


