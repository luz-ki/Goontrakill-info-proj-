extends Control


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:  ## verandert die szene, nachdem der Timer abgelaufen ist
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
 
func _input(event: InputEvent) -> void: ##verandert die szene, wenn man enter druckt
	if event.is_action_pressed("enter"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
