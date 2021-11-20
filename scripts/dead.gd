extends Node

var fsm: StateMachine
#Imports
#var fsm = load("res://scripts/StateMachine.gd").new()


func enter():
	fsm.player.play('heart')
	#fsm.player_root.object_collision.set_collision_mask_bit(0, false)
	yield(get_tree().create_timer(0.9), "timeout")
	
	#fsm.player_root.object_collision.set_collision_mask_bit(0, true)
	var current_level = fsm.player_root.find_parent('Level1').get_node('PlatformLevel1')
	print(current_level.get_node('Checkpoint1').get_position())
	
	fsm.player_root.set_position(current_level.get_node('Checkpoint1').get_position())
	current_level.get_node('Checkpoint1').play()
	
	
	
	fsm.player_root.dead_status = false
	exit('idle')



func exit(next_state):
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
