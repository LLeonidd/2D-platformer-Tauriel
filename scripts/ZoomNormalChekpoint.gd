extends Area2D

export var normal_zoom = 0.7
export var max_zoom = 1 
export var speed_zoom =0.003
export var speed_offset = 4
export var on_enter = true
export var on_exit = false

export var max_offset_x = 400
var zoom_x
var zoom_y
var offset_x
var offset_y
export var normal_offset_x =0
export var normal_offset_y = -140
var i
var smooth


func _ready():
	pass # Replace with function body.


func _on_ZoomNormalChekpoint_body_entered(body):
	
	if body.is_in_group('Player'):
		zoom_x = body.get_node('Camera2D').get_zoom()[0]
		zoom_y = body.get_node('Camera2D').get_zoom()[1]
		offset_x = body.get_node('Camera2D').get_offset()[0]
		offset_y = body.get_node('Camera2D').get_offset()[1]
		i=0
		while zoom_x<=max_zoom or offset_x<=max_offset_x:
			i+=1
			smooth = min(1, i*0.01)
			if zoom_x<=max_zoom:
				zoom_x += speed_zoom*smooth 
				zoom_y += speed_zoom*smooth
				body.get_node('Camera2D').set_zoom(Vector2(zoom_x,zoom_y))
			if offset_x<=max_offset_x:
				offset_x += speed_offset*smooth 
				body.get_node('Camera2D').set_offset(Vector2(offset_x,offset_y))
			yield(get_tree().create_timer(0.01), "timeout")



func _on_ZoomNormalChekpoint_body_exited(body):
	if on_exit:
		if body.is_in_group('Player'):
			zoom_x = body.get_node('Camera2D').get_zoom()[0]
			zoom_y = body.get_node('Camera2D').get_zoom()[1]
			i=0
			while zoom_x>=normal_zoom or offset_x>=normal_offset_x:
				i+=1
				smooth = min(1, i*0.01)
				if zoom_x>=normal_zoom:
					zoom_x -= speed_zoom*smooth  
					zoom_y -= speed_zoom*smooth 
					body.get_node('Camera2D').set_zoom(Vector2(zoom_x,zoom_y))
				if offset_x>=normal_offset_x:
					offset_x -= speed_offset*smooth
					body.get_node('Camera2D').set_offset(Vector2(offset_x,offset_y))
				yield(get_tree().create_timer(0.01), "timeout")
