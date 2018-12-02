extends "res://Assets/Scripts/character_core.gd"

export (int) var speed
var attack_damage = 0
var dead = false
var mouse_works = true

var velocity = Vector2()
var mouse_position = Vector2()
var local_mouse_position = Vector2()

var sprite_state
var facing = "down"

func _ready():
	player_setup()
	possible_actions.Attack = true

func _process(delta):
	if velocity != Vector2(0,0):
		$PlayerAnim.play()
	else:
		$PlayerAnim.stop()
	get_input()
	move_and_slide(velocity, Vector2(0,0))
	
	#Handles attacks
	if Input.is_mouse_button_pressed(1) and possible_actions.Attack and mouse_works:
		mouse_works = false
		if classes.Knight:
			$AttackAnim.play("sword_swing_%s" % facing)
			$sword/SwordArea.damage = stats.Attack
	
		if classes.Rogue:
			$AttackAnim.play("dagger_slash_%s" % facing)
			$dagger_front/DaggerArea.damage = stats.Attack
			$dagger_back/DaggerArea.damage = stats.Attack
	
		if classes.Ranger:
			var a = arrow_scene.instance()
			$bow/ArrowSpawn.add_child(a)
			a.hide()
			a.position = self.position
			a.show()
			a.damage = stats.Attack
			a.rotation = local_mouse_position.angle()
			a.velocity.x = local_mouse_position.x * 2
			a.velocity.y = local_mouse_position.y * 2
			$bow/arrow.hide()
		$AttackCooldown.wait_time = stats.Attack_Speed
		possible_actions.Attack = false
		$AttackCooldown.start()
	if facing != str($PlayerAnim.current_animation):
		$PlayerAnim.play(facing)

func get_input():
	velocity = Vector2()    
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if velocity.length() > 0:    
		velocity = velocity.normalized() * speed   
	mouse_position = get_global_mouse_position()
	local_mouse_position = get_local_mouse_position()
	$bow.rotation = local_mouse_position.angle() # 1.55 is for fine-tuning the rotation to look at the player
	
	# Explaination of changing sprite direction
	# Determining whether or not the mouse position's x value is greater than the player's x value gets me left or right
	# Determining whether or not the mouse position's y value is greater than the player's y value get me up and down
	# Combine both calculations in order to get diagonals
	
	if mouse_position.x > position.x and mouse_position.y <= position.y + 50 and mouse_position.y >= position.y - 50:
		# The player is looking directly right
		sprite_state = "right"
		facing = "right"
		$sword.z_index = 1
#		print ("player is looking right")
	if mouse_position.x <position.x and mouse_position.y <= position.y + 50 and mouse_position.y >= position.y - 50:
		# The player is looking directly left
		sprite_state = "left"
		facing = "left"
		$sword.z_index = 1
#		print ("player is looking left")
	if mouse_position.y < position.y and mouse_position.x <= position.x + 50 and mouse_position.x >= position.x - 50:
		# The player is looking up
		sprite_state = "up"
		facing = "up"
		$sword.z_index = -1
#		print ("player is looking up")
	if mouse_position.y > position.y and mouse_position.x <= position.x + 50 and mouse_position.x >= position.x - 50:
		# The player is looking down
		sprite_state = "down"
		facing = "down"
		$sword.z_index = 1
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
	classes.Ranger = true
	
	if classes.Knight:
		stats.Current_Health = 150
		stats.Max_Health = 150
		stats.Mana = 50
		stats.Defense = 20
		stats.Attack = 4
		stats.Attack_Speed = 1.5
	if classes.Rogue:
		stats.Current_Health = 70
		stats.Max_Health = 70
		stats.Mana = 60
		stats.Defense = 6
		stats.Attack = 3
		stats.Attack_Speed = 0.3
		$dagger_front.show()
		$dagger_back.show()
	if classes.Healer:
		stats.Current_Health = 100
		stats.Max_Health = 100
		stats.Mana = 100
		stats.Defense = 4
		stats.Attack = 1
		stats.Attack_Speed = 1.5
		$staff.show()
	if classes.Ranger:
		stats.Current_Health = 100
		stats.Max_Health = 100
		stats.Mana = 50
		stats.Defense = 7
		stats.Attack = 999999
		stats.Attack_Speed = 4
		$bow.show()
		$bow/arrow.show()

func _on_AttackCooldown_timeout():
	if classes.Ranger:
		$bow/arrow.show()
	possible_actions.Attack = true
	mouse_works = true
