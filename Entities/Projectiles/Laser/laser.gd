extends Area2D

@export var speed: int = 200
@export var damage: int = 10

var linear_direction: Vector2 = Vector2.ZERO

func _process(delta):
	if linear_direction:
		position += linear_direction * speed * delta 


func _on_body_entered(body):
	if "on_hit" in body:
		body.on_hit(damage)
	queue_free()


func _on_laser_life_timer_timeout():
	queue_free()
