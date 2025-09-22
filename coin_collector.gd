extends Area2D
signal coin_collected
func collect_coin():
	coin_collected.emit()

func _on_area_entered(area: Area2D) -> void:
	if area is Coin:
		print("Got a coin!")
		coin_collected.emit()
		AudioManager.playScore()
		area.queue_free()
