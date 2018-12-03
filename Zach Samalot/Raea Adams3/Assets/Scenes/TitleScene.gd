extends Node

var players_choice
var players_choice_number
var can_scale = false
var old_choice

var counter = 0
var npc_chosen

var char1
var char2
var char3

var player_chosen

var ButtonNameArray = []

func _ready():
	ButtonNameArray = ["HubertButton", "RaeaButton", 
	"LawrenceButton", "EmilyButton", "ZachButton", 
	"ChrisButton", "PeteButton", "ShiraButton"]

func _process(delta):
	randomize()
	if players_choice != null and can_scale:
		get_node(players_choice).rect_scale *= 1.4
		if old_choice != null:
			get_node(old_choice).rect_scale = Vector2(2, 2)
		can_scale = false
		old_choice = players_choice
	if player_chosen == true:
		move_character(players_choice)
		move_character(char1)
		move_character(char2)
		move_character(char3)

func _on_HubertButton_pressed():
	players_choice = "HubertButton"
	players_choice_number = 0
	game_info.party.Player = game_info.character_texs.Hewer
	can_scale = true
	scaling_check()

func _on_RaeaButton_pressed():
	players_choice = "RaeaButton"
	game_info.party.Player = game_info.character_texs.Raea
	players_choice_number = 1
	can_scale = true
	scaling_check()

func _on_LawrenceButton_pressed():
	players_choice = "LawrenceButton"
	game_info.party.Player = game_info.character_texs.Lawrence
	players_choice_number = 2
	can_scale = true
	scaling_check()

func _on_EmilyButton_pressed():
	players_choice = "EmilyButton"
	game_info.party.Player = game_info.character_texs.Emily
	players_choice_number = 3
	can_scale = true
	scaling_check()

func _on_ZachButton_pressed():
	players_choice = "ZachButton"
	game_info.party.Player = game_info.character_texs.Zach
	players_choice_number = 4
	can_scale = true
	scaling_check()

func _on_ChrisButton_pressed():
	players_choice = "ChrisButton"
	game_info.party.Player = game_info.character_texs.Chris
	players_choice_number = 5
	can_scale = true
	scaling_check()

func _on_PeteButton_pressed():
	players_choice = "PeteButton"
	game_info.party.Player = game_info.character_texs.Pete
	players_choice_number = 6
	can_scale = true
	scaling_check()

func _on_ShiraButton_pressed():
	players_choice = "ShiraButton"
	game_info.party.Player = game_info.character_texs.Shira
	players_choice_number = 7
	can_scale = true
	scaling_check()
	
func scaling_check():
	if players_choice == old_choice:
		can_scale = false

func _on_StartButton_pressed():
	player_chosen = true
	for name in ButtonNameArray:
		get_node(name).text = ""
		get_node(name).disabled = true
	replaceArrayValue(players_choice_number)
	$StartButton.disabled = true

func replaceArrayValue(array_val_chosen):
	#ButtonNameArray.insert(array_val_chosen, "skip")
	ButtonNameArray.erase(ButtonNameArray[array_val_chosen]) # + 1])
	
func move_character(character):
	#print(character)
	if character != null:
		if get_node(character).rect_position.y >= 75:
			get_node(character).rect_position.y -= 3
		elif get_node(character).rect_position.y <= 75:
			get_node(character).rect_position.x += 5
			if get_node(character).rect_position.x >= 800 and counter < 3:
				npc_chosen = randi() % ButtonNameArray.size()
				if ButtonNameArray[npc_chosen] == "skip":
					npc_chosen = randi() % ButtonNameArray.size()
					npc_check()
				counter += 1
				if counter == 3:
					random_weapon()
					get_tree().change_scene("res://Assets/Scenes/Rooms/First_Room.tscn")
				print(counter)
				if char1 == null:
					char1 = ButtonNameArray[npc_chosen]
				elif char2 == null:
					char2 = ButtonNameArray[npc_chosen]
				elif char3 == null:
					char3 = ButtonNameArray[npc_chosen]
				print(ButtonNameArray[npc_chosen])
				move_character(ButtonNameArray[npc_chosen])
				replaceArrayValue(npc_chosen)
				
	else:
		pass

func random_weapon():
	var weapon_list = ["Sword", "Dagger", "Bow"]
	var selected_weapon
	var rand_num = 0
	
	randomize()
	rand_num = randi()%weapon_list.size()
	selected_weapon = weapon_list[rand_num]
	print(selected_weapon)
	
	game_info.inventory.Weapon = selected_weapon

func npc_check():
	if players_choice == "RaeaButton":
		game_info.party.Player = game_info.character_texs.Raea
	if players_choice == "HubertButton":
		game_info.party.Player = game_info.character_texs.Hewer
	if players_choice == "LawrenceButton":
		game_info.party.Player = game_info.character_texs.Lawrence
	if players_choice == "EmilyButton":
		game_info.party.Player = game_info.character_texs.Emily
	if players_choice_number == 4:
		game_info.party.Player = game_info.character_texs.Zach
	if players_choice_number == 5:
		game_info.party.Player = game_info.character_texs.Chris
	if players_choice_number == 6:
		game_info.party.Player = game_info.character_texs.Pete
	if players_choice_number == 7:
		game_info.party.Player = game_info.character_texs.Shira
	
	if npc_chosen == "HubertButton" and counter == 1:
		game_info.party.Member1 = game_info.character_texs.Hewer
	if npc_chosen == "HubertButton" and counter == 2:
		game_info.party.Member2 = game_info.character_texs.Hewer
	if npc_chosen == "HubertButton" and counter == 3:
		game_info.party.Member3 = game_info.character_texs.Hewer
	if npc_chosen == "RaeaButton" and counter == 1:
		game_info.party.Member1 = game_info.character_texs.Raea
	if npc_chosen == "RaeaButton" and counter == 2:
		game_info.party.Member2 = game_info.character_texs.Raea
	if npc_chosen == "RaeaButton" and counter == 3:
		game_info.party.Member3 = game_info.character_texs.Raea
	if npc_chosen == "LawrenceButton" and counter == 1:
		game_info.party.Member1 = game_info.character_texs.Lawrence
	if npc_chosen == "LawrenceButton" and counter == 2:
		game_info.party.Member2 = game_info.character_texs.Lawrence
	if npc_chosen == "LawrenceButton" and counter == 3:
		game_info.party.Member3 = game_info.character_texs.Lawrence
	if npc_chosen == "EmilyButton" and counter == 1:
		game_info.party.Member1 = game_info.character_texs.Emily
	if npc_chosen == "EmilyButton" and counter == 2:
		game_info.party.Member2 = game_info.character_texs.Emily
	if npc_chosen == "EmilyButton" and counter == 3:
		game_info.party.Member3 = game_info.character_texs.Emily
	if npc_chosen == "ZachButton" and counter == 1:
		game_info.party.Member1 = game_info.character_texs.Zach
	if npc_chosen == "ZachButton" and counter == 2:
		game_info.party.Member2 = game_info.character_texs.Zach
	if npc_chosen == "ZachButton" and counter == 3:
		game_info.party.Member3 = game_info.character_texs.Zach
	if npc_chosen == "ChrisButton" and counter == 1:
		game_info.party.Member1 = game_info.character_texs.Chris
	if npc_chosen == "ChrisButton" and counter == 2:
		game_info.party.Member2 = game_info.character_texs.Chris
	if npc_chosen == "ChrisButton" and counter == 3:
		game_info.party.Member3 = game_info.character_texs.Chris
	if npc_chosen == "PeteButton" and counter == 1:
		game_info.party.Member1 = game_info.character_texs.Pete
	if npc_chosen == "PeteButton" and counter == 2:
		game_info.party.Member2 = game_info.character_texs.Pete
	if npc_chosen == "PeteButton" and counter == 3:
		game_info.party.Member3 = game_info.character_texs.Pete
	if npc_chosen == "ShiraButton" and counter == 1:
		game_info.party.Member1 = game_info.character_texs.Shira
	if npc_chosen == "ShiraButton" and counter == 2:
		game_info.party.Member2 = game_info.character_texs.Shira
	if npc_chosen == "ShiraButton" and counter == 3:
		game_info.party.Member3 = game_info.character_texs.Shira