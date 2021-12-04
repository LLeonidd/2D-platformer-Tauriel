extends KinematicBody2D

const SPEED = 150#180
const GRAVITY = 25
const JUMPFORCE = -500
const SPEED_SLIDE = 70

var velocity = Vector2(0,0) # Скорость игрока по координатам x, y
var double_jump 

var ui_left = 'ui_left'
var ui_right = 'ui_right'
var ui_up = 'ui_up'
var ui_close_attack = 'ui_close_attack'
var ui_ranged_attack = 'ui_ranged_attack'
var dead_status = false
var object_collision
var camera_normal_offset_x = 0
var camera_normal_offset_y = -140
var camera_normal_zoom_x
var camera_normal_zoom_y

func _ready():
	camera_normal_zoom_x = self.get_node("Camera2D").get_zoom()[0]
	camera_normal_zoom_y = self.get_node("Camera2D").get_zoom()[1]
	camera_normal_offset_x = self.get_node("Camera2D").get_offset()[0]
	camera_normal_offset_y = self.get_node("Camera2D").get_offset()[1]


func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP) # Vector2.UP - направелние снизу вверх. Внизу пол.
	velocity.y +=  GRAVITY
	
	# Allows you to stop instead of sliding constantly
	# lerp interpolation
	# Interpolates the numbers x to 0, in 30% increments 
	velocity.x = lerp(velocity.x, 0, 0.3) 


func dead(from_object):
	dead_status = true
	object_collision = from_object
	

func camera_normalize():
	print('OFSET ', camera_normal_offset_x,'    ', camera_normal_offset_y)
	print('ZOOM ', camera_normal_zoom_x,'    ', camera_normal_zoom_y)
	self.get_node('Camera2D').set_offset(Vector2(camera_normal_offset_x, camera_normal_offset_y))
	self.get_node('Camera2D').set_zoom(Vector2(camera_normal_zoom_x, camera_normal_zoom_y))

