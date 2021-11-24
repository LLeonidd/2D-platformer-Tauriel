extends KinematicBody2D

const SPEED = 120#180
const GRAVITY = 25
const JUMPFORCE = -500
const SPEED_SLIDE = 70

export var min_attack_distance = 20
export var max_attack_distance = 30
export var limit_position = 100


var max_attack_speed = 1.6
var velocity = Vector2(0,0) 
var dead_status = false
var object_collision
var initial_pos


func _ready():
	initial_pos = self.get_global_position()


func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.y +=  GRAVITY
	velocity.x = lerp(velocity.x, 0, 0.3) 



func dead(from_object):
	dead_status = true
	object_collision = from_object
