extends Area2D

@export var upgrade: String





func _on_area_entered(area):
	var audioStream = AudioStreamPlayer2D.new()
	audioStream.stream = load("res://Sounds/Misc/UpgradeHigh.mp3")
	get_parent().add_child(audioStream)
	audioStream.position = position
	audioStream.play()
	PersistantWorldState.unlocks[upgrade] = true
	#TODO needs to be revisited want to play a second animation
	queue_free()
	
