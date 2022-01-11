extends KinematicBody2D

var velocity = Vector2(0,0)
const GRAVITY=50
const SPEED=200
const JUMPFORCE = 1000



func _process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		#$Sprite.flip_h=false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		#$Sprite.flip_h=true
	velocity.y += GRAVITY
	
	var snap = Vector2.DOWN * 16 if is_on_floor() else Vector2.ZERO
	print(snap)
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -JUMPFORCE

	
	# Сбрасываем вектор при столкновении, передаем вектор для перемещения 
	
	#velocity = move_and_slide(velocity, Vector2.UP) # Vector2.UP - направелние снизу вверх. Внизу пол.
	
	#ПОзволяет останавливаться, а не скользить постоянно
	# lerp интерполяция 
	# Интерполирует числи x до 0, с шагом 20%
	velocity.x = lerp(velocity.x, 0, 0.2) 
	velocity = move_and_slide_with_snap(velocity, snap, Vector2.UP)
	
