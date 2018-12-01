extends Node

export var difficulty = {"Easy": false, "Decent": false, "Hard": false, "Insane": false, "Hell": false}

#This holds all the possible events for the room, what enemies can spawn, what weapons can spawn, what items can spawn
var room_settings = {"Easy": {"Enemies": [], "Weapons": [], "Items": []},
                     "Decent": {"Enemies": [], "Weapons": [], "Items": []},
                     "Hard": {"Enemies": [], "Weapons": [], "Items": []},
                     "Insane": {"Enemies": [], "Weapons": [], "Items": []},
                     "Hell": {"Enemies": [], "Weapons": [], "Items": []}
                     }

var rand_num = 0 #This will be the variable I use to determine randomized events

func _ready():
	room_setup()

func room_setup():
	if game_info.current_difficulty.Easy:
		difficulty.Easy.true
	if game_info.current_difficulty.Decent:
		difficulty.Decent.true
	if game_info.current_difficulty.Hard:
		difficulty.Hard.true
	if game_info.current_difficulty.Insane:
		difficulty.Insane.true
	if game_info.current_difficulty.Hell:
		difficulty.Hell.true
	
	if difficulty.Easy:
		randomize()
		rand_num = rand_range()%room_settings.Easy.Enemies.size()
		#Spawn enemies
		rand_num = rand_range()%room_settings.Easy.Weapons.size()
		#Spawn weapons
		rand_num = rand_range()%room_settings.Easy.Items.size()
		#Spawn Items