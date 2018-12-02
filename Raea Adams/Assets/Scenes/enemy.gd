extends "res://Assets/Scripts/character_core.gd"

var rand_num = 0 #Used for random "rolls"
var enemy_difficulty = 0 #This is how the hard enemy will be to defeat

func _ready():
	set_physics_process(true)
	enemy_gen() #Generates enemy stats
	
	#This is for testing purposes
	if enemy_difficulty == 0:
		$ColorRect.modulate = Color(0,0,0,1)
	if enemy_difficulty == 1:
		$ColorRect.modulate = Color(0,0,1,1)
	if enemy_difficulty == 2:
		$ColorRect.modulate = Color(0,1,0,1)
	if enemy_difficulty == 3:
		$ColorRect.modulate = Color(1,0,0,1)

func enemy_gen():
