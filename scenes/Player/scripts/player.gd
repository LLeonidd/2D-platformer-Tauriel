extends KinematicBody2D

signal hit
const UTILS = preload("res://scripts/utils.gd")
const SPEED = 150#180
const GRAVITY = 25
const JUMPFORCE = -500
const SPEED_SLIDE = 70
const CLOSE_ATTACK_POLIGON = 'Sprite/CloseAttackArea/Strike1'
const PLAYER_SPRITE = 'Sprite'

# OFFSET SETTINGS
const ATTACK_POLIGON_SETTINGS = [{'x': 4.238, 'y': null}, {'x': 0, 'y': null}]


var utils = UTILS.new()
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
var max_number_hit = 10000
var hit_counter = 0
var hit_status = false
var blood_offset = [{'x': 51, 'y': 0}, {'x': 0, 'y': 0}]
#var hit_trigger =false

onready var bloods = $Bloods


func show_blood():
	bloods.blood_offset = blood_offset
	bloods.show_blood('red_blood', not get_node(PLAYER_SPRITE).is_flipped_h())


func _ready():
	camera_normal_zoom_x = self.get_node("Camera2D").get_zoom()[0]
	camera_normal_zoom_y = self.get_node("Camera2D").get_zoom()[1]
	camera_normal_offset_x = self.get_node("Camera2D").get_offset()[0]
	camera_normal_offset_y = self.get_node("Camera2D").get_offset()[1]


func _physics_process(delta):
	velocity = move_and_slide_with_snap(velocity,Vector2.ZERO, Vector2.UP) # Vector2.UP - направелние снизу вверх. Внизу пол.
	velocity.y +=  GRAVITY
	
	utils.direction_child_from_parrent(
		get_node(PLAYER_SPRITE).is_flipped_h(), 
		get_node(CLOSE_ATTACK_POLIGON), 
		ATTACK_POLIGON_SETTINGS
		)
	
	# Allows you to stop instead of sliding constantly
	# lerp interpolation
	# Interpolates the numbers x to 0, in 30% increments 
	velocity.x = lerp(velocity.x, 0, 0.3)



func dead(from_object):
	dead_status = true
	object_collision = from_object
	

func hit(area):
	hit_counter+=1
	if hit_counter<max_number_hit:
		hit_status = true
		#hit_trigger = true
	else:
		dead(area)
	

func camera_normalize():
	self.get_node('Camera2D').set_offset(Vector2(camera_normal_offset_x, camera_normal_offset_y))
	self.get_node('Camera2D').set_zoom(Vector2(camera_normal_zoom_x, camera_normal_zoom_y))


func _on_PlayerArea_area_entered(area):
	if area.is_in_group("EnemyCloseAttack") and not hit_status and not dead_status:
		hit(area)
	

func _on_Sprite_animation_finished():
	var current_animation = $Sprite.get_animation()
	if current_animation == 'hit':
		if hit_status:
			hit_status=false
