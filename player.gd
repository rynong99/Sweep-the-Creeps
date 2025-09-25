extends CharacterBody2D
class_name player
signal hit
signal powerUp
@export var poweredUp = false
@export var speed = 400
var screen_size
func ready():
	screen_size = get_viewport_rect().size
	hide()
#func _physics_process(delta: float) -> void:
	#move_and_slide()
	
func _physics_process(delta: float) -> void:
	#var velocity = Vector2.ZERO # The player's movement vector.
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	'''if Input.is_action_pressed("move_right"):
		velocity.x += speed
	elif Input.is_action_pressed("move_left"):
		velocity.x -= speed
	else:
		velocity.x = 0
	if Input.is_action_pressed("move_down"):
		velocity.y += speed
	elif Input.is_action_pressed("move_up"):
		velocity.y -= speed		
	else:
		velocity.y = 0 '''
	velocity = direction * 80
	max_slides = 0
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
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "up"
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "down"
		
	#position += velocity * delta
	#position = position.clamp(Vector2.ZERO, get_viewport_rect().size)
	var collision = move_and_collide(velocity * delta)
	if collision and collision.get_collider() is Mob:
		var collider = collision.get_collider()
		#$CollisionShape2D.disabled = true
		print("Hit Mob")
		var push_dir = collision.get_normal()*-1
		collider.apply_central_impulse(push_dir*200)
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
func _on_player_hit() -> void:
	pass # Replace with function body.

func triggerPowerUp():
	powerUp.emit()

func _on_coin_collector_coin_collected() -> void:
	powerUp.emit()
