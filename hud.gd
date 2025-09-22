extends CanvasLayer

signal start_game

func _ready() -> void:
	$RemainingCount.hide()
	$RemainingText.hide()
	
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over(win):
	if win == true:
		show_message("Level up!")
		# Wait until the MessageTimer has counted down.
	else:	
		show_message("Game Over!")
	await $MessageTimer.timeout
	$RemainingCount.hide()
	$RemainingText.hide()
	$Message.text = "Sweep the Creeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)

func update_count(count):
	$RemainingCount.text = str(count)

func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	$RemainingCount.show()
	$RemainingText.show()

func _on_message_timer_timeout():
	$Message.hide()
