extends KinematicBody2D

#This determines what kind of npc it is
#0 = Enemy | 1 = Party Member
export (int) var npc_type = 0

var possible_actions = {"Attack": false, "Move": false, "Heal": false}

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

func _on_body_entered(body):
	if body.is_in_group("player"):
		if npc_type == 0:
			current_target = body
			possible_actions.Attack = true
			print("New target")
	if body.is_in_group("enemy"):
		if npc_type == 1:
			enemy = body
			current_target = enemy
			print(current_target)
			possible_actions.Attack = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		if npc_type == 0:
			possible_actions.Attack = false
	if body.is_in_group("enemy"):
		if npc_type == 1:
			print(current_target)
			current_target = player