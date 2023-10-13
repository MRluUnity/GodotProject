extends Control

@export var damage : float = 10
@export var heal_damage : float = 10
var attack_text = {"name" = "attack", "damage" = damage, "heal" = 0, "mana" = 5, "slow_time" = 0}
var heal_text = {"name" = "heal", "damage" = 0, "heal" = heal_damage, "mana" = 5, "slow_time" = 0}
var input_text = ""
var xp : float = 0
signal hit(damage : float)
signal line_eidt_is_show(is_show : bool)
signal heal(damage : float)

func _ready():
	hide()
	line_eidt_is_show.emit(false)

func _process(delta):
	input_text = get_node("LineEdit").get_text()

	if Input.is_action_just_pressed("action_accept"):
		if input_text == attack_text["name"]:
			print("The text matches!")  
			get_node("LineEdit").clear()
			hit.emit(attack_text["damage"])
		elif input_text == heal_text["name"]:
			get_node("LineEdit").clear()
			heal.emit(heal_text["heal"])
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
