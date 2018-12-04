extends Node

var players_choice

var selected_char = -2

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
	ButtonNameArray = ["Hubert", "Raea", 
	"Lawrence", "Emily", "Zach", 
	"Chris", "Pete", "Shira"]
	toggle_check()
	selected_char = -1

func _process(delta):
	randomize()
	if players_choice != null and can_scale:
	#	get_node(players_choice).rect_scale *= 1.4
		#if old_choice != null:
		#	get_node(old_choice).rect_scale = Vector2(2, 2)
		can_scale = false
		old_choice = players_choice
	if player_chosen == true:
		move_character(players_choice)
		move_character(char1)
		move_character(char2)
		move_character(char3)

func toggle_check():
	if selected_char == -2:
		$Title.play("fadeout")
	if selected_char != 0:
		$Raea.pressed = false
		$Raea/NameLabel.hide()
	if selected_char != 1:
		$Hubert.pressed = false
		$Hubert/NameLabel.hide()
	if selected_char != 2:
		$Lawrence.pressed = false
		$Lawrence/NameLabel.hide()
	if selected_char != 3:
		$Emily.pressed = false
		$Emily/NameLabel.hide()
	if selected_char != 4:
		$Zach.pressed = false
		$Zach/NameLabel.hide()
	if selected_char != 5:
		$Chris.pressed = false
		$Chris/NameLabel.hide()
	if selected_char != 6:
		$Pete.pressed = false
		$Pete/NameLabel.hide()
	if selected_char != 7:
		$Shira.pressed = false
		$Shira/NameLabel.hide()

func _on_RaeaButton_pressed():
	players_choice = "Raea"
	players_choice_number = 1
	$Raea/NameLabel.show()
	selected_char = 0
	toggle_check()

func _on_HubertButton_pressed():
	players_choice = "Hubert"
	players_choice_number = 0
	selected_char = 1
	toggle_check()

func _on_LawrenceButton_pressed():
	players_choice = "LawrenceButton"
	players_choice_number = 2
	$Lawrence/NameLabel.show()
	selected_char = 2
	toggle_check()

func _on_EmilyButton_pressed():
	players_choice = "EmilyButton"
	players_choice_number = 3
	$Emily/NameLabel.show()
	selected_char = 3
	toggle_check()

func _on_ZachButton_pressed():
	players_choice = "ZachButton"
	players_choice_number = 4
	selected_char = 4
	toggle_check()

func _on_ChrisButton_pressed():
	players_choice = "ChrisButton"
	players_choice_number = 5
	selected_char = 5
	toggle_check()

func _on_PeteButton_pressed():
	players_choice = "PeteButton"
	players_choice_number = 6
	selected_char = 6
	toggle_check()

func _on_ShiraButton_pressed():
	players_choice = "ShiraButton"
	players_choice_number = 7
	selected_char = 7
	toggle_check()

func _on_StartButton_pressed():
	player_chosen = true
	ButtonNameArray.erase(ButtonNameArray[selected_char])
	move_character(ButtonNameArray[selected_char])
	$Start.disabled = true

func move_character(character):
	#print(character)
	var chosen_player
	if character != null:
		chosen_player = get_node("%sSprite/Anim" % character)
		chosen_player.play("selected")
	else:
		pass


func _on_Raea_mouse_entered():
	$Raea/NameLabel.show()

func _on_Raea_mouse_exited():
	if $Raea.pressed == false:
		$Raea/NameLabel.hide()

func _on_Hubert_mouse_entered():
	$Hubert/NameLabel.show()

func _on_Hubert_mouse_exited():
	if $Hubert.pressed == false:
		$Hubert/NameLabel.hide()

func _on_Lawrence_mouse_entered():
	$Lawrence/NameLabel.show()

func _on_Lawrence_mouse_exited():
	if $Lawrence.pressed == false:
		$Lawrence/NameLabel.hide()

func _on_Emily_mouse_entered():
	$Emily/NameLabel.show()

func _on_Emily_mouse_exited():
	if $Emily.pressed == false:
		$Emily/NameLabel.hide()

func _on_Zach_mouse_entered():
	$Zach/NameLabel.show()

func _on_Zach_mouse_exited():
	if $Zach.pressed == false:
		$Zach/NameLabel.hide()

func _on_Chris_mouse_entered():
	$Chris/NameLabel.show()

func _on_Chris_mouse_exited():
	if $Chris.pressed == false:
		$Chris/NameLabel.hide()

func _on_Pete_mouse_entered():
	$Pete/NameLabel.show()

func _on_Pete_mouse_exited():
	if $Pete.pressed == false:
		$Pete/NameLabel.hide()

func _on_Shira_mouse_entered():
	$Shira/NameLabel.show()

func _on_Shira_mouse_exited():
	if $Shira.pressed == false:
		$Shira/NameLabel.hide()

func _on_Anim_animation_finished(anim_name):
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
			move_character(ButtonNameArray[npc_chosen])