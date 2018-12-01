extends "res://Assets/Scripts/character_core.gd"

var rand_num = 0
var enemy_difficulty = 0

func _ready():
	print("enemy spawned")
	set_physics_process(true)
	enemy_gen()
	if enemy_difficulty == 0:
		$ColorRect.modulate = Color(0,0,0,1)
	if enemy_difficulty == 1:
		$ColorRect.modulate = Color(0,0,1,1)
	if enemy_difficulty == 2:
		$ColorRect.modulate = Color(0,1,0,1)
	if enemy_difficulty == 3:
		$ColorRect.modulate = Color(1,0,0,1)

func enemy_gen():
	var stat_number
	randomize()
	
	if game_info.current_difficulty == 0:
		stat_number = 10
		enemy_difficulty = 0
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
	
	rand_num = randi()%stat_number
	stats.Max_Health = rand_num
	rand_num = randi()%stat_number
	stats.Mana = rand_num
	rand_num = randi()%stat_number
	stats.Attack = rand_num
	rand_num = randi()%stat_number
	stats.Defense = rand_num

func _physics_process(delta):
	if stats.Current_Health == 0:
		#death()