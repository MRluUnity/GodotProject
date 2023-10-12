extends Area2D

@export var health : float = 100
var current_health : float = 0
signal dead
signal player_dialog

func _ready():
	current_health = health

func _process(delta):
	pass

func _hit(damage : float):
	if  current_health <= 0:
		current_health = 0
		dead.emit()
	else:
		current_health -= damage
		print("Enemy health is add -10")

func heal(heal : float):
	if  current_health >= health:
		current_health = health
	else:
		current_health += heal

func _on_body_entered(body):
	# 当物体进入触发器时触发此函数
	if body.is_in_group("player"):
		player_dialog.emit()
		print("Player进入了触发器,发送信号")

func _on_body_exited(body):
	# 当物体离开触发器时触发此函数
	if body.is_in_group("player"):
		print("Player离开了触发器")
