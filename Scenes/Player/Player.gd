extends CharacterBody2D


signal health_changed(previous_health: float, new_health:float)




func _on_player_damage_health_depleted(previous_health, new_health):
	health_changed.emit(previous_health, new_health)
