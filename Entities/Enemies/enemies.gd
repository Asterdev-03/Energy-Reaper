class_name Enemies
extends CharacterBody2D

var is_vulnerable: bool = true
var on_cooldown: bool = false
var is_player_nearby: bool = false
var can_attack: bool = false

var health: int
var speed: int

func on_hit(value: int):
	if is_vulnerable:
		print("enemy hit")
		
		health -= value
		if health <= 0:
			queue_free()
		
		is_vulnerable = false
		$Timers/InvinsibilityTimer.start()


func _on_notice_area_body_entered(_body):
	is_player_nearby = true


func _on_notice_area_body_exited(_body):
	is_player_nearby = false


func _on_attack_area_body_entered(_body):
	can_attack = true


func _on_attack_area_body_exited(_body):
	can_attack = false


func _on_attack_cooldown_timer_timeout():
	on_cooldown = false


func _on_invinsibility_timer_timeout():
	is_vulnerable = true
