class_name Stage
extends Node2D

const LASER_SCENE: PackedScene = preload("res://Entities/Projectiles/Laser/laser.tscn")

func _ready():
	for enemy in get_tree().get_nodes_in_group("enemies"):
		enemy.connect("enemy_laser_fired", _on_enemy_laser_fired)
	

func create_laser(pos: Vector2, direction: Vector2):
	var laser = LASER_SCENE.instantiate()
	
	laser.position = pos
	laser.rotation = direction.angle() 
	laser.linear_direction = direction
	
	$Projectiles.add_child(laser)


func _on_enemy_laser_fired(pos, direction):
	create_laser(pos, direction)



func _on_player_laser_fired(pos, direction):
	create_laser(pos, direction)
	
