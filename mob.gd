extends RigidBody2D
class_name Mob
func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()
func _physics_process(delta: float) -> void:
	move_and_collide(linear_velocity*delta)
	linear_damp = 2
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
