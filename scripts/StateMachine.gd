extends Node

class_name StateMachine

const DEBUG = false
const PATH_TO_PARENT = '../'
const PLAYER_OBJECT = 'Sprite' 
const SATATE_LABEL = 'current_state'
const RIGHT_WALL = 'RightWall'
const LEFT_WALL = 'LeftWall'
const MIN_VELOCITY_FOR_SLIDE = -500 # The speed at which sliding is available. For example, do not slide on low walls
const MAX_VELOCITY_DEADLY_FALLING = 1000 
const AUDIO = 'MusicEffects'
const CLOSE_ATTACK_AREA = 'CloseAttackArea'
const CLOSE_ATTACK_FRAMES = [2,3,8,9,15,16]
var state: Object
var history = []

#var offset_list = [15,0] # values for offset left (0-index) or right (1-index), for correct direction

onready var player_root = get_node(PATH_TO_PARENT)
onready var player = player_root.find_node(PLAYER_OBJECT)
onready var close_attack_area = player.get_node(CLOSE_ATTACK_AREA)
onready var state_label = player_root.find_node(SATATE_LABEL)
onready var right_wall_ray = player_root.find_node(RIGHT_WALL)
onready var left_wall_ray = player_root.find_node(LEFT_WALL)
onready var audio = player_root.find_node(AUDIO)
# user actions


func _ready():
	# Set the initial state to the first child node
	state = get_child(0)
	# Allow for all nodes to be ready before calling _enter_state
	call_deferred("_enter_state")


func change_to(new_state):
	history.append(state.name)
	state = get_node(new_state)
	_enter_state()


func back():
	if history.size() > 0:
		state = get_node(history.pop_back())
		_enter_state()

func get_history_back_state():
		return history.pop_back()

func _enter_state():
	if DEBUG:
		state_label.text = state.name
		print("Entering state (player): ", state.name)
	# Give the new state a reference to it's state machine i.e. this one
	state.fsm = self
	state.enter()


# Route Game Loop function calls to
# current state handler method if it exists
func _process(delta):
	_required_checked()
	if state.has_method("process"):
		state.process(delta)


func _physics_process(delta):
	if state.has_method("physics_process"):
		state.physics_process(delta)
		

func check_hit():
	if player_root.hit_status:
	#if player_root.hit_trigger:
		#player_root.hit_trigger = false
		return true
	else: 
		return false

func _input(event):
	if state.has_method("input"):
		state.input(event)

func _unhandled_input(event):
	if state.has_method("unhandled_input"):
		state.unhandled_input(event)


func _unhandled_key_input(event):
	if state.has_method("unhandled_key_input"):
		state.unhandled_key_input(event)


func _notification(what):
	if state and state.has_method("notification"):
			state.notification(what)

# Methods for checking for prerequisites, such as being in a state of death 
func _required_checked():
	if state and state.has_method("required_checked"):
		state.required_checked()


# Aditional functions
func get_direction(direction_right):
	return 2*int(direction_right)-1
	
	
#func get_offset_x(direction_right):
#	return offset_list[int(direction_right)]
	

func set_direction(player, direction_right):
	player.flip_h = not direction_right
	#player.scale = Vector2(get_direction(direction_right),1)
	#player.offset = Vector2(get_offset_x(direction_right),0)


func wall_detector():
	var left_direction = false
	var right_direction = false
	if self.player.is_flipped_h(): left_direction = true
	if not self.player.is_flipped_h(): right_direction = true
	return (left_wall_ray.is_colliding() and left_direction)  or (right_wall_ray.is_colliding() and right_direction)



