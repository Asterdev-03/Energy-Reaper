extends Area2D

@export var speed: int = 200

var damage: int
var linear_direction: Vector2 = Vector2.ZERO


func _process(delta) -> void:
	# Move laser at the fired direction
	if linear_direction:
		position += linear_direction * speed * delta 


func _on_body_entered(body) -> void:
	# if laser hits any "body", it damages it by calling its on_hit function
	if "on_hit" in body:
		body.on_hit(damage)
	queue_free()

# Laser is destroyed, if it didnt hit anything and its life_timer timeouts
func _on_laser_life_timer_timeout() -> void:
	queue_free()

