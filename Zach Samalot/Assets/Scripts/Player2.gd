extends Area2D

export (int) var speed
var velocity = Vector2()

signal pickup
signal hurt
signal paused
signal not_paused

func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.animation = "idle"

func _process(delta):
	get_input()
	position += velocity * delta
	
	if velocity.length() > 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.animation = "idle"
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

func _on_Player_area_entered(area):
	if area.is_in_group("weapons"):
		area.pickup()
		emit_signal("pickup", "weapons")
		print("Picked up a dagger")
	if area.is_in_group("healthpot"):
		area.pickup()
		emit_signal("pickup", "healthpot")
	if area.is_in_group("manapot"):
		area.pickup()
		emit_signal("pickup", "manapot")