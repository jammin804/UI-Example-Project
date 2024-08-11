extends Sprite2D

@onready var health_bar = $Healthbar

var hp = 10


func _ready():
	health_bar.value = hp
	health_bar.max_value = hp
	

func _on_add_health_pressed():
	hp += 1
	health_bar.value = hp
	
func _on_subtract_health_pressed():
	hp -= 1
	health_bar.value = hp


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn")
