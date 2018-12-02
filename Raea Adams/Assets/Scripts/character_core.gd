extends KinematicBody2D

#Player determines if it's a human player or NPC, 0 = NPC | 1 = Human
var player_type = 0
var stats = {"Current_Health": 0, 
             "Max_Health": 0, 
             "Mana": 0, 
             "Attack": 0,
             "Attack_Speed": 0,
             "Defense": 0,
            }

var possible_actions = {"Attack": false, "Pickup": false, "Can_Hurt": true,}
var get_hurt = false

func attack():
	if possible_actions.Attack:
		$Attack/CollisionShape2D.disabled = false
		possible_actions.Attack = false
		$AttackDuration.start()

func hurt(damage_taken):
	if possible_actions.Can_Hurt:
		stats.Current_Health -= damage_taken
		possible_actions.Can_Hurt = false
		$BeforeHurt.start()
		print("Damage Taken")

func death():
	queue_free()