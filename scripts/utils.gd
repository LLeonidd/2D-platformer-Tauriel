func _get_val_settings(setting_val, default_val):
	if String(setting_val) != 'current':
		return setting_val
	else:
		return default_val
		

func direction_child_from_parrent(parent_direction, child_node, settings):
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
	
	var left_x = _get_val_settings(settings.direction_left.x, current_position[0])
	var left_y = _get_val_settings(settings.direction_left.y, current_position[1])
	var right_x = _get_val_settings(settings.direction_right.x, current_position[0])
	var right_y = _get_val_settings(settings.direction_right.y, current_position[1])

	
	child_node.set_scale(Vector2((2*int(not parent_direction)-1)*abs(current_scale[0]),current_scale[1]))
	if parent_direction:
		child_node.set_position(Vector2(left_x,left_y))
	else:
		child_node.set_position(Vector2(right_x,right_y))
