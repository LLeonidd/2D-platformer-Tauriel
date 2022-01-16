tool
extends RigidBody2D


func _get_configuration_warning():
	var message=""
	if get_groups().size() <= 1:
		message = """It must be added to the group by which the object will be identified as a weapon.
		Example: Weapons.
		"""
	return message


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#yield(get_tree().create_timer(2.0), "timeout")
	#queue_free()

