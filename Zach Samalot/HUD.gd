extends CanvasLayer

export (int) var MaxHealth = 100
export (int) var MaxMana = 100
export (int) var Mana
export (int) var Health


func _ready():
	
	#Sets the max health and mana
	
	$Health/HealthBar.max_value = MaxHealth
	$Mana/ManaBar.max_value = MaxMana


func _process(delta):
	
	#Updates the health and mana bars
	
	$Health/HealthBar.value = Health
	$Mana/ManaBar.value = Mana
	