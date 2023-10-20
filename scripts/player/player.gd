extends CharacterBody2D
# 在思考，玩家正常操作是否要使用简易的有限状态机or完整的有限状态机
# 思考，玩家的动画是否需要独立成一个脚本来管理（目前感觉不太需要）

@export var spped : float = 300
var animation
var player_sprite
var can_move : bool = true
var is_attack : bool = false

func _ready() -> void:
	# 我用它来进行初始化
	animation = $AnimationPlayer
	player_sprite = $Sprite2D
	animation_switch("idle")

func _physics_process(delta) -> void:
	if can_move:
		# 可能是在进入战斗状态前保存了移动的向量，导致玩家击败怪物后会移动一段距离
		# 解决方法是在允许移动时将移动向量清零
		var movement_vector_normalized: Vector2 = Vector2.ZERO
		movement_vector_normalized = get_movement_vector_normalized()
	
		velocity = movement_vector_normalized * spped
		
		if velocity != Vector2.ZERO && !is_attack:
			set_scale_inverse()
			animation_switch("run")
			move_and_slide()
		elif is_attack:
			animation_switch("attack")
		else:
			animation_switch("idle")
	else:
		# 这里的坐标修改只是测试的时候临时调整的，游戏过程中不会如此，到时候使用更高明的方式进行战斗状态的编写
		position.x = 0
		if is_attack:
			animation_switch("attack")
		else:
			animation_switch("idle")

func get_movement_vector_normalized() -> Vector2:
	var x_movement : float = Input.get_action_strength("action_right") - Input.get_action_strength("action_left")
	var y_movement : float = Input.get_action_strength("action_down") - Input.get_action_strength("action_up")
	
	return Vector2(x_movement, y_movement).normalized()

func animation_switch(_animation : String) -> void:
	animation.play(_animation)
	
func attack_animation_exit():
	print("attack is exit")
	is_attack = false

func set_scale_inverse() -> void:
	if get_movement_vector_normalized().x > 0:
		player_sprite.flip_h = false
	elif get_movement_vector_normalized().x < 0:
		player_sprite.flip_h = true

func _on_control_hit(damage):
	is_attack = true


func _on_edit_line_eidt_is_show(is_show) -> void:
	can_move = !is_show
