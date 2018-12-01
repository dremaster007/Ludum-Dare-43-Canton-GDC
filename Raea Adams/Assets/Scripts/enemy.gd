extends "res://Assets/Scripts/character_core.gd"

var rand_num = 0 #Used for random "rolls"
var enemy_difficulty = 0 #This is how the hard enemy will be to defeat

var distance

var direction = Vector2()

export (int) var speed
export (int) var distance_buffer

onready var player = get_node("/root/Room/Player")  # gets the player node stored in player

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
	var stat_number #This makes it easier to modify the stat limit to multiple difficulties
	randomize()
	
	if game_info.current_difficulty == 0: #Checks the difficulty of the level
		stat_number = 10 #Sets the stat number to the highest each stat can be
		enemy_difficulty = 0 #Sets the difficulty of the enemy
	if game_info.current_difficulty == 1:
		stat_number = 20
		enemy_difficulty = 1
	if game_info.current_difficulty == 2:
		stat_number = 30
		enemy_difficulty = 2
	if game_info.current_difficulty == 3:
		stat_number = 40
		enemy_difficulty = 3
	if game_info.current_difficulty == 4:
		stat_number = 40
		enemy_difficulty = 4
	
	rand_num = randi()%stat_number #Sets the random number 
	stats.Max_Health = rand_num #Sets the health to the random number
	rand_num = randi()%stat_number
	stats.Mana = rand_num #Sets the Mana to the random number
	rand_num = randi()%stat_number
	stats.Attack = rand_num #Sets the Attack to the random number
	rand_num = randi()%stat_number
	stats.Defense = rand_num #Sets the Defense to the random number

func _physics_process(delta):
	#if stats.Current_Health == 0:
		#death()
	direction = player.position - self.position  # gets the direction the npc is facing
	distance = sqrt(direction.x * direction.x + direction.y * direction.y)  # calculates how far away player is
	if distance >= distance_buffer:  # determines if npc should move
		distance = sqrt(direction.x * direction.x + direction.y * direction.y)
		position += direction.normalized() * speed * delta
		#if direction.x <= 0:
			#$AnimatedSprite.flip_h = true
		#elif direction.x > 0:
			#$AnimatedSprite.flip_h = false
	else:
		position += direction.normalized() * 0 * delta
