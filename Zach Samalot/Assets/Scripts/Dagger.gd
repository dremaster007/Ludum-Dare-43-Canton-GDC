extends Area2D

var ButtonScale
var PickedUp = false
export (int) var Durability
export (int) var ItemType
var Item
var ItemClass

var player

signal pickup
signal item
signal weapon


func _ready():
	ButtonScale = $ButtonPickup.rect_scale
	
	match ItemType:
		
		0:
			#Dagger Properties
			Item = "Dagger"
			ItemClass = "Weapon"
			$Sprite.texture = load("res://Assets/Graphics/Weapons/dagger.png")
			$ButtonPickup/ItemName.text = "Dagger"
		
		1:
			#Sword Properties
			Item = "Sword"
			ItemClass = "Weapon"
			$Sprite.texture = load("res://Assets/Graphics/Weapons/sword.png")
			$ButtonPickup/ItemName.text = "Sword"
		
		2:
			#Bow Properties
			Item = "Bow"
			ItemClass = "Weapon"
			$Sprite.texture = load("res://Assets/Graphics/Weapons/bow.png")
			$ButtonPickup/ItemName.text = "Bow"
		
		3:
			#Staff Properties
			Item = "Staff"
			ItemClass = "Weapon"
			$Sprite.texture = load("res://Assets/Graphics/Weapons/staff.png")
			$ButtonPickup/ItemName.text = "Staff"
			
		4:
			#Mana Potion Properties
			Item = "ManaPot"
			ItemClass = "Item"
			$Sprite.texture = load("res://Assets/Graphics/Items/mana_potion.png")
			$ButtonPickup/ItemName.text = "Mana Potion"
			
		5:
			#Health Potion Properties
			Item = "HealthPot"
			ItemClass = "Item"
			$Sprite.texture = load("res://Assets/Graphics/Items/health_potion.png")
			$ButtonPickup/ItemName.text = "Health Potion"
		
func _process(delta):
	pass
	
func buttonTween(appear):
	if appear == 1:
		$ButtonPickup.disabled = false
		$ButtonPopup.interpolate_property($ButtonPickup, "modulate", Color(1,1,1,0), Color(1,1,1,1), 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		$ButtonPopup.interpolate_property($ButtonPickup, "rect_scale", $ButtonPickup.rect_scale / 60, ButtonScale, 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		$ButtonPopup.start()
	else:
		$ButtonPickup.disabled = true
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


func _on_ButtonPickup_pressed():
	PickedUp = true
	buttonTween(0)
	
	match ItemClass:
		
		"Weapon":
			game_info.inventory.Weapon = Item
			emit_signal("pickup", "weapon")
			
		
		"Item":
			game_info.inventory.Item = Item
			emit_signal("pickup", "item")
			
		
	
	player.pickup()
	queue_free()