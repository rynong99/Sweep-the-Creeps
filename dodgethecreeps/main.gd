extends Node2D

@export var mob_scene: PackedScene
@export var coin_scene: PackedScene
var level = 1
var score
var coinScore = 0
var prevCount = 100
var prevCoin = 0
var touch
var mobCount
var coinCount = 0
var screen_size = get_viewport_rect().size

func _ready():
	$Player.hide()

func game_over(win):
	$Player.hide()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$CoinTimer.stop()
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
	$CoinTimer.start()
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
	coinCount = get_tree().get_node_count_in_group("coin")
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
	prevCoin = coinCount

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
		mob.position.x = 960
	elif (mob.position.y < 0) or (mob.position.y > (1080)):
		mob.position.y = 540
	add_child(mob)
func coinSpawn():
	# Create a new instance of the Mob scene.
	var coin = coin_scene.instantiate()
	coin.position = Vector2(randi_range(0,1920),randi_range(0,1080))
	add_child(coin)

func _on_hud_start_game() -> void:
	new_game()
func _on_coin_timer_timeout() -> void:
	coinSpawn()
func _on_power_up_timer_timeout() -> void:
	print("Powering Down")
	$PowerUpTimer.stop()
	$Player/PointLight2D.scale /= 2
	$Player/CollisionShape2D.scale /= 2

func powerUp():
	pass


func _on_coin_collect() -> void:
	powerUp()
	pass # Replace with function body.


func _on_player_power_up() -> void:
	print("Powering Up")
	$PowerUpTimer.start()
	$Player/PointLight2D.scale *= 2
	$Player/CollisionShape2D.scale *= 2
	pass # Replace with function body.
