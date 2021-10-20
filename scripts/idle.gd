extends Node

var fsm: StateMachine


func enter():
	fsm.player.play('idle')


func exit(next_state):
	fsm.change_to(next_state)


func process(_delta):
	if Input.is_action_pressed(fsm.player_root.ui_right) or Input.is_action_pressed(fsm.player_root.ui_left):
		exit("run")
	if not fsm.player_root.is_on_floor():
		exit('falling')


func physics_process(_delta):
	pass

	
func input(_event):
	## attacks listener#####
	if _event.is_action_pressed(fsm.player_root.ui_close_attack):
		exit('close_attack')
	if _event.is_action_pressed(fsm.player_root.ui_ranged_attack):
		exit('ranged_attack')
	########################
	if _event.is_action_pressed(fsm.player_root.ui_left) or _event.is_action_pressed(fsm.player_root.ui_right):
		exit('run')
	elif _event.is_action_pressed(fsm.player_root.ui_up) :
		exit('jump')
	

func unhandled_input(_event):
	pass

func unhandled_key_input(_event):
	pass

func notification(_what, _flag = false):
	pass
