extends Node

var fsm: StateMachine
#Imports
#var fsm = load("res://scripts/StateMachine.gd").new()


func enter():
	fsm.player.play('heart')
	fsm.player_root.show_blood()
	#fsm.player_root.object_collision.set_collision_mask_bit(0, false)
	yield(get_tree().create_timer(0.9), "timeout")
	
	var current_level = fsm.player_root.find_parent('Lavel1')
	
	fsm.player_root.set_position(current_level.get_node('Checkpoint1').get_position())
	
	current_level.get_node('Checkpoint1').play()

	
	fsm.player_root.hit_counter = 0
	fsm.player_root.dead_status = false
	exit('idle')



func exit(next_state):
	fsm.player_root.camera_normalize()
	fsm.change_to(next_state)


func process(_delta):
	pass


func physics_process(_delta):
	pass

	
func input(_event):
	pass
	

func unhandled_input(_event):
	pass

func unhandled_key_input(_event):
	pass

func notification(_what, _flag = false):
	pass
