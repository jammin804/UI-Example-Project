extends Sprite2D

@onready var health_bar = $Healthbar

var hp = 10



const lines: Array[String] = [
	"Hello player, take your time and look around!",
	"Try and reduce my health",
	"Press the buttons below"
]


func _ready():
	_broadcasting()
	health_bar.value = hp
	health_bar.max_value = hp
	
	
func _unhandled_input(_InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		DialogueManager.show_dialogue_balloon(load("res://dialogue/main.dialogue"), "start")
		return

func add_health():
	hp += 1
	health_bar.value = hp
	
func subtract_health():
	hp -= 1
	health_bar.value = hp


func _broadcasting():
	Broadcast.listen("on_add_health_pressed", self, "add_health")
	Broadcast.listen("on_subtract_health_pressed", self, "subtract_health")
	Broadcast.listen("on_back_pressed", self, "go_back")

func go_back():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

