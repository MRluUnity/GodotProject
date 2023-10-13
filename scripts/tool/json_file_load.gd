extends Node

# 用于存储配置的字典,出问题了，先废弃
var config = {}

func _ready():
	var resource_importer = ResourceImporter.new.call()
	if resource_importer.load("res://profile/word_ability_profile.json"):
		var content = resource_importer.get_as_text()
		resource_importer.close()

		var json = JSON.new().parse(content)
		config = json["result"]
		print(config)
	else:
		print("无法打开文件.")

func get_config():
	return config
