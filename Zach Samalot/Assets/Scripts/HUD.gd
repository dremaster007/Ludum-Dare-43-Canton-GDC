extends CanvasLayer

export (int) var MaxHealth = 100
export (int) var MaxMana = 100
export (int) var MaxDurability = 100
export (int) var Durability = 20
export (int) var Mana = 20
export (int) var Health = 20
export (int) var ItemCount = 20


func _ready():
	
	#Sets the max health, durability and mana
	
	$Health/HealthBar.max_value = MaxHealth
	$Mana/ManaBar.max_value = MaxMana
	$Gear/Durability/DuraBar.max_value = MaxDurability


func _process(delta):
	update_HUD()
	

func update_HUD():
	#Updates the health, durability and mana bars
	$Health/HealthBar.value = Health
	$Mana/ManaBar.value = Mana
	$Gear/Durability/DuraBar.value = Durability
	$Gear/ItemContainer/ItemCount.text = str(ItemCount)
	if game_info.inventory.Weapon == "None":
		#Insert empty weapon sprite
		$Gear/WeaponContainer/Weapon.texture = load("res://Assets/Graphics/Weapons/WeaponPlaceholder.png")
	elif game_info.inventory.Weapon == "Dagger":
		#Insert weapon obtain sprite
		$Gear/WeaponContainer/Weapon.texture = load("res://Assets/Graphics/Weapons/dagger.png")
	elif game_info.inventory.Weapon == "Sword":
		$Gear/WeaponContainer/Weapon.texture = load("res://Assets/Graphics/Weapons/sword.png")
	elif game_info.inventory.Weapon == "Bow":
		$Gear/WeaponContainer/Weapon.texture = load("res://Assets/Graphics/Weapons/bow.png")
	elif game_info.inventory.Weapon == "Staff":
		$Gear/WeaponContainer/Weapon.texture = load("res://Assets/Graphics/Weapons/staff.png")
	print("HUD updated")