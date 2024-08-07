class_name AnimationComponent extends Node

@export var from_center : bool = true
@export var hover_scale : Vector2 = Vector2(1,1)
@export var time : float = 0.1
@export var transition_type : Tween.TransitionType

var target : Control
var default_scale : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_parent()
	
	connect_signals()
	call_deferred("setup")
	
	
func connect_signals() -> void:
	target.mouse_entered.connect(on_hover)
	target.mouse_exited.connect(off_hover)

func setup() -> void:
	if from_center:
		target.pivot_offset = target.size / 2
	default_scale = target.scale

func on_hover() -> void:
	add_tween("scale", hover_scale, time)
	pass
	
func off_hover() -> void:
	add_tween("scale", default_scale, time)
	pass
	
func add_tween(property: String, value, seconds: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(target, property, value, seconds).set_trans(transition_type)
