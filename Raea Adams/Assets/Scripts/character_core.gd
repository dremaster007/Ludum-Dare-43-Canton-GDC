extends KinematicBody2D

enum {IDLE, MOVING, ATTACK, HURT, DEAD} 
var state = IDLE
export (PackedScene) var arrow_scene

export (int) var move_speed #How fast the character can move
var damage_taking = 0 #The damage the player is still taking
var dead = false #If the scene is alive or dead this fixes some serious crashing
var mouse_works = true #This tells if the mouse can be used or not. A manual Just Pressed function

var character_ready = false

var velocity = Vector2()
var mouse_position = Vector2()
var local_mouse_position = Vector2()

var sprite_state
var facing = "down" #This will determine which way the player or NPC is facing

#Player determines if it's a human player or NPC, 0 = Enemy | 1 = NPC | 2 = Human 
export (int) var character_type = 0
export (int) var party_member = -1
#All the stats that make up the player
var stats = {"Current_Health": 0, 
             "Max_Health": 0, 
             "Current_Mana": 0, 
             "Max_Mana": 0,
             "Attack": 0,
             "Attack_Speed": 0.0,
             "Defense": 0,
             "Level": 0
            }

#This holds the classes as bools so they can be clicked on or off
export var classes = {"Knight": false,
               "Rogue": false,
               "Healer": false,
               "Ranger": false
              }

#These tell the game what the player can do
var possible_actions = {"Attack": false, "Pickup": false, "Can_Hurt": true,}
var get_hurt = false

var stat_number #This makes it easier to modify the stat limit to multiple difficulties
var rand_num

func _ready():
	possible_actions.Attack = true

func change_state(new_state, new_damage):
	state = new_state
	damage_taking = new_damage
	match state:
		IDLE:
			pass
		MOVING:
			pass
		ATTACK:
			pass
		HURT:
			if possible_actions.Can_Hurt:
				if character_type == 2:
					print("Player Health: " + str(stats.Current_Health))
				$BloodParticle.emitting = true
				stats.Current_Health -= damage_taking
				$BeforeHurt.start()
				$BloodParticle.emitting = false
				if character_type == 0:
					print(str(stats.Current_Health) + " / " + str(stats.Max_Health))
				possible_actions.Can_Hurt = false
				get_hurt = false
				$BeforeHurt.start()
				print("HURT")
		DEAD:
			pass

func character_setup():
	if character_type == 1:
		if party_member == 0:
			$Sprite.texture = load(game_info.party.Member1)
		if party_member == 1:
			$Sprite.texture = load(game_info.party.Member2)
		if party_member == 2:
			$Sprite.texture = load(game_info.party.Member3)
	
	if character_type == 2:
		$Sprite.texture = load(game_info.party.Player)
	
	if character_type == 0:
		randomize()
		
		if game_info.current_difficulty == 0: #Checks the difficulty of the level
			stat_number = 5 #Sets the stat number to the highest each stat can be
			stats.Level = 0 #Sets the difficulty of the enemy
		if game_info.current_difficulty == 1:
			stat_number = 20
			stats.Level = 1
		if game_info.current_difficulty == 2:
			stat_number = 30
			stats.Level = 2
		if game_info.current_difficulty == 3:
			stat_number = 40
			stats.Level = 3
		if game_info.current_difficulty == 4:
			stat_number = 40
			stats.Level = 4
		
		rand_num = randi()%stat_number #Sets the random number 
		stats.Max_Health = rand_num #Sets the health to the random number
		rand_num = randi()%stat_number
		stats.Mana = rand_num #Sets the Mana to the random number
		rand_num = randi()%stat_number
		stats.Attack = rand_num #Sets the Attack to the random number
		rand_num = randi()%stat_number
		stats.Defense = rand_num #Sets the Defense to the random number
	
	#Player and Party setup
	if character_type == 1 or 2:
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
		if classes.Healer:
			stats.Current_Health = 100
			stats.Max_Health = 100
			stats.Max_Mana = 100
			stats.Defense = 4
			stats.Attack = 1
			stats.Attack_Speed = 1.5
			$Weapons/staff.show()
		if classes.Ranger:
			stats.Current_Health = 100
			stats.Max_Health = 100
			stats.Max_Mana = 50
			stats.Defense = 7
			stats.Attack = 5
			stats.Attack_Speed = 4.0
			$Weapons/bow.show()
			$Weapons/bow/arrow.show()
	stats.Current_Health = stats.Max_Health
	character_ready = true

#This is used to add/subtract stats
func stat_update(hp_change, mana_change):
	stats.Max_Health += hp_change
	stats.Current_Health += hp_change
	stats.Mana += mana_change

#This handles the attack
func attack():
	if possible_actions.Attack:
		if character_type == 1 or 2:
			if character_type == 2 and possible_actions.Attack and mouse_works:
				mouse_works = false
			if classes.Knight:
				$AttackAnim.play("sword_swing_%s" % facing)
				$Weapons/sword/SwordArea.damage = stats.Attack
		
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
	queue_free()