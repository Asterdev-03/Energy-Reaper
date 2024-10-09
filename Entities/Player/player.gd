class_name Player
extends CharacterBody2D

@export var speed: int = 150

const RUSTY_GUN: PackedScene = preload("res://Entities/Guns/RustyGun/rusty_gun.tscn")

var on_cooldown: bool = false
var can_change_weapon: bool = true
var direction: Vector2


func _ready():
	# Add Player Tools positions where each weapon is to be placed to Weapon Manager
	WeaponManager.init($GunPosition, $SwordPosition, $ShieldPosition)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Set player position to Game manager
	GameManager.player_position = position
	
	# Player should look at the mouse
	look_at(get_global_mouse_position())
	
	# Get movement input
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * speed
	move_and_slide()
	
	# Attack Logic
	if not on_cooldown and Input.is_action_pressed("attack"):
		on_attack()
	
	# Change Weapon logic through input
	if can_change_weapon:
		if Input.is_action_just_pressed("deploy_gun"):
			switch_weapon_to(WeaponManager.Types.GUN)
		if Input.is_action_just_pressed("deploy_sword"):
			switch_weapon_to(WeaponManager.Types.SWORD)
		if Input.is_action_just_pressed("deploy_shield"):
			switch_weapon_to(WeaponManager.Types.SHIELD)
	
	# ------------ NOTE : TEMPORARY FUNC TO PICKUP WEAPON LOGIC
	if Input.is_action_just_pressed("equip"):
		WeaponManager.update_weapon()

func switch_weapon_to(type: WeaponManager.Types):
	WeaponManager.switch_weapon(type)
	can_change_weapon = false
	$Timers/WeaponChangeTimer.start()


func on_hit(damage_value):
	GameManager.energy -= damage_value


func on_attack():
	# Get direction where to be fired
	var attack_direction: Vector2 = (get_global_mouse_position() - position).normalized()
	
	WeaponManager.attack(attack_direction)
	
	on_cooldown = true
	$Timers/LaserCooldownTimer.start()
	


func _on_laser_cooldown_timer_timeout():
	on_cooldown = false


func _on_weapon_change_timer_timeout():
	can_change_weapon = true
