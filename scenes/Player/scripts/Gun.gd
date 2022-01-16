tool
extends Position2D


const BULLET_VELOCITY = 800.0
export var Bullet:PackedScene


func _get_configuration_warning():
	var message=""
	if not Bullet:
		message = "The distant weapon scene must be loaded, RegidBody."
	return message


func direction_to_bool(direction):
	if direction == 1:
		return false
	return true

func shoot(direction = 1):
	var bullet = Bullet.instance()
	bullet.global_position = global_position
	bullet.linear_velocity = Vector2(direction*BULLET_VELOCITY,0)
	bullet.get_node("BulletSprite").flip_h = direction_to_bool(direction)
	bullet.set_as_toplevel(true)
	add_child(bullet)
	return true
