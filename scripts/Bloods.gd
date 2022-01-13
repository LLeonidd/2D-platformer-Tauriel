extends Node2D


func _ready():
	randomize()
	_hide_all_child(self)
	# Set signals on animation finished
	for child in get_children():
		child.connect("animation_finished" , self, "blood", ['hide'])


func _get_child_by_name(root_element, prefix=null):
	"""
	Get a random child from the parent. 
	Perfix is required to filter children by name 
	If prefix = null, then get all childs
	"""
	var children_array=[]
	for chield in root_element.get_children():
			if prefix == null:
				children_array.append(chield)
			elif prefix in chield.get_name():
				children_array.append(chield)
	return children_array


func _get_random_array_element(_array):
	return _array[randi() % _array.size()]


func _hide_all_child(parent):
	var child_array = _get_child_by_name(self)
	for child in child_array:
		child.visible = false
		child.stop()



func blood(action, prefix=null, direction=true, offset=null):
	"""
	Show or hide bloods
	Args:
		action: 'show' or 'hide'
		prefix: part of the name that is in the name of the sprite
		direction: sprite direction
		offset_example = [{'x':25, 'y':0}, {'x':-25, 'y':0}] # id direction=0, then the zero element of the array 
	"""
	var bloods_array = _get_child_by_name(self, prefix)
	var blood_node = _get_random_array_element(bloods_array)
	if offset != null:
		blood_node.set_offset(Vector2(offset[int(direction)].x,offset[int(direction)].y))


	
	#var blood_node = get_node('Sprite/blood1')
	if action == 'show':
		blood_node.set_flip_h(direction)
		blood_node.visible = true
		blood_node.set_frame(0)
		blood_node.play()
	else:
		for blood in bloods_array:
			blood.visible = false
			blood.stop()
