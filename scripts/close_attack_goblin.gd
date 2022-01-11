extends Node

var fsm: StateMachineForGoblin


func enter():
	var random_close_attack = fsm.enemy_root.CLOSE_ATTACKS[randi() % fsm.enemy_root.CLOSE_ATTACKS.size()]
	print(random_close_attack)
	fsm.pending_states = false
	fsm.enemy_root.close_attack_finished = false
	fsm.enemy.play(random_close_attack)
	#yield(get_tree().create_timer(5), "timeout")
	#If the player is still around, then we carry out a second attack. 
	#if fsm.player_is_close() and not fsm.enemy_root.dead_status and not fsm.enemy_root.hit_status: 
	#	fsm.enemy.play('close_attack2')
	#	yield(get_tree().create_timer(1), "timeout")
	
	#if not fsm.enemy_root.dead_status:
		#exit('run')


func exit(next_state):
	fsm.change_to(next_state)


func process(_delta):
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
