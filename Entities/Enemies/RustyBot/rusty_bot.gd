extends Enemies

var attack_radius: float

func _ready() -> void:
	super()
	health = 100
	speed = 50
	attack_radius = $AttackArea/CollisionShape2D.shape.radius - 25




