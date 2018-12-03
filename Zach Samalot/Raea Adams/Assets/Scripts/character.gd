extends "res://Assets/Scripts/character_core.gd"

signal info_transfer
signal hud_update

var damage_taken = 0

var health_percent = 0.0
var mana_percent = 0.0

var distance
var direction = Vector2()

export (int) var speed
export (int) var distance_buffer

onready var player = get_node("/root/Room/Player")  # gets the player node stored in player
onready var hud = get_node("/root/Room/HUD")
onready var current_target = player

var enemy


func _ready():
	character_setup()
	
	if character_type == 0:
		self.connect("info_transfer", $AttackBox, "info_transfer")
	
	if character_type == 1 or 2:
		self.connect("info_transfer", $Weapons/sword/SwordArea, "info_transfer")
		self.connect("info_transfer", $Weapons/dagger_front/DaggerArea, "info_transfer")
		self.connect("info_transfer", $Weapons/dagger_back/DaggerArea, "info_transfer")
		if character_type == 2:
			self.connect("hud_update", hud, "update_HUD")
	emit_signal("info_transfer", stats.Attack, character_type)
	if character_type == 1:
		#$Sprite.texture = load("res://Assets/Graphics/player-run-1.png")
		pass
	if character_type == 2:
		#$Sprite.texture = load("res://Assets/Graphics/player-run-1.png")
		pass
	set_physics_process(true)


func _physics_process(delta):
	if character_ready and character_type == 2:
		emit_signal("hud_update", stats.Max_Health, stats.Current_Health, stats.Max_Mana, stats.Current_Mana)
	
	if facing != str($PlayerAnim.current_animation):
		$PlayerAnim.play(facing)
	
	#If the character is within a danger zone they will get hurt
	if get_hurt:
		change_state(HURT,damage_taken)
	
	#If the character health is below 0 or equal to it they'll die
	if stats.Current_Health <= 0:
		dead = true
	
	if character_type == 0:
		if current_target.dead:
			current_target = player
		direction = current_target.position - self.position  # gets the direction the npc is facing
		distance = sqrt(direction.x * direction.x + direction.y * direction.y)  # calculates how far away player is
		if distance >= distance_buffer:  # determines if npc should move
			distance = sqrt(direction.x * direction.x + direction.y * direction.y)
		
		#This sets the facing for the AI
		if direction.y > 0:
			facing = "up"
		else:
			facing = "down"
		
		if direction.x > 0:
			facing = "right"
		else:
			facing = "left"
		
		if possible_actions.Attack:
			will_attack()
		move_and_slide(direction, Vector2(0,0))
	
	if character_type == 1:
		if current_target.dead:
			current_target = player
		direction = current_target.position - self.position  # gets the direction the npc is facing
		distance = sqrt(direction.x * direction.x + direction.y * direction.y)  # calculates how far away player is
		if distance >= distance_buffer:  # determines if npc should move
			distance = sqrt(direction.x * direction.x + direction.y * direction.y)
		if possible_actions.Attack:
			will_attack()
		
		#This sets the facing for the AI
		if direction.y < 0:
			facing = "up"
		else:
			facing = "down"
		
		if direction.x > direction.y:
			if direction.x > 0:
				facing = "right"
			else:
				facing = "left"
		
		move_and_slide(direction, Vector2(0,0))
	
	if character_type == 2:
		get_input()
		move_and_slide(velocity, Vector2(0,0))
	if stats.Current_Health <= 0:
		death()

func get_input():
	velocity = Vector2()    
	if Input.is_mouse_button_pressed(1) and character_type == 2:
		attack()
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
	$Weapons/bow.rotation = local_mouse_position.angle() # 1.55 is for fine-tuning the rotation to look at the player
	
	# Explaination of changing sprite direction
	# Determining whether or not the mouse position's x value is greater than the player's x value gets me left or right
	# Determining whether or not the mouse position's y value is greater than the player's y value get me up and down
	# Combine both calculations in order to get diagonals
	
	if mouse_position.x > position.x and mouse_position.y <= position.y + 50 and mouse_position.y >= position.y - 50:
		# The player is looking directly right
		sprite_state = "right"
		facing = "right"
		$Weapons/sword.z_index = 1
	if mouse_position.x <position.x and mouse_position.y <= position.y + 50 and mouse_position.y >= position.y - 50:
		# The player is looking directly left
		sprite_state = "left"
		facing = "left"
		$Weapons/sword.z_index = 1
	if mouse_position.y < position.y and mouse_position.x <= position.x + 50 and mouse_position.x >= position.x - 50:
		# The player is looking up
		sprite_state = "up"
		facing = "up"
		$Weapons/sword.z_index = -1
	if mouse_position.y > position.y and mouse_position.x <= position.x + 50 and mouse_position.x >= position.x - 50:
		# The player is looking down
		sprite_state = "down"
		facing = "down"
		$Weapons/sword.z_index = 1
	if mouse_position.x >= position.x + 50 and mouse_position.y <= position.y - 50:
		# The player is looking up and right
		sprite_state = "up_right"
	if mouse_position.x >= position.x + 50 and mouse_position.y >= position.y + 50:
		# The player is looking down and right
		sprite_state = "down_right"
	if mouse_position.x <= position.x - 50 and mouse_position.y <= position.y - 50:
		# The player is looking up and left
		sprite_state = "up_left"
	if mouse_position.x <= position.x - 50 and mouse_position.y >= position.y + 50:
		# The player is loooking down and left
		sprite_state = "down_left"

func will_attack():
	if possible_actions.Attack:
		emit_signal("info_transfer", stats.Attack, character_type)
		attack()

#Handles what happens when an NPC hits a body
func _on_body_entered(body): 
	if body.is_in_group("party"): #Checks to see if the body is party member
		if character_type == 0: #If the NPC is an enemy
			current_target = body #The new target is the enemy
			possible_actions.Attack = true #The enemy can now attack 
	
	if body.is_in_group("enemy"): #Checks to see if the body is an enemy
		if character_type == 1: #If the NPC is a party member
			current_target = body #The enemy body is the new target 
			possible_actions.Attack = true #The party member can now attack

#Handles what happens when the NPC leaves a body
func _on_body_exited(body):
	if body.is_in_group("party"): #If the body is a party member
		if character_type == 0: #Checks to see if the NPC is an enemy
			possible_actions.Attack = false #The enemy will stop attacking
	
	if body.is_in_group("enemy"): #Checks to see if the body is an enemy
		if character_type == 1: #Checks to see if the NPC is a party member
			possible_actions.Attack = false
			current_target = player #The NPC will go back to following the player

func _on_HitBox_area_entered(area):
	if area.is_in_group("damage"):
		if area.is_in_group("party"):
			if character_type != 2:
					damage_taken = area.damage
					change_state(HURT,damage_taken)
					#print("Line 203")
					#print(area.damage)
					get_hurt = true

		if area.is_in_group("enemy"):
			if character_type != 0:
				damage_taken = area.damage
				#print("209 Line HURT")
				change_state(HURT, damage_taken)
				get_hurt = true

func _on_BeforeHurt_timeout():
	possible_actions.Can_Hurt = true

func _on_HitBox_body_entered(body):
	if body.is_in_group("damage") and body.is_in_group("party"):
		if character_type == 0: 
			damage_taken = body.damage
			print("Line 220 HURT")
			change_state(HURT, damage_taken)

#Handles what happens once the attack cools down
func _on_AttackCooldown_timeout():
	if character_type == 2:
		possible_actions.Attack = true #Sets attack to possible for an action
	if classes.Ranger:
		$Weapons/bow/arrow.show()
	mouse_works = true

func _on_HitBox_area_exited(area):
	possible_actions.Can_Hurt = false
	get_hurt = false
