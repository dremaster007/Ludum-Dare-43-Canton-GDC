extends Area2D

export (int) var speed

var velocity = Vector2()
var mouse_position = Vector2()

func _ready():
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
	mouse_position = get_local_mouse_position()
	rotation += mouse_position.angle() +1.55
