extends KinematicBody2D

#The states the character can be in
enum {IDLE, MOVING, ATTACK, HURT, DEAD} 
var state = IDLE #The current state of the character
export (PackedScene) var arrow_scene #The arrow scene that is instanced

export (int) var move_speed #How fast the character can move
var damage_taking = 0 #The damage the player is still taking
var dead = false #If the scene is alive or dead this fixes some serious crashing
var mouse_works = true #This tells if the mouse can be used or not. A manual Just Pressed function

var is_colliding = false #If the character is colliding with an enemy

var character_ready = false #Is the character ready to be used in play

var velocity = Vector2() #How fast the character is moving
var mouse_position = Vector2() #Where is the mouse positioned on the scene
var local_mouse_position = Vector2() 

var sprite_state
var facing = "down" #This will determine which way the player or NPC is facing

#Player determines if it's a human player or NPC, 0 = Enemy | 1 = NPC | 2 = Human 
export (int) var character_type = 0

#Determines which party member the NPC is
export (int) var party_member = -1

#All the stats that make up the player
var stats = {"Current_Health": 0, 
             "Max_Health": 0, 
             "Attack": 0,
             "Attack_Speed": 0.0,
            }

#Holds all the textures for enemies
var enemy_textures = {"Slime": "res://Assets/Graphics/Enemies/Slime/Slime_spritesheet.png",
                      "Goblin": "res://Assets/Graphics/Enemies/Goblin/Goblin_spritesheet.png",
                      "Shadow Goblin": "res://Assets/Graphics/Enemies/Shadow_goblin/Shadow_goblin_spritesheet.png"
                      }
#Holds the names of all the enemy textures
var enemy_tex_array = ["Slime", "Goblin", "Shadow Goblin"]

#This holds the classes as bools so they can be clicked on or off
export var classes = {"Knight": false,
                      "Rogue": false,
                      "Ranger": false
                      }

#These tell the game what the player can do
var possible_actions = {"Attack": true, "Pickup": false, "Can_Hurt": true,}

#Is the character getting hurt right now?
var get_hurt = false

#Used for random generation
var stat_number #This makes it easier to modify the stat limit to multiple difficulties
var rand_num

func _ready():
	#Sets the Attack to a possible movement
	possible_actions.Attack = true 

#The tween that's played when hurt
func hurt_tween():
	$HurtFX.restart()
	$HurtTween.interpolate_property($Sprite, "modulate", Color(200,0,0,1), Color(1,1,1,1), 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$HurtTween.start()

#Function that handles changing the state of the character
func change_state(new_state, new_damage):
	state = new_state #Changes current state to the new state
	damage_taking = new_damage #Damage taking is set to the new damage
	match state:
		IDLE:
			pass
		MOVING:
			pass
		ATTACK:
			pass
		HURT:
			if possible_actions.Can_Hurt: #When it's possible to get hurt
				if character_type == 1: #If the character is a party member
					if party_member == 1: #Checks to see which party member
						game_info.party.Member1.Current_Health = stats.Current_Health
					if party_member == 2:
						game_info.party.Member2.Current_Health = stats.Current_Health
					if party_member == 3:
						game_info.party.Member3.Current_Health = stats.Current_Health
				
				stats.Current_Health -= damage_taking #Takes damage away from health
				if character_type == 0:#If the character is an enemy
					print(str(stats.Current_Health) + " / " + str(stats.Max_Health))
				
				$HitSFX.play() #Hit sound is played
				possible_actions.Can_Hurt = false #Starts immortal phase of getting hit
				get_hurt = false #You can't get hurt while being hurt
				$BeforeHurt.start() #Starts the cooldown for the the immortal phase
		DEAD:
			pass

func character_setup():
	#If the character is a party member
	if character_type == 1:
		if party_member == 0: #Checks the party members
			$Sprite.texture = load(game_info.party.Member1.Texture) #Sets the sprite texture
			stats.Max_Health = game_info.party.Member1.Max_HP #Sets local Max Health to global Max Health
			stats.Current_Health = game_info.party.Member1.Current_HP #Sets local current health to global current health
			stats.Attack = game_info.party.Member1.Attack #Sets local attack to the global attack
		if party_member == 1:
			$Sprite.texture = load(game_info.party.Member2.Texture)
			stats.Max_Health = game_info.party.Member2.Max_HP
			stats.Current_Health = game_info.party.Member2.Current_HP
			stats.Attack = game_info.party.Member2.Attack
		if party_member == 2:
			$Sprite.texture = load(game_info.party.Member3.Texture)
			stats.Max_Health = game_info.party.Member3.Max_HP
			stats.Current_Health = game_info.party.Member3.Current_HP
			stats.Attack = game_info.party.Member3.Attack
		
		#Class check
		if classes.Knight:
			stats.Current_Health = 150
			stats.Max_Health = 150
			stats.Max_Mana = 50
			stats.Defense = 20
			stats.Attack = 5
			stats.Attack_Speed = 1.5
			$Weapons/sword.show()
			if party_member == 1:
				game_info.party.Member1.Max_HP = stats.Max_Health
				game_info.party.Member1.Current_HP = stats.Current_Health
				game_info.party.Member1.Attack = stats.Attack
			if party_member == 2:
				game_info.party.Member2.Max_HP = stats.Max_Health
				game_info.party.Member2.Current_HP = stats.Current_Health
				game_info.party.Member2.Attack = stats.Attack
			if party_member == 3:
				game_info.party.Member3.Max_HP = stats.Max_Health
				game_info.party.Member3.Current_HP = stats.Current_Health
				game_info.party.Member3.Attack = stats.Attack
		if classes.Rogue:
			stats.Current_Health = 70
			stats.Max_Health = 70
			stats.Max_Mana = 60
			stats.Defense = 6
			stats.Attack = 3
			stats.Attack_Speed = 0.3
			$Weapons/dagger_front.show()
			$Weapons/dagger_back.show()
	
	#If the character is the player
	if character_type == 2:
		$Sprite.texture = load(game_info.party_textures.Player) #Sets the player sprite
		if game_info.inventory.Weapon == "Sword": #If a sword is in the inventory
			classes.Knight = true #Sets "class" to Knight
		if game_info.inventory.Weapon == "Dagger":
			classes.Rogue = true
		if game_info.inventory.Weapon == "Bow":
			classes.Ranger = true
		
		#Class check
		if classes.Knight:
			stats.Current_Health = 150
			stats.Max_Health = 150
			stats.Max_Mana = 50
			stats.Defense = 20
			stats.Attack = 5
			stats.Attack_Speed = 1.5
			$Weapons/sword.show()
		if classes.Rogue:
			stats.Current_Health = 70
			stats.Max_Health = 70
			stats.Max_Mana = 60
			stats.Defense = 6
			stats.Attack = 3
			stats.Attack_Speed = 0.3
			$Weapons/dagger_front.show()
			$Weapons/dagger_back.show()
		if classes.Ranger:
			stats.Current_Health = 100
			stats.Max_Health = 100
			stats.Max_Mana = 50
			stats.Defense = 7
			stats.Attack = 8
			stats.Attack_Speed = 3.0
			$Weapons/bow.show()
			$Weapons/bow/arrow.show()
	
	#If the character is an enemy
	if character_type == 0:
		print("Enemy")
		stats.Max_Health = 10 #Sets the max health 
		stats.Current_Health = 10 #Sets the current health
		stats.Attack = 40 #Sets the attack damage
	
	stats.Current_Health = stats.Max_Health
	

func character_resume():
	if party_member == 1:
		stats.Max_Health = game_info.party.Member1.Max_HP
		stats.Current_Health = game_info.party.Member1.Current_HP
		stats.Attack = game_info.party.Member1.Attack 
	if party_member == 2:
		stats.Max_Health = game_info.party.Member2.Max_HP
		stats.Current_Health = game_info.party.Member2.Current_HP
		stats.Attack = game_info.party.Member2.Attack 
	if party_member == 3:
		stats.Max_Health = game_info.party.Member3.Max_HP
		stats.Current_Health = game_info.party.Member3.Current_HP
		stats.Attack = game_info.party.Member3.Attack 

#This handles the attack
func attack():
	#If it's possible to attack
	if possible_actions.Attack:
		if character_type == 1 or 2:
			if character_type == 2 and mouse_works:
				mouse_works = false
			if classes.Knight:
				$AttackAnim.play("sword_swing_%s" % facing)
				$Weapons/sword/SwordArea.damage = stats.Attack
				print("Knight!")
			if classes.Rogue:
				$AttackAnim.play("dagger_slash_%s" % facing)
				$Weapons/dagger_front/DaggerArea.damage = stats.Attack
				$Weapons/dagger_back/DaggerArea.damage = stats.Attack
		#Not sure how AI will shoot arrows
			if classes.Ranger and character_type == 2:
				var a = arrow_scene.instance()
				$Weapons/bow/ArrowSpawn.add_child(a)
				a.hide()
				a.position = self.position
				a.show()
				a.damage = stats.Attack
				a.rotation = local_mouse_position.angle()
				a.velocity.x = local_mouse_position.x * 2
				a.velocity.y = local_mouse_position.y * 2
				a.character_type = character_type
				$Weapons/bow/arrow.hide()
		$AttackCooldown.wait_time = stats.Attack_Speed
		possible_actions.Attack = false #Sets the attack action to impossible
		$AttackCooldown.start() #Starts the attack cooldown timer

func death():
	if character_type == 0:
		is_colliding = false
		print("enemy dead")
		queue_free()
	if character_type == 1:
		if party_member == 1:
			game_info.member1_dead = true
		if party_member == 2:
			game_info.member2_dead = true
		if party_member == 3:
			game_info.member3_dead = true
	if character_type == 2:
		get_tree().change_scene("res://Assets/Scenes/CreditsScene.tscn")