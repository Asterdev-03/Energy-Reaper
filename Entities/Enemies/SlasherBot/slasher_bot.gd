extends Enemies


# Called when the node enters the scene tree for the first time.
func _ready():
	health = 100
	speed = 100



func _process(_delta):
	if is_player_nearby:
		look_at(GameManager.player_position)
		
		var player_direction: Vector2 = (GameManager.player_position - position).normalized()
		
		velocity = player_direction * speed * int(is_player_nearby)
		
		move_and_slide()
		
		if not on_cooldown and can_attack:
			$RustySword.on_slash()
			
			on_cooldown = true
			$Timers/AttackCooldownTimer.start()
