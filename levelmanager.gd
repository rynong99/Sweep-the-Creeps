extends Node
var level_1 = preload("res://Levels/Level1.tscn")
var level_2 = preload("res://Levels/Level2.tscn")
var level_3 = preload("res://Levels/Level3.tscn")
var level_4 = preload("res://Levels/Level4.tscn")
var level_5 = preload("res://Levels/Level5.tscn")
var level_list = [level_1,level_2,level_3,level_4,level_5]
var level = 1
func get_level():
	return(level)
func update_level(new_level):
	level = new_level
	print(level)
func reset_level():
	queue_free()
	#find_child(str(level)).enabled = true
