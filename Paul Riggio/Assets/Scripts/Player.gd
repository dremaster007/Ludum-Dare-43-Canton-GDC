extends "res://Assets/Scripts/character_core.gd"

export (int) var speed
var attack_damage = 0
var dead = false

var velocity = Vector2()
var mouse_position = Vector2()
var local_mouse_position = Vector2()

var sprite_state

func _ready():
	player_setup()
	possible_actions.Attack = true

func _process(delta):
	get_input()
	move_and_slide(velocity, Vector2(0,0))
	if Input.is_mouse_button_pressed(1) and possible_actions.Attack:
		$AttackBox/EnemyDetect.disabled = false
		possible_actions.Attack = false
		$AttackCooldown.start()

func get_input():
	velocity = Vector2()    
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:    
		velocity = velocity.normalized() * speed   
	mouse_position = get_global_mouse_position()
	local_mouse_position = get_local_mouse_position()
	rotation += local_mouse_position.angle() + 1.55  # 1.55 is for fine-tuning the rotation to look at the player
	
	# Explaination of changing sprite direction
	# Determining whether or not the mouse position's x value is greater than the player's x value gets me left or right
	# Determining whether or not the mouse position's y value is greater than the player's y value get me up and down
	# Combine both calculations in order to get diagonals
	
	if mouse_position.x > position.x and mouse_position.y <= position.y + 50 and mouse_position.y >= position.y - 50:
		# The player is looking directly right
		sprite_state = "right"
#		print ("player is looking right")
	if mouse_position.x <position.x and mouse_position.y <= position.y + 50 and mouse_position.y >= position.y - 50:
		# The player is looking directly left
		sprite_state = "left"
#		print ("player is looking left")
	if mouse_position.y < position.y and mouse_position.x <= position.x + 50 and mouse_position.x >= position.x - 50:
		# The player is looking up
		sprite_state = "up"
#		print ("player is looking up")
	if mouse_position.y > position.y and mouse_position.x <= position.x + 50 and mouse_position.x >= position.x - 50:
		# The player is looking down
		sprite_state = "down"
#		print ("player is looking down")
	if mouse_position.x >= position.x + 50 and mouse_position.y <= position.y - 50:
		# The player is looking up and right
		sprite_state = "up_right"
#		print ("player is looking up and right")
	if mouse_position.x >= position.x + 50 and mouse_position.y >= position.y + 50:
		# The player is looking down and right
		sprite_state = "down_right"
#		print ("player is looking down and right")
	if mouse_position.x <= position.x - 50 and mouse_position.y <= position.y - 50:
		# The player is looking up and left
		sprite_state = "up_left"
#		print ("player is looking up and left")
	if mouse_position.x <= position.x - 50 and mouse_position.y >= position.y + 50:
		# The player is loooking down and left
		sprite_state = "down_left"
#		print ("player is looking down and left")
	

#This is used to add/subtract stats
func player_update(hp_change, mana_change):
	stats.Max_Health += hp_change
	stats.Mana += mana_change

#This sets up the player's stats once the game begins
func player_setup():
	stats.Current_Health = 100
	stats.Max_Health = 100
	stats.Mana = 100
	stats.Defense = 10

func _on_AttackBox_body_entered(body):
	if body.is_in_group("enemy"):
		pass

func _on_AttackCooldown_timeout():
	$AttackBox/EnemyDetect.disabled = true
	possible_actions.Attack = true
