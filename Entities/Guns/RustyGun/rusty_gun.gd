extends Gun

@onready var LASER_SCENE: PackedScene = preload("res://Entities/Projectiles/Laser/laser.tscn")

func _ready():
	fire_energy = 20
	fire_damage = 20

func create_laser(attack_direction: Vector2, starting_position: Vector2) -> Area2D:
	var laser = LASER_SCENE.instantiate() as Area2D
	laser.position = starting_position
	laser.rotation = attack_direction.angle() 
	laser.linear_direction = attack_direction
	laser.damage = fire_damage
	
	return laser


