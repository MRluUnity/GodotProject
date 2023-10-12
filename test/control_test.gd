extends Control

var preset_text = "attack"
@export var damage : float = 10
var input_text = ""
var xp : float = 0
signal hit(damage : float)

func _ready():
	pass

func _process(delta):
	input_text = get_node("LineEdit").get_text()

	# 比较 input_text 和 preset_text
	if Input.is_action_just_pressed("ui_accept"):
		if input_text == preset_text:
			print("The text matches!")  
			get_node("LineEdit").clear()
			hit.emit(damage)
		else:
			print("The text doesn't match!")  
			get_node("LineEdit").clear()


func _on_enemy_dead():
	xp += 1
	print("Player xp is add 1")
