extends CanvasLayer

export (int) var MaxDurability = 100
export (int) var Durability = 0
export (int) var ItemCount = 0

func update_HUD(max_health, health_left, max_mana, mana_left):
	#Updates the health, durability and mana bars
	$Health/HealthDisplay.max_value = max_health
	$Health/HealthDisplay.value = health_left
	$Mana/ManaDisplay.max_value = max_mana
	$Mana/ManaDisplay.value = mana_left
	$Gear/Durability/DuraBar.value = Durability
	$Gear/ItemContainer/ItemCount.text = str(ItemCount)

func update_health(health):
	$Health/HealthDisplay.value= health
	
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
	
	if game_info.inventory.Item == "None":
		#Insert empty weapon sprite
		$Gear/ItemContainer/Item.texture = load("res://Assets/Graphics/Items/PlaceholderPot.png")
	elif game_info.inventory.Item == "HealthPot":
		#Insert item obtain sprite
		$Gear/ItemContainer/Item.texture = load("res://Assets/Graphics/Items/health_potion.png")
	elif game_info.inventory.Item == "ManaPot":
		$Gear/ItemContainer/Item.texture = load("res://Assets/Graphics/Items/mana_potion.png")
