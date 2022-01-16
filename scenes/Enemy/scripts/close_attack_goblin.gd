extends Node

var fsm: StateMachineForGoblin


func enter():
	var random_close_attack = fsm.enemy_root.CLOSE_ATTACKS[randi() % fsm.enemy_root.CLOSE_ATTACKS.size()]
	fsm.pending_states = false
	fsm.enemy_root.close_attack_finished = false
	fsm.enemy.play(random_close_attack)


func exit(next_state):
	fsm.close_attack_area.get_node('Strike1').set_disabled(true)
	fsm.change_to(next_state)
	

func required_checked():
	if fsm.check_dead(): exit('dead')
	if fsm.check_hit(): exit('hit')


func process(_delta):
	if fsm.enemy.get_frame() in fsm.CLOSE_ATTACK_FRAMES:
		fsm.close_attack_area.get_node('Strike1').set_disabled(false)
	else:
		fsm.close_attack_area.get_node('Strike1').set_disabled(true)
	if fsm.enemy_root.close_attack_finished:
		exit('run')


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
