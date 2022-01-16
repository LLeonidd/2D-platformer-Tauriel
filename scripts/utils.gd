extends Node

func _get_val_settings(setting_val, default_val):
	if setting_val != null:
		return setting_val
	else:
		return default_val
		

func direction_child_from_parrent(parent_direction, child_node, settings=null):
	"""
	Change the direction of the child node depending on the direction of the parent node
	Args:
		parent_direction: if the direction is from left to right then false, 
		otherwise true. You can use the function .is_flipped_h
		child_node: node for which you want to change direction
		
	example settings:
	ATTACK_POLIGON_SETTINGS = {
			'direction_right':{
				'x':4.238,
				'y':'current',
			},
			'direction_left':{
				'x':0,
				'y':'current',
			},
		}
	"""
	
	var current_scale = child_node.get_scale()
	var current_position = child_node.get_position()
	
	child_node.set_scale(Vector2((2*int(not parent_direction)-1)*abs(current_scale[0]),current_scale[1]))
		
	if settings == null:
		child_node.set_position(Vector2((2*int(parent_direction)-1)*abs(current_position[0]),current_position[1]))
	else:
		child_node.set_position(Vector2(
			_get_val_settings(settings[int(parent_direction)].x, current_position[0]),
			_get_val_settings(settings[int(parent_direction)].y, current_position[1])
			)
		)
		
func get_chield_by_name(root_element, prefix):
	"""
	Get a random child from the parent. 
	Perfix is required to filter children by name 
	"""
	var children_array=[]
	for chield in root_element.get_children():
			if prefix in chield.get_name():
				children_array.append(chield)
	return children_array


func get_random_array_element(_array):
	randomize()
	return _array[randi() % _array.size()]


