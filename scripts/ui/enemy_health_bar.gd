extends Control

var health_bar

func _ready():
	hide()
	health_bar = $ProgressBar
	health_bar.value = health_bar.max_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_enemy_health_bar_switch(_current_health):
	health_bar.value = _current_health


func _on_enemy_dead():
	hide()


func _on_enemy_player_dialog():
	show()

