class_name Sword
extends Node2D

var can_slash: bool = true
var slash_damage: int

func on_slash() -> void:
	#print(can_slash)
	if can_slash and $AnimationPlayer.animation_finished:
		can_slash = false
		$AnimationPlayer.play("slash")


# Called when slash animation is completed
func on_slash_complete() -> void:
	can_slash = true


func _on_slash_area_body_entered(body) -> void:
	if "on_hit" in body:
		# If hit on enemies, then player gains half the damage energy
		if body.is_in_group("enemies"):
			GameManager.energy += int( float(slash_damage) / 2 )
		body.on_hit(slash_damage)
	
