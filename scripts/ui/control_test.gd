extends Control

@export var damage : float = 10
@export var heal_damage : float = 10
var text_json
var input_text = ""
var xp : float = 0
signal hit(damage : float)
signal line_eidt_is_show(is_show : bool)
signal heal(damage : float)

func _ready():
	text_json = get_node("/root/StateDataLoader")
	hide()
	line_eidt_is_show.emit(false)

func _process(delta):
	input_text = get_node("LineEdit").get_text()

	if Input.is_action_just_pressed("action_accept"):
		if input_text == text_json.item_data.attack_text["name"]:
			print("The text matches!")  
			get_node("LineEdit").clear()
			hit.emit(text_json.item_data.attack_text["damage"])
		elif input_text == text_json.item_data.heal_text["name"]:
			get_node("LineEdit").clear()
			heal.emit(text_json.item_data.heal_text["heal"])
		else:
			print("The text doesn't match!")  
			get_node("LineEdit").clear()
	elif Input.is_action_just_pressed("action_exit"):
		hide()
		line_eidt_is_show.emit(false)

func _on_enemy_dead():
	xp += 1
	print("Player xp is add 1")
	hide()
	line_eidt_is_show.emit(false)


func _on_enemy_player_dialog() -> void:
	show()
	line_eidt_is_show.emit(true)
