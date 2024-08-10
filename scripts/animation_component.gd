class_name AnimationComponent extends Node



@export_group("Options")
@export var from_center : bool = true
@export var tranistion_type : Tween.TransitionType
@export var hover_time : float = 0.1
@export var hover_scale : Vector2 = Vector2(1,1)


var target : Control
var default_scale : Vector2
var hover_values: Dictionary
var default_values: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = get_parent()
	
	_connect_signals()
	call_deferred("_setup")
	
func _connect_signals() -> void:
	target.mouse_entered.connect(_on_hover)
	target.mouse_exited.connect(_on_hover_end)
	
func _setup() -> void:
	if from_center:
		target.pivot_offset = target.size / 2 #gives us the middle point of the button
	default_scale = target.scale #saves the scale of the button on the intial load
	
func _on_hover() -> void:
	_add_tween("scale", hover_scale, hover_time)
	
func _on_hover_end() -> void:
	_add_tween("scale", default_scale, hover_time)

func _add_tween(property: String, value, seconds: float) -> void:
	var tween = target.create_tween() #using the target allows you to not have to set a system to free the node because it will free itself when the program ends.
	tween.tween_property(target, property, value, seconds).set_trans(tranistion_type)
	
