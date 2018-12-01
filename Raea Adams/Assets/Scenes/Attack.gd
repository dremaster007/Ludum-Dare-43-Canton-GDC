extends Area2D

var damage = 0

func _on_NPC_Core_damage_transfer(new_damage):
	damage = new_damage
