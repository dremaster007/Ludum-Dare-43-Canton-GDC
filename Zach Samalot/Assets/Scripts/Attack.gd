extends Area2D

var damage = 0
var npc_type = 0

func _on_NPC_Core_damage_transfer(new_damage, npc):
	damage = new_damage
	npc_type = npc
	if npc == 0:
		add_to_group("enemy")
	if npc == 1:
		add_to_group("party")