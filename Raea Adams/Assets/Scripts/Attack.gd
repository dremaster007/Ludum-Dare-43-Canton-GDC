extends Area2D

var damage = 0
var character_type = 0

func _on_NPC_Core_damage_transfer(new_damage, type):
	damage = new_damage
	character_type = type
	if type == 0:
		add_to_group("enemy")
	if type == 1:
		add_to_group("party")