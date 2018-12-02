extends KinematicBody2D


enum {IDLE, MOVING, ATTACK, HURT, DEAD} 

export (PackedScene) var arrow_scene

export (int) var move_speed #How fast the character can move
var damage_taking = 0 #The damage the player is still taking
var dead = false #If the scene is alive or dead this fixes some serious crashing
var mouse_works = true #This tells if the mouse can be used or not. A manual Just Pressed function

var velocity = Vector2()
var mouse_position = Vector2()
var local_mouse_position = Vector2()

var sprite_state
var facing = "down" #This will determine which way the player or NPC is facing

#Player determines if it's a human player or NPC, 0 = Enemy | 1 = NPC | 2 = Human 
export (int) var character_type = 0

#All the stats that make up the player
var stats = {"Current_Health": 0, 
             "Max_Health": 0, 
             "Mana": 0, 
             "Attack": 0,
             "Attack_Speed": 0.0,
             "Defense": 0,
             "Level": 0
            }

#This holds the classes as bools so they can be clicked on or off
var classes = {"Knight": false,
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
	character_setup()
	possible_actions.Attack = true

func change_state(new_state):
	pass

func character_setup():
	classes.Ranger = true
	
	if character_type == 0:
		randomize()
		
		if game_info.current_difficulty == 0: #Checks the difficulty of the level
			stat_number = 10 #Sets the stat number to the highest each stat can be
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
			stats.Mana = 50
			stats.Defense = 20
			stats.Attack = 4
			stats.Attack_Speed = 1.5
			$Weapons/sword.show()
		if classes.Rogue:
			stats.Current_Health = 70
			stats.Max_Health = 70
			stats.Mana = 60
			stats.Defense = 6
			stats.Attack = 3
			stats.Attack_Speed = 0.3
			$Weapons/dagger_front.show()
			$Weapons/dagger_back.show()
		if classes.Healer:
			stats.Current_Health = 100
			stats.Max_Health = 100
			stats.Mana = 100
			stats.Defense = 4
			stats.Attack = 1
			stats.Attack_Speed = 1.5
			$Weapons/staff.show()
		if classes.Ranger:
			stats.Current_Health = 100
			stats.Max_Health = 100
			stats.Mana = 50
			stats.Defense = 7
			stats.Attack = 999999
			stats.Attack_Speed = 4
			$Weapons/bow.show()
			$Weapons/bow/arrow.show()
	
#This is used to add/subtract stats
func stat_update(hp_change, mana_change):
	stats.Max_Health += hp_change
	stats.Current_Health += hp_change
	stats.Mana += mana_change

#This handles the attack
func attack():
	if possible_actions.Attack:
		if character_type == 1 or 2:
			if Input.is_mouse_button_pressed(1) and possible_actions.Attack and mouse_works:
				mouse_works = false
			if classes.Knight:
				$AttackAnim.play("sword_swing_%s" % facing)
				$sword/SwordArea.damage = stats.Attack
		
			if classes.Rogue:
				$AttackAnim.play("dagger_slash_%s" % facing)
				$dagger_front/DaggerArea.damage = stats.Attack
				$dagger_back/DaggerArea.damage = stats.Attack
		
		#Not sure how AI will shoot arrows
			if classes.Ranger and character_type == 2:
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
		possible_actions.Attack = false #Sets the attack action to impossible
		$AttackCooldown.start() #Starts the attack cooldown timer

func hurt(damage_taken):
	if possible_actions.Can_Hurt:
		stats.Current_Health -= damage_taken
		possible_actions.Can_Hurt = false
		$BeforeHurt.start()

func death():
	queue_free()