extends Area2D

@export var health : float = 100
var current_health : float = 0
var is_attack : bool = false
var is_hit : bool = false
var is_dead : bool = false
var animation
signal dead
signal player_dialog
signal enemy_health_bar_switch(_current_health : float)

func _ready():
	animation = $AnimationPlayer
	current_health = health
	enemy_health_bar_switch.emit(current_health)
	animation_switch("idle")

func _process(delta):
	if is_attack:
		animation_switch("attack")
	elif is_hit:
		animation_switch("hit")
	elif is_dead:
		animation_switch("dead")
	else:
		animation_switch("idle")

func _hit(damage : float):
	is_hit = true
	current_health -= damage
	enemy_health_bar_switch.emit(current_health)
	if  current_health <= 0:
		current_health = 0
		dead.emit()
		enemy_health_bar_switch.emit(current_health)
		is_dead = true

func animation_switch(_animation : String) -> void:
	animation.play(_animation)
	
func animation_exit(animation : String):
	print("enemy current animation is exit")
	match animation:
		"attack":
			is_attack = false
		"hit":
			is_hit = false
		"dead":
			hide()
			is_dead = false

func _on_body_entered(body):
	# 当物体进入触发器时触发此函数
	if body.is_in_group("player") && is_dead == false:
		player_dialog.emit()
		position.x = 800
	if body.is_in_group("attack"):
		print("接收Player攻击")

func _on_body_exited(body):
	# 当物体离开触发器时触发此函数
	if body.is_in_group("player"):
		pass

func _on_control_heal(heal) -> void:
	current_health += heal
	enemy_health_bar_switch.emit(current_health)
	if  current_health >= health:
		current_health = health
