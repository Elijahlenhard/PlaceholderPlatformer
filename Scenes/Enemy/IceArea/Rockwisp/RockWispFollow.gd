extends State
class_name RockWispFollow

@export var animation: AnimatedSprite2D
@export var common: Node
@export var enemy: CharacterBody2D
func enter():
	pass
func exit():
	pass
func update(delta: float):
	pass
	
func physics_update(delta: float):
	var to_player: Vector2
	to_player = (PlayerState.player_location-enemy.position)
	
	
	if(time_to_player(to_player, delta) < common.attack_charge_time):
		transition.emit(RockWispFollow, "RockWispAttack")
	var normal_to_player = to_player.normalized()
	
	var dirrection_helper = .5+ abs(normal_to_player.dot(enemy.velocity.normalized()))
	#dirrection_helper = abs(dirrection_helper)TODO applying abs after adding .5 makes interesting behavior
	var velocity = ((normal_to_player)*delta*common.top_speed)*dirrection_helper
	enemy.velocity += velocity
	print_debug(enemy.velocity)
	if(enemy.velocity.length() > common.top_speed):
		enemy.velocity = enemy.velocity.normalized()*common.top_speed
	print_debug(enemy.velocity)
	enemy.move_and_slide()
	
func time_to_player(to_player: Vector2, delta:float) -> float:
	return (to_player.length()/enemy.velocity.length())
