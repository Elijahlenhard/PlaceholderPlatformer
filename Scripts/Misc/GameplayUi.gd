extends CanvasLayer

@export var ability_bar: AnimatedSprite2D

func _ready():
	_on_player_health_changed(0, PlayerState.health)

func _process(delta):
	ability_bar.frame = PlayerState.ability_resource

func _on_player_health_changed(previous_health, new_health):
	var hearts = []
	hearts.append(get_node("Heart1"))
	hearts.append(get_node("Heart2"))
	hearts.append(get_node("Heart3"))
	hearts.append(get_node("Heart4"))
	hearts.append(get_node("Heart5"))
	hearts.append(get_node("Heart6"))
	
	if(new_health<=0):
		new_health = 0
		get_node("youDied").show()
		
	for n in range(0, hearts.size()):
		if(n<new_health):
			hearts[n].show()
		else:
			hearts[n].hide()
		

func _on_player_ability_resource_updated(current):
	ability_bar.frame = current
