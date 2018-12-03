extends Area2D

var damage = 0
var character_type = -5

func info_transfer(new_damage, new_type):
	damage = new_damage
	character_type = new_type
