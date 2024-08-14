extends Button

func _on_pressed():
	Broadcast.send("on_back_pressed")
