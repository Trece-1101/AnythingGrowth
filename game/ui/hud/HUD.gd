extends CanvasLayer

export(String, FILE, "*.tscn") var main_menu = ""
export(String, FILE, "*.tscn") var level_selection_menu = ""
var level_text:String setget set_level_text
var time_left:int


func set_level_text(level_name: String) -> void:
	$LevelName.text = level_name

func set_time_to_finish(time:int) -> void:
	time_left = time
	update_time_label()


func _ready() -> void:
	$LoseLabel.visible = false


func _on_BtnRetry_pressed() -> void:
	GameMusic.play_button()
	get_tree().reload_current_scene()


func _on_BtnMenu_pressed() -> void:
	if main_menu != "":
		GameMusic.play_button()
		get_tree().change_scene(main_menu)


func _on_BtnSelection_pressed() -> void:
	if level_selection_menu != "":
		GameMusic.play_button()
		get_tree().change_scene(level_selection_menu)


func _on_Timer_timeout() -> void:
	update_time_label()


func update_time_label() -> void:
	time_left -= 1
	if time_left == 0:
		lose()
	else:
		$LabelTime.text = "{sec}  seconds left".format({"sec" : time_left})


func lose() -> void:
	$Timer.stop()
	$Timer.queue_free()
	$LabelTime.queue_free()
	$LoseLabel.visible = true
	Events.emit_signal("level_lose")
	yield(get_tree().create_timer(0.5),"timeout")
	get_tree().reload_current_scene()
