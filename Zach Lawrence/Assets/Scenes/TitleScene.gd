extends Node

var players_choice
var players_choice_number
var can_scale = false
var old_choice

var player_chosen

var ButtonNameArray = []

func _ready():
	ButtonNameArray = ["HubertButton", "RaeaButton", 
	"LawrenceButton", "EmilyButton", "ZachButton", 
	"ChrisButton", "PeteButton", "ShiraButton"]

func _process(delta):
	if players_choice != null and can_scale:
		get_node(players_choice).rect_scale *= 1.4
		if old_choice != null:
			get_node(old_choice).rect_scale = Vector2(2, 2)
		can_scale = false
		old_choice = players_choice
	if player_chosen == true:
		get_node(players_choice).rect_position.x += 5

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
	ButtonNameArray.insert(players_choice_number, "skip")
	ButtonNameArray.erase(ButtonNameArray[players_choice_number + 1])
	$StartButton.disabled = true

