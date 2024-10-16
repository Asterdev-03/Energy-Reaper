extends Node

signal player_laser_fired(laser_info)

signal update_signal

enum Types{
	GUN,
	SWORD,
	SHIELD
}

# Load all guns
@onready var RUSTY_GUN: PackedScene = preload("res://Entities/Guns/RustyGun/rusty_gun.tscn")
@onready var LASER_GUN: PackedScene = preload("res://Entities/Guns/LaserGun/laser_gun.tscn")

# Load all swords
@onready var RUSTY_SWORD: PackedScene = preload("res://Entities/Swords/RustySword/rusty_sword.tscn")

# Load all shields
@onready var RUSTY_SHIELD: PackedScene = preload("res://Entities/Shields/RustyShield/rusty_shield.tscn")

# Load all projectiles
@onready var LASER_SCENE: PackedScene = preload("res://Entities/Projectiles/Laser/laser.tscn")


var weapon_positions: Dictionary
var current_weapon: Types = Types.GUN
var prev_weapon: Types = Types.GUN

# Initialize the Weapon Manager
func init(gun_pos: Marker2D, sword_pos: Marker2D, shield_pos: Marker2D) -> void:
	# Initialize weapon_position marker nodes
	weapon_positions[Types.GUN] = gun_pos
	weapon_positions[Types.SWORD] = sword_pos
	weapon_positions[Types.SHIELD] = shield_pos
	
	# Initialize the weapons for each type
	weapon_positions[Types.GUN].add_child(RUSTY_GUN.instantiate())
	weapon_positions[Types.SWORD].add_child(RUSTY_SWORD.instantiate())
	weapon_positions[Types.SHIELD].add_child(RUSTY_SHIELD.instantiate())
	
	# Set all weapons Types to be not visible, except GUN Type
	weapon_positions[Types.GUN].visible = true
	weapon_positions[Types.SWORD].visible = false
	weapon_positions[Types.SHIELD].visible = false
	

# Weapon attack logic
func attack(attack_direction: Vector2 = Vector2.ZERO) -> void:
	# If shield is depolyed, change to prev_weapon to execute weapon attack logic
	if current_weapon == Types.SHIELD:
		switch_weapon(prev_weapon)
	
	# For each weapon have specific code to execute for attacking
	match current_weapon:
		Types.GUN:
			if GameManager.energy > 0:
				weapon_positions[Types.GUN].get_child(0).on_shoot(attack_direction)
				
				# To reduce energy of player when shooting according to fire energy
				# specified for each gun weapons
				GameManager.energy -= weapon_positions[Types.GUN].get_child(0).fire_energy
		Types.SWORD:
			weapon_positions[Types.SWORD].get_child(0).on_slash()


# Logic for switching weapons between each types
# Has weapon_type as parameter, which specifies which Type to be switched into
func switch_weapon(weapon_type: Types) -> void:
	# Hide Current Weapon
	weapon_positions[current_weapon].visible = false
	# Display to changed Weapon
	weapon_positions[weapon_type].visible = true
	
	# Store previous weapon used before deploying shield
	# Set prev_weapon as current_weapon if not deploying shield
	if weapon_type == Types.SHIELD:
		prev_weapon = current_weapon
	else:
		prev_weapon = weapon_type
	
	# Set currently using weapon as weapon_type
	current_weapon = weapon_type
	
	# Enable/ Disable shield when deploying or withdrawing shield
	weapon_positions[Types.SHIELD].get_child(0).deploy_shield(weapon_type == Types.SHIELD)


# Update the current weapon to a new weapon
# Logic is not completed
# Need further progess
func update_weapon() -> void:
	# ------ NOTE: THESE ARE FUTURE PARAMS -----------
	var weapon: Node2D = LASER_GUN.instantiate()
	var weapon_type: Types = Types.GUN
	
	weapon_positions[weapon_type].get_child(0).queue_free()
	#weapon_positions[weapon_type].get_child(0).call_deferred("queue_free")
	
	weapon_positions[weapon_type].add_child(weapon)
	#weapon_positions[weapon_type].call_deferred("add_child", weapon)
	
	# No idea why, but when creating new weapon and adding as child it is not connected to
	# signals in stage scene. Hense needs to update the signals
	update_signal.emit()
	



