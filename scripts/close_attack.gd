extends Node

var fsm: StateMachine


func play_sound_sword_attack():
	var delta_volume=4
	var value_db_1 = -9
	var value_db_2 = -15
	fsm.audio.get_node('SwordAttack_1').volume_db = value_db_1
	fsm.audio.get_node('SwordAttack_2').volume_db = value_db_2
	fsm.audio.get_node('SwordAttack_1').play()
	yield(get_tree().create_timer(.3), "timeout")
	fsm.audio.get_node('SwordAttack_1').volume_db = fsm.audio.get_node('SwordAttack_1').get_volume_db()+3 
	fsm.audio.get_node('SwordAttack_1').play()
	yield(get_tree().create_timer(.3), "timeout")
	fsm.audio.get_node('SwordAttack_2').play()

func stop_sound_sword_attack():
	fsm.audio.get_node('SwordAttack_1').stop()
	fsm.audio.get_node('SwordAttack_2').stop()
	


func enter():
	#yield(get_tree().create_timer(2.0), "timeout")
	fsm.player.play('close_attack')
	#Play sound attack
	#play_sound_sword_attack()


func exit(next_state):
	stop_sound_sword_attack()
	fsm.close_attack_area.get_node('Strike1').set_disabled(true)
	if next_state == 'back':
		fsm.back()
	else:
		fsm.change_to(next_state)


####################################################
### Optional handler functions for game loop events.
####################################################

func physics_process(_delta):
	if fsm.player.get_frame() in fsm.CLOSE_ATTACK_FRAMES:
		fsm.close_attack_area.get_node('Strike1').set_disabled(false)
	else:
		fsm.close_attack_area.get_node('Strike1').set_disabled(true)
	if fsm.player_root.dead_status:
		exit('dead')
	if not Input.is_action_pressed(fsm.player_root.ui_close_attack):
		exit('back')

func input(_event):
	## attacks listener#####
	if _event.is_action_pressed(fsm.player_root.ui_close_attack):
		exit('close_attack')
	if _event.is_action_pressed(fsm.player_root.ui_ranged_attack):
		exit('ranged_attack')
	########################
	
func unhandled_input(_event):
	pass

func unhandled_key_input(_event):
	pass

func notification(_what, _flag = false):
	pass
