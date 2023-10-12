extends CharacterBody2D

@export var spped : float = 300
var player_animation
var player_sprite
var can_move : bool = true

func _ready() -> void:
	# 我用它来进行初始化
	player_animation = $AnimationPlayer
	player_sprite = $Sprite2D
	animation_switch("idle")

func _physics_process(delta) -> void:
	if can_move:
		var movement_vector_normalized: Vector2 = get_movement_vector_normalized()
	
		velocity = movement_vector_normalized * spped
		
		if velocity != Vector2.ZERO:
			set_scale_inverse()
			animation_switch("run")
			move_and_slide()
		else:
			animation_switch("idle")

func get_movement_vector_normalized() -> Vector2:
	var x_movement : float = Input.get_action_strength("action_right") - Input.get_action_strength("action_left")
	var y_movement : float = Input.get_action_strength("action_down") - Input.get_action_strength("action_up")
	
	return Vector2(x_movement, y_movement).normalized()

func animation_switch(animation : String) -> void:
	player_animation.play(animation)

func set_scale_inverse() -> void:
	# 角色方向取反,测试了一下，修改scale的值会出现鬼畜的错误，原因未知
	# 最后只能注入Sprite2D然后修改Sprite2D中的flip_h
	
	if get_movement_vector_normalized().x > 0:
		# scale.x = 1
		player_sprite.flip_h = false
	elif get_movement_vector_normalized().x < 0:
		# scale.x = -1
		player_sprite.flip_h = true


func _on_control_line_eidt_is_show(is_show) -> void:
	can_move = !is_show
