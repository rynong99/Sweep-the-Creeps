extends RigidBody2D
func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()
	
func _process(delta):
	if (position.x < 0) or (position.x > (1920)):
		queue_free()
	elif (position.y < 0) or (position.y > (1080)):
		queue_free()
	if linear_velocity > Vector2(100,0) or linear_velocity > Vector2(0,100):
		linear_damp = 2
		self.set_collision_mask_value(2,false)
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
