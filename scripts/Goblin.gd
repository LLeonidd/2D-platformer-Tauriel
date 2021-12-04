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
var dead_trigger = false
var dead_status = false
var initial_pos

const ENEMY_AREA = 'EnemyArea'


func _ready():
	initial_pos = self.get_global_position()


func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.y +=  GRAVITY
	velocity.x = lerp(velocity.x, 0, 0.3) 


func dead(object_collision):
	dead_trigger = true
	dead_status = true
	#object_collision.set_collision_mask_bit(1, false)
	get_node(ENEMY_AREA).set_collision_layer_bit(1, false)
	set_collision_layer_bit(1, false)
	object_collision.queue_free()

	


func _on_Area2D_body_entered(body):
	if body.is_in_group("Weapons"): # ++ и то что враг еще не был убит ранее
		dead(body)


func _on_Sprite_animation_finished():
	if dead_status:
		dead_status=false
		queue_free()
		
