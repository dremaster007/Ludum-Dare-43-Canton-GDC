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

var possible_actions = {"Attack": false, "Pickup": false}

func attack(type):
	if possible_actions.Attack:
		pass

func hurt(damage_taken):
	stats.Current_Health -= damage_taken
	print(damage_taken)
	print(stats.Current_Health)
	#The area2D will be used as attack boxes
	#When an enemy attack box is entered it calls this function with one argument

#func death():
	#queue_free()