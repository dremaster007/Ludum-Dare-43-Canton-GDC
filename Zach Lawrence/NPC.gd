extends Area2D

var distance

var direction = Vector2()

export (int) var speed
export (int) var distance_buffer

onready var player = get_node("/root/Main/Player")  # gets the player node stored in player

func _ready():
	pass

func _process(delta):
	direction = player.position - self.position  # gets the direction the npc is facing
	distance = sqrt(direction.x * direction.x + direction.y * direction.y)  # calculates how far away player is
	if distance >= distance_buffer:  # determines if npc should move
		distance = sqrt(direction.x * direction.x + direction.y * direction.y)
		position += direction.normalized() * speed * delta
		if direction.x <= 0:
			$AnimatedSprite.flip_h = true
		elif direction.x > 0:
			$AnimatedSprite.flip_h = false
	else:
		position += direction.normalized() * 0 * delta