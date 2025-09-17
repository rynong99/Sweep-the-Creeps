extends Area2D
signal collect
func _ready():
	$AnimatedSprite2D.play()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.triggerPowerUp()
		queue_free()
