extends KinematicBody2D

const UTILS = preload("res://scripts/utils.gd")
const SPEED = 120#180
const GRAVITY = 25
const JUMPFORCE = -500
const SPEED_SLIDE = 70
const ENEMY_AREA = 'EnemyArea'
const CLOSE_ATTACKS = ['close_attack','close_attack2']
const ENEMY_SPRITE = 'Sprite'
const CLOSE_ATTACK_POLIGON = ENEMY_SPRITE+'/CloseAttackArea/Strike1'

export var MAX_NUMBER_HIT = 10 # The maximum permissible number of blows, after which death occurs 
export var min_attack_distance = 25 # The minimum distance to the player when you can make an attack 
export var max_attack_distance = 30 # The maximum distance to the player when you can make an attack 
export var limit_position = 100 # How far can you move before turning 

var utils = UTILS.new()
var max_attack_speed = 1.6
var velocity = Vector2(0,0) 
var dead_trigger = false
var dead_status = false # Required to complete the animation 
#var hit_trigger = false
var hit_status = false # Required to complete the animation  and do not count the blows while it is in a hit state 
var hit_counter = 0
var close_attack_finished = false
var initial_pos

onready var health_bar = $HealthBar
onready var bloods = $Bloods

# OFFSET SETTINGS
const BLOOD_OFSET = [{'x':25, 'y':0}, {'x':-25, 'y':0}] # id direction=0, then the zero element of the array 




func _ready():
	initial_pos = self.get_global_position()

	#blood('hide')




func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.y +=  GRAVITY
	velocity.x = lerp(velocity.x, 0, 0.3) 
	
	utils.direction_child_from_parrent(
		get_node(ENEMY_SPRITE).is_flipped_h(), 
		get_node(CLOSE_ATTACK_POLIGON)
		)
		
func show_blood():
	bloods.blood('show', 'green_blood', not get_node(ENEMY_SPRITE).is_flipped_h(), BLOOD_OFSET)

func hit():
	hit_counter +=1
	if hit_counter<MAX_NUMBER_HIT:
		#hit_trigger = true
		hit_status = true 
	else:
		dead()
		

func dead(object_collision=null):
	"""
	object_collision - the weapon that killed 
	"""
	dead_trigger = true
	dead_status = true
	get_node(ENEMY_AREA).set_collision_layer_bit(1, false)
	set_collision_layer_bit(1, false)
	# If death came from a distant weapon, we destroy the weapon 
	if object_collision:
		object_collision.queue_free()



func _on_Area2D_body_entered(weapon):
	if weapon.is_in_group("Weapons"):
		dead(weapon)


func _on_EnemyArea_area_entered(weapon):
	if weapon.is_in_group("CloseWeapons") and not hit_status:
		hit()


func _on_Sprite_animation_finished():
	var current_animation = $Sprite.get_animation()
	#get_node(CLOSE_ATTACK_POLIGON).set_disabled(true)
	if current_animation in CLOSE_ATTACKS:
		close_attack_finished = true 
	if current_animation == 'dead':
		if dead_status:
			dead_status=false
			queue_free()
	if current_animation == 'hit':
		if hit_status:
			hit_status=false
