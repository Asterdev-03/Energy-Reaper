class_name Sword
extends Node2D

var can_slash: bool = true
var slash_damage: int

func on_slash():
	if can_slash:
		can_slash = false
		$AnimationPlayer.play("slash")


# Called when slash animation is completed
func on_slash_complete():
	can_slash = true


func _on_slash_area_body_entered(body):
	if "on_hit" in body:
		if body.is_in_group("enemies"):
			GameManager.energy += int(slash_damage / 2)
		body.on_hit(slash_damage)
			
