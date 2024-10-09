class_name Shield
extends StaticBody2D

# On hit by projectiles increses player energy by half od the damage done by projectile
func on_hit(val):
	GameManager.energy += val / 2

# To# Enable/Disable collision shapes when deploying or withdrawing shield
func deploy_shield(enable: bool):
	$CollisionShape2D.disabled = not enable
	
