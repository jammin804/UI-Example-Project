extends Label

var default_scale : Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_center()
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale",  Vector2(1.25,1.25),2)
	tween.tween_property(self, "scale",  Vector2(1,1), 2)
	tween.set_loops()
	

func _center() -> void:
	self.pivot_offset = self.size / 2 #gives us the middle point of the button
	#default_scale = self.scale
