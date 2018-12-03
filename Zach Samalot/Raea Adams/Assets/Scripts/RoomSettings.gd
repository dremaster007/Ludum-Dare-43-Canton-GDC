extends Node

#Holds what difficulty the room will be
var difficulty = {"Easy": false, "Decent": false, "Hard": false, "Insane": false, "Hell": false}
export (PackedScene) var enemy_scene #The generic enemy scene
export (PackedScene) var item_scene #The pickup scene

#This holds all the possible events for the room, what enemies can spawn, what weapons can spawn, what items can spawn
var room_settings = {"Easy": {"Weapons": [], "Items": []},
                     "Decent": {"Weapons": [], "Items": []},
                     "Hard": {"Weapons": [], "Items": []},
                     "Insane": {"Weapons": [], "Items": []},
                     "Hell": {"Weapons": [], "Items": []}
                     }

var rand_num = 0 #This will be the variable I use to determine randomized events

func _ready():
	room_setup() #Sets up the room enemies and pickups

func room_setup():
	randomize() 
	var enemy_limit = 0 #This will determine how many enemies are within an area
	var item_limit = 0 #This will determine how many pickups are within an area
	
	if game_info.current_difficulty == 0: #Checks the difficulty of the game
		$Ground.modulate = Color("#ff72cb")
		$Walls.modulate = Color("#bc4791")
		difficulty.Easy = true #Sets the difficulty
	if game_info.current_difficulty == 1:
		$Ground.modulate = Color("#89a4ff")
		$Walls.modulate = Color("#233e99")
		difficulty.Decent = true
	if game_info.current_difficulty == 2:
		$Ground.modulate = Color("#54d85b")
		$Walls.modulate = Color("#138419")
		difficulty.Hard = true
	if game_info.current_difficulty == 3:
		$Ground.modulate = Color("#ff49cb")
		$Walls.modulate = Color("#6de6ff")
		difficulty.Insane = true
	if game_info.current_difficulty == 4:
		$Ground.modulate = Color("#ff2b2b")
		$Walls.modulate = Color("#272827")
		difficulty.Hell = true
	
	if difficulty.Easy: #Checks the difficulty that will be generated
		enemy_limit = randi()%2+0 #Enemy limit is randomly set between 0 and 2
		item_limit = randi()%2+0 #Pickup limit is randomly set between 0 and 2
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
	
	#For each enemy that can spawn from the enemy_limit
	for enemies in enemy_limit:
		var e = enemy_scene.instance() #Sets e to equal instancing the enemy scene
		$EnemySpawnArea/SpawnLocation.set_offset(randi()) #Randomly chooses a location to spawn the enemy on the path2D
		add_child(e) #Adds the enemy as a child of Room
		e.character_type = 0
		e.speed = 100
		e.distance_buffer = 50
		e.add_to_group("enemy")
		e.position = $EnemySpawnArea/SpawnLocation.position #Sets the enemy position to the random location
	
	for items in item_limit: #Same thing as above but for items
		var i = item_scene.instance()
		$EnemySpawnArea/SpawnLocation.set_offset(randi())
		add_child(i)
		i.position = $EnemySpawnArea/SpawnLocation.position