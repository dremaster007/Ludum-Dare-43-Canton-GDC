extends KinematicBody2D

#Player determines if it's a human player or NPC, 0 = NPC | 1 = Human
var player = 0
var stats = {"Current_Health": 0, 
             "Max_Health": 0, 
             "Mana": 0, 
             "Attack": 0,
             "Defense": 0
            }

var possible_actions = {"Attack": false, "Pickup": false}

func attack(type):
	if possible_actions.Attack:
		pass

#func death():
	#queue_free()