extends Sprite2D

@onready var health_bar = $Healthbar

var hp = 10

const lines: Array[String] = [
	"Hello player, take your time and look around!",
	"Try and reduce my health",
	"Press the buttons below"
]


func _ready():
	health_bar.value = hp
	health_bar.max_value = hp
	
	
func _unhandled_input(event) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		DialogueManager.show_dialogue_balloon(load("res://dialogue/main.dialogue"), "start")
		return

func _on_add_health_pressed():
	hp += 1
	health_bar.value = hp
	
func _on_subtract_health_pressed():
	hp -= 1
	health_bar.value = hp


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

