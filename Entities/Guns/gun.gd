class_name Gun
extends Node2D

signal gun_fired(laser: Area2D)

var fire_energy: int
var fire_damage: int


func on_shoot(attack_direction: Vector2) -> void:
	# Get laser starting position
	var bullet_pos: Node2D = $BulletPosition
	var laser_start_pos: Vector2 = bullet_pos.get_child(randi() % bullet_pos.get_child_count()).global_position
	
	# Create laser
	var laser: Area2D = create_laser(attack_direction, laser_start_pos)
	
	# Emit signal to the stage scene to create the laser
	gun_fired.emit(laser)


# Each gun will have different ways to create laser
# This is an abstract function
func create_laser(_attack_direction: Vector2, _starting_position: Vector2) -> Area2D:
	return null
