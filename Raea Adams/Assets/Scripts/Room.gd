extends Node

export var difficulty = {"Easy": false, "Decent": false, "Hard": false, "Insane": false, "Hell": false}
export (PackedScene) var enemy_scene

#This holds all the possible events for the room, what enemies can spawn, what weapons can spawn, what items can spawn
var room_settings = {"Easy": {"Weapons": [], "Items": []},
                     "Decent": {"Weapons": [], "Items": []},
                     "Hard": {"Weapons": [], "Items": []},
                     "Insane": {"Weapons": [], "Items": []},
                     "Hell": {"Weapons": [], "Items": []}
                     }

var rand_num = 0 #This will be the variable I use to determine randomized events

func _ready():
	yield(get_tree().create_timer(1),"timeout")
	room_setup()

func room_setup():
	randomize()
	var enemy_limit = 0
	var item_limit = 0
	
	if game_info.current_difficulty == 0:
		difficulty.Easy = true
	if game_info.current_difficulty == 1:
		difficulty.Decent = true
	if game_info.current_difficulty == 2:
		difficulty.Hard = true
	if game_info.current_difficulty == 3:
		difficulty.Insane = true
	if game_info.current_difficulty == 4:
		difficulty.Hell = true
	
	if difficulty.Easy:
		enemy_limit = randi()%2+0
		item_limit = randi()%2+0
	if difficulty.Decent:
		enemy_limit = randi()%4+1
		item_limit = randi()%4+0
	if difficulty.Hard:
		enemy_limit = randi()%5+2
		item_limit = randi()%5+0
	if difficulty.Insane:
		enemy_limit = randi()%8+3
		item_limit = randi()%8+0
	if difficulty.Hell:
		enemy_limit = randi()%12+4
		item_limit = randi()%12+0
	
	rand_num = rand_range(enemy_limit, enemy_limit)
	for enemies in enemy_limit:
		yield(get_tree().create_timer(1),"timeout")
		var e = enemy_scene.instance()
		$EnemySpawnArea/SpawnLocation.set_offset(randi())
		add_child(e)
		e.position = $EnemySpawnArea/SpawnLocation.position