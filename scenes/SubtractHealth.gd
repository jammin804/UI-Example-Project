extends Button

func _on_subtract_health_pressed() -> void:
	pass


func _on_pressed():
	Broadcast.send("on_subtract_health_pressed") # Replace with function body.
