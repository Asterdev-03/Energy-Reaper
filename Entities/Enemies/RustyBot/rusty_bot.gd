extends Enemies

var attack_radius: float

func _ready():
	health = 100
	speed = 50
	attack_radius = $AttackArea/CollisionShape2D.shape.radius - 25


func _process(_delta):
	if is_player_nearby:
		look_at(GameManager.player_position)
		
		var player_direction: Vector2 = (GameManager.player_position - position).normalized()
		
		var can_move: bool = is_player_nearby and position.distance_to(GameManager.player_position) > attack_radius
		velocity = player_direction * speed * int(can_move)
		
		move_and_slide()
		
		if not on_cooldown and can_attack:
			$RustyGun.on_shoot(player_direction)
			
			on_cooldown = true
			$Timers/AttackCooldownTimer.start()


