extends Node
# 这个脚本是关于json文件读取的

# 创建一个字典用来储存json文件中的数据
var item_data = {}

# 读取的json文件路径
var data_file_path = "res://profile/word_ability_profile.json"

func _ready() -> void:
	# 再初始化中调用加载的方法来加载json文件
	item_data = load_json_file(data_file_path)

# 加载json文件
func load_json_file(file_path : String):
	# 使用file_exists来判断json文件的资源是否存在，若存在则让创建一个新的FileAccess对象data_file来存储
	# 使用JSON类中的parse_string来读取这个FileAccess对象中的文本
	# 如果这个paresd_result是字典类型就返回这个字典
	if FileAccess.file_exists(file_path):
		var data_file = FileAccess.open(file_path, FileAccess.READ)
		var parsed_result = JSON.parse_string(data_file.get_as_text())
		
		if parsed_result is Dictionary:
			return parsed_result
		else:
			print("读取出错")
	else:
		print("文件无法读取")
