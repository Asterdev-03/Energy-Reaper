class_name Player
extends CharacterBody2D

signal laser_fired(pos, direction)

const RUSTY_GUN = preload("res://Entities/Guns/RustyGun/rusty_gun.tscn")

@export var speed: int = 150

var on_cooldown: bool = false
var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	GameManager.player_position = position
	
	# Player should look at the mouse
	look_at(get_global_mouse_position())
	
	direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * speed
	move_and_slide()
	
	var fire_direction: Vector2 = (get_global_mouse_position() - position).normalized()
	
	# Shoot projectiles at fire_direction
	if not on_cooldown and Input.is_action_pressed("shoot"):
		var laser_position: Vector2 = $GunPosition.get_child(0).get_node("BulletPosition").get_child(0).global_position
		
		laser_fired.emit(laser_position, fire_direction)
		
		on_cooldown = true
		$Timers/LaserCooldownTimer.start()
		

func on_hit(value):
	GameManager.health -= value


func _on_laser_cooldown_timer_timeout():
	on_cooldown = false
