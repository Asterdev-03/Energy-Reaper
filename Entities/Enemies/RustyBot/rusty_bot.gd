extends Enemies

signal enemy_laser_fired(pos, direction)

# Called when the node enters the scene tree for the first time.
func _ready():
	health = 100
	speed = 50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	if is_player_nearby:
		look_at(GameManager.player_position)
		
		var player_direction = (GameManager.player_position - position).normalized()
		
		velocity = player_direction * speed * int(is_player_nearby)
		
		move_and_slide()
		
		if not on_cooldown and can_attack:
			var laser_position: Vector2 = $BulletPosition.get_child(0).global_position
			
			enemy_laser_fired.emit(laser_position, player_direction)
			
			on_cooldown = true
			$Timers/AttackCooldownTimer.start()


