extends RigidBody2D
class_name Mob
func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(linear_velocity * delta)
	if collision and collision.get_collider() is Mob:
		var collider = collision.get_collider()
		#$CollisionShape2D.disabled = true
		#print("Hit Mob")
		var push_dir = collision.get_normal()*-1
		collider.apply_central_impulse(push_dir)
	if collision and collision.get_collider() is Fence:
		var collider = collision.get_collider()
		var push_dir = collision.get_normal()*-1
		apply_central_impulse(push_dir*100)
	linear_damp = 2.5
func _process(delta):
	if (position.x < 0) or (position.x > (1920)):
		print("Scored")
		AudioManager.playScore()
		queue_free()
	elif (position.y < 0) or (position.y > (1080)):
		print("Scored")
		AudioManager.playScore()
		queue_free()
	#self.set_collision_mask_value(2,false)
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
