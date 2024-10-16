class_name Stage
extends Node2D

func _ready() -> void:
	WeaponManager.connect("update_signal", update_signal)
	update_signal()


func _on_gun_fired(laser_info: Area2D) -> void:
	$Projectiles.add_child(laser_info)


# Connecting all the necessary signala to stage scene if not connected before
func update_signal() -> void:
	for gun in get_tree().get_nodes_in_group("guns"):
		if not gun.is_connected("gun_fired", _on_gun_fired):
			gun.connect("gun_fired", _on_gun_fired)
