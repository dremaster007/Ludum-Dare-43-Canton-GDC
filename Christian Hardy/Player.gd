extends Area2D

export (int) var speed

var velocity = Vector2()
var mouse_position = Vector2()
var local_mouse_position = Vector2()

export (Texture) var runCycleRight
var runCycleRightArray = [6,3]

export (Texture) var runCycleLeft
var runCycleLeftArray = [5,3]

var sprite_state

func _ready():
	#change_sprite(runCycleRight, runCycleRightArray, "running_right")
	pass
	
func _process(delta):
	get_input()
	position += velocity * delta

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
	mouse_position = get_global_mouse_position()
	local_mouse_position = get_local_mouse_position()
	rotation += local_mouse_position.angle() + 1.55  # 1.55 is for fine-tuning the rotation to look at the player
	
	# Explaination of changing sprite direction
	# Determining whether or not the mouse position's x value is greater than the player's x value gets me left or right
	# Determining whether or not the mouse position's y value is greater than the player's y value get me up and down
	# Combine both calculations in order to get diagonals
	
	if mouse_position.x > position.x and mouse_position.y <= position.y + 50 and mouse_position.y >= position.y - 50:
		# The player is looking directly right
		sprite_state = "right"
		change_sprite("running_right")
	if mouse_position.x < position.x and mouse_position.y <= position.y + 50 and mouse_position.y >= position.y - 50:
		# The player is looking directly left
		sprite_state = "left"
		change_sprite("running_left")
	if mouse_position.y < position.y and mouse_position.x <= position.x + 50 and mouse_position.x >= position.x - 50:
		# The player is looking up
		sprite_state = "up"
	if mouse_position.y > position.y and mouse_position.x <= position.x + 50 and mouse_position.x >= position.x - 50:
		# The player is looking down
		sprite_state = "down"
	if mouse_position.x >= position.x + 50 and mouse_position.y <= position.y - 50:
		# The player is looking up and right
		sprite_state = "up_right"
	if mouse_position.x >= position.x + 50 and mouse_position.y >= position.y + 50:
		# The player is looking down and right
		sprite_state = "down_right"
	if mouse_position.x <= position.x - 50 and mouse_position.y <= position.y - 50:
		# The player is looking up and left
		sprite_state = "up_left"
	if mouse_position.x <= position.x - 50 and mouse_position.y >= position.y + 50:
		# The player is loooking down and left
		sprite_state = "down_left"
		
func change_sprite(anim_name):
	$Sprite/AnimationPlayer.current_animation = anim_name






