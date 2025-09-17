extends Area2D
signal collect
func _ready():
	$AnimatedSprite2D.play()
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		collect.emit()
		#print("Coin collected")
		queue_free() # Replace with function body.
