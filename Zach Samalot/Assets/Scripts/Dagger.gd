extends Area2D

var ButtonScale
var PickedUp = false
var player
#var HUD = get_parent().get_node("HUD")

func _ready():
	ButtonScale = $ButtonPickup.rect_scale
	
func _process(delta):
	pass
	
func buttonTween(appear):
	if appear == 1:
		$ButtonPickup.visible = true
		$ButtonPopup.interpolate_property($ButtonPickup, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		$ButtonPopup.interpolate_property($ButtonPickup, "rect_scale", $ButtonPickup.rect_scale / 60, ButtonScale, 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		$ButtonPopup.start()
	else:
		$ButtonPopup.interpolate_property($ButtonPickup, "modulate", Color(1,1,1,1), Color(1,1,1,0), 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		$ButtonPopup.interpolate_property($ButtonPickup, "rect_scale", ButtonScale, $ButtonPickup.rect_scale / 60, 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		$ButtonPopup.start()
	
func _on_Dagger_body_entered(body):
	if body.is_in_group("player"):
		player = body
		print("Body Entered")
		buttonTween(1)
		

func _on_Dagger_body_exited(body):
	if body.is_in_group("player"):
		player = body
		print("Body Exited")
		buttonTween(0)


func _on_ButtonPopup_tween_completed(object, key):
	print("tween complete")


func _on_ButtonPopup_tween_started(object, key):
	print("tween started")


func _on_ButtonPickup_pressed():
	PickedUp = true
	buttonTween(0)
	player.dagger()
	#queue_free()