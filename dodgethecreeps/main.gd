extends Node2D

@export var mob_scene: PackedScene
var level = 1
var score
var prevCount = 100
var touch
var mobCount
var screen_size = get_viewport_rect().size

func _ready():
	$Player.hide()

func game_over(win):
	$Player.hide()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over(win)
	$Music.stop()
	if win==true:
		$GameWin.play()
	else:
		$DeathSound.play()

func new_game():
	score = 60
	$Player.start($StartPosition.position)
	if $Player.speed > 800:
		$Player.speed = 400+(100*(level-1))
	$StartTimer.start()
	$HUD.update_score(score)
	if level == 1:
		$Player/PointLight2D.scale = Vector2(level,level)
		$Player/CollisionShape2D.scale = Vector2(level,level)
		$HUD.show_message("Start Sweeping")
	else:
		$HUD.show_message("Level "+str(level))
		if $Player/PointLight2D.scale < Vector2(4,4):
			$Player/PointLight2D.scale = Vector2(level/2,level/2)
		if $Player/CollisionShape2D.scale < Vector2(5,5):
			$Player/CollisionShape2D.scale = Vector2(level/2,level/2)
		print($Player/CollisionShape2D.scale)
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("goal", "queue_free")
	$Music.play()
	var spawnGoal = randi_range(0,100)
	for i in range(100*level):
		mobSpawn()
		i+=1

func _on_score_timer_timeout():
	score -= level/2
	mobCount = get_tree().get_node_count_in_group("mobs")
	print(mobCount)
	if mobCount < prevCount:
		score += (prevCount - mobCount)/2
	if mobCount <= 0:
		game_over(true)
		level += 1
	elif score <= 0:
		game_over(false)
		level = 1
	$HUD.update_score(score)
	$HUD.update_count(mobCount)
	prevCount = mobCount

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
func mobSpawn():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	
	if (mob.position.x < 0) or (mob.position.x > (1920)):
		print('Mob spawned out of bounds (X)')
		print(mob.position)
		return
	elif (mob.position.y < 0) or (mob.position.y > (1080)):
		print('Mob spawned out of bounds (Y)')
		print(mob.position)
		return
	else:
		add_child(mob)

func _on_hud_start_game() -> void:
	new_game()
	
