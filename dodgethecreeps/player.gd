extends CharacterBody2D
class_name player
signal hit
signal powerUp
@export var speed = 400
var screen_size
func ready():
	screen_size = get_viewport_rect().size
	hide()
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$CollisionShape2D.rotation_degrees = 90
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$CollisionShape2D.rotation_degrees = 270
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		$CollisionShape2D.rotation_degrees = 180
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		$CollisionShape2D.rotation_degrees = 0

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		if velocity.y > 0:
				$AnimatedSprite2D.animation = "down"
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, get_viewport_rect().size)


func _on_body_entered(body: Node2D) -> void:
	#hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_player_hit() -> void:
	pass # Replace with function body.

func triggerPowerUp():
	powerUp.emit()
