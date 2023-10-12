extends Node2D

@export var health : float = 100
var current_health : float = 0
signal dead

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
