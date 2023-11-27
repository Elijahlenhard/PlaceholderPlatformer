class_name EnemyMove
extends Node

@export var enemy: CharacterBody2D
var terminal_velocity = 2750
var top_speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	apply_gravity(delta)
	enemy.move_and_slide()
	
	
func apply_gravity(delta):
	var linear = 2000
	if (!enemy.is_on_floor()):
		enemy.velocity.y += (linear*delta)*((terminal_velocity-enemy.velocity.y)/terminal_velocity)
		
func run_right(delta):
	var multiplier = 1.1
	var linear = 20
	if(enemy.velocity.x<0||enemy.velocity.x>(top_speed+25)):
		decelerate(delta, 2)
	elif(enemy.velocity.x<top_speed):
		enemy.velocity.x = enemy.velocity.x*multiplier + linear
		
func run_left(delta):
	var multiplier = 1.1
	var linear = -20
	if(enemy.velocity.x>0 ||enemy.velocity.x<-(top_speed+25)):
		decelerate(delta, 2)
	elif(enemy.velocity.x>-top_speed):
		enemy.velocity.x = enemy.velocity.x*multiplier + linear
func decelerate(delta, rate):
	var deceleration = .99
	var linear = 5
	if(abs(enemy.velocity.x) < linear):
		enemy.velocity.x = 0
	elif(enemy.velocity.x > 0):
		enemy.velocity.x = enemy.velocity.x*deceleration - linear
	elif(enemy.velocity.x < 0):
		enemy.velocity.x = enemy.velocity.x*deceleration + linear		
