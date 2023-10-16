extends Control

# 这里面的代码太过杂乱，之后要对它进行重写
# 也在思考，是否需要制作一个单词能力编辑器，避免修改数值得到json文件中修改，实现一个自动修改的功能，可以的话做一下UI

var text_json
var input_text = ""

signal hit(damage : float)
signal line_eidt_is_show(is_show : bool)
signal heal(damage : float)

func _ready():
	# 这里是获取读取json文件的脚本
	text_json = get_node("/root/StateDataLoader")
	
	# 隐藏掉输入框，以及发送对话框展示状态的信号出去
	hide()
	line_eidt_is_show.emit(false)

func _process(delta):
	# 这里是获取到玩家再输入框中输入的内容
	input_text = get_node("LineEdit").get_text()

	# 判断：玩家按下接受键开始检测单词的拼写，按下退出则关闭输入界面且清空输入框内容，以及重置input_text
	# 嵌套的判断：对比玩家是否输入正确，根据输入情况来发动技能，这里之后要重写
	if Input.is_action_just_pressed("action_accept"):
		if input_text == text_json.word_ability_data.attack_text["name"]:
			get_node("LineEdit").clear()
			hit.emit(text_json.word_ability_data.attack_text["damage"])
		elif input_text == text_json.word_ability_data.heal_text["name"]:
			get_node("LineEdit").clear()
			heal.emit(text_json.word_ability_data.heal_text["heal"])
		else:
			get_node("LineEdit").clear()
	elif Input.is_action_just_pressed("action_exit"):
		# 隐藏掉输入框，以及发送对话框展示状态的信号出去
		hide()
		line_eidt_is_show.emit(false)

# 连接怪物死亡的信号
func _on_enemy_dead():
	hide()
	line_eidt_is_show.emit(false)

# 连接怪物那里发送的关于玩家对话框需要展示的信号，这里写的很不合理，之后修改
func _on_enemy_player_dialog() -> void:
	show()
	line_eidt_is_show.emit(true)
