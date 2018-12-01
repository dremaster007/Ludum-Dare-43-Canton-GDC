extends "res://Assets/Scripts/character_core.gd"

#This determines what kind of npc it is
#0 = Enemy | 1 = Party Member
export (int) var npc_type = 0

var rand_num = 0 #Used for random "rolls"
var enemy_difficulty = 0 #This is how the hard enemy will be to defeat

var distance
var direction = Vector2()

export (int) var speed
export (int) var distance_buffer


onready var player = get_node("/root/Room/Player")  # gets the player node stored in player
var enemy

onready var current_target = player

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	direction = current_target.position - self.position  # gets the direction the npc is facing
	distance = sqrt(direction.x * direction.x + direction.y * direction.y)  # calculates how far away player is
	if distance >= distance_buffer:  # determines if npc should move
		distance = sqrt(direction.x * direction.x + direction.y * direction.y)
		#if direction.x <= 0:
			#$AnimatedSprite.flip_h = true
		#elif direction.x > 0:
			#$AnimatedSprite.flip_h = false
	#else:
	move_and_slide(direction, Vector2(0,0))

#Handles what happens when an NPC hits a body
func _on_body_entered(body): 
	if body.is_in_group("player"): #Checks to see if the body is party member
		if npc_type == 0: #If the NPC is an enemy
			current_target = body #The new target is the enemy
			possible_actions.Attack = true #The enemy can now attack 
	
	if body.is_in_group("enemy"): #Checks to see if the body is an enemy
		if npc_type == 1: #If the NPC is a party member
			current_target = body #The enemy body is the new target 
			possible_actions.Attack = true #The party member can now attack

#Handles what happens when the NPC leaves a body
func _on_body_exited(body):
	if body.is_in_group("player"): #If the body is a party member
		if npc_type == 0: #Checks to see if the NPC is an enemy
			possible_actions.Attack = false #The enemy will stop attacking
	
	if body.is_in_group("enemy"): #Checks to see if the body is an enemy
		if npc_type == 1: #Checks to see if the NPC is a party member
			current_target = player #The NPC will go back to following the player