extends Control
class_name Demo

@onready var healthbar = $Panel/Healthbar

var health : int


# Called when the node enters the scene tree for the first time.
func _ready():
	health = 10
	healthbar.init_health(health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _set_health(value):
	#_set_health(health)
	
	healthbar.health = health
	

func _on_damage_btn_pressed():
	health -= 1
	print("Current health is " + str(health))

func _on_heal_btn_pressed():
	health += 1
