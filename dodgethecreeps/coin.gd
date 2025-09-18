extends Area2D
class_name Coin
signal collect
func _ready():
	$AnimatedSprite2D.play()

func _on_body_entered(body: Node2D) -> void:
	#if body.has_method("collect_coin"):
		#AudioManager.playCoin()
		#body.collect_coin()
		#queue_free()
	pass
