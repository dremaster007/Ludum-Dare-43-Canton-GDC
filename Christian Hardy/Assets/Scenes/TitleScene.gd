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
	can_scale = true
	scaling_check()

func _on_RaeaButton_pressed():
	players_choice = "RaeaButton"
	players_choice_number = 1
	can_scale = true
	scaling_check()

func _on_LawrenceButton_pressed():
	players_choice = "LawrenceButton"
	players_choice_number = 2
	can_scale = true
	scaling_check()

func _on_EmilyButton_pressed():
	players_choice = "EmilyButton"
	players_choice_number = 3
	can_scale = true
	scaling_check()

func _on_ZachButton_pressed():
	players_choice = "ZachButton"
	players_choice_number = 4
	can_scale = true
	scaling_check()

func _on_ChrisButton_pressed():
	players_choice = "ChrisButton"
	players_choice_number = 5
	can_scale = true
	scaling_check()

func _on_PeteButton_pressed():
	players_choice = "PeteButton"
	players_choice_number = 6
	can_scale = true
	scaling_check()

func _on_ShiraButton_pressed():
	players_choice = "ShiraButton"
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
				counter += 1
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