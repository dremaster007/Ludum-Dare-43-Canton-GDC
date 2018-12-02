extends CanvasLayer

export (int) var MaxHealth = 100
export (int) var MaxMana = 100
export (int) var MaxDurability = 100
export (int) var Durability
export (int) var Mana
export (int) var Health
export (int) var ItemCount


func _ready():
	
	#Sets the max health, durability and mana
	
	$Health/HealthBar.max_value = MaxHealth
	$Mana/ManaBar.max_value = MaxMana
	$Gear/Durability/DuraBar.max_value = MaxDurability


func _process(delta):
	
	#Updates the health, durability and mana bars
	
	$Health/HealthBar.value = Health
	$Mana/ManaBar.value = Mana
	$Gear/Durability/DuraBar.value = Durability
	$Gear/ItemContainer/ItemCount.text = str(ItemCount)
	
	