extends Area2D

var normal_zoom = 0.7
var max_zoom = 1 
var speed_zoom =0.003
var zoom_x
var zoom_y
func _ready():
	pass # Replace with function body.




func _on_ZoomNormalChekpoint_body_entered(body):
	if body.is_in_group('Player'):
		zoom_x = body.get_node('Camera2D').get_zoom()[0]
		zoom_y = body.get_node('Camera2D').get_zoom()[1]
		while zoom_x<=max_zoom:
			zoom_x += speed_zoom 
			zoom_y += speed_zoom
			body.get_node('Camera2D').set_zoom(Vector2(zoom_x,zoom_y))
			yield(get_tree().create_timer(0.01), "timeout")



func _on_ZoomNormalChekpoint_body_exited(body):
	if body.is_in_group('Player'):
		zoom_x = body.get_node('Camera2D').get_zoom()[0]
		zoom_y = body.get_node('Camera2D').get_zoom()[1]
		while zoom_x>=normal_zoom:
			zoom_x -= speed_zoom 
			zoom_y -= speed_zoom
			body.get_node('Camera2D').set_zoom(Vector2(zoom_x,zoom_y))
			yield(get_tree().create_timer(0.01), "timeout")
