extends CanvasLayer



func _on_player_health_changed(previous_health, new_health):
	var hearts = []
	hearts.append(get_node("Heart1"))
	hearts.append(get_node("Heart2"))
	hearts.append(get_node("Heart3"))
	
	if(new_health<=0):
		new_health = 0
		get_node("youDied").show()
		
	
	if(previous_health>new_health):
		for n in range(previous_health-1, new_health-1, -1):
			hearts[n].hide()
	else:
		for n in range(previous_health-1, new_health-1, 1):
			hearts[n].show()
			
	
		
	
