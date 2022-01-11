extends KinematicBody2D


export var speed=100
export var limit_top =300 
export var limit_bottom=0
export var limit_left =100 
export var limit_right=100
export var vertical_direction = false

var cur_position_x
var cur_position_y
var direction=1
var init_position_x
var init_position_y

func _ready():
	init_position_x = self.find_node('WeaponCollisionBodyShape').get_global_position()[0]
	init_position_y = self.find_node('WeaponCollisionBodyShape').get_global_position()[1]




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cur_position_x = self.find_node('WeaponCollisionBodyShape').get_global_position()[0]
	cur_position_y = self.find_node('WeaponCollisionBodyShape').get_global_position()[1]
	
	if vertical_direction:
		if cur_position_y-init_position_y>=limit_bottom:
			direction = -1
		elif init_position_y-cur_position_y>=limit_top:
			direction=1
		move_and_slide(Vector2(0, direction*speed), Vector2.UP)
	else:
		if cur_position_x-init_position_x>=limit_right:
			direction = -1
		elif init_position_x-cur_position_x>=limit_left:
			direction=1
		move_and_slide(Vector2(direction*speed, 0), Vector2.UP)
	
	


func _on_Area2D_body_entered(body):
	#return
	if body.is_in_group("Player"):
		body.dead(self)



