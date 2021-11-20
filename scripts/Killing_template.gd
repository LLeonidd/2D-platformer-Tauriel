extends StaticBody2D


export var speed=3
export var limit_top =300 
export var limit_bottom=0
var cur_position_x
var cur_position_y
var direction=1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cur_position_x = self.find_node('WeaponCollisionBodyShape').get_position()[0]
	cur_position_y = self.find_node('WeaponCollisionBodyShape').get_position()[1]
	
	if cur_position_y>limit_top:
		direction = -1
	elif cur_position_y<=limit_bottom:
		direction=1
	self.find_node('WeaponCollisionBodyShape').set_position(Vector2(cur_position_x, cur_position_y+direction*speed))
	

	


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.dead(self)



