tool
extends Character

var disguised := false


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	I.connect('item_added', self, '_check_costume_completion')
	_check_costume_completion(null)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	.on_interact()


func on_look() -> void:
	.on_look()


func dance(is_in_queue := true) -> void:
	if is_in_queue: yield()
	$AnimationPlayer.play('dance_%s' % _looking_dir)
	yield(get_tree().create_timer(0.5), 'timeout')


func _check_costume_completion(item: Item) -> void:
	if not is_instance_valid(item): return
	
	match item.script_name:
		'Mask', 'Dentures', 'Legs', 'Tail':
			if E.current_room.script_name == 'Bar' \
				and Globals.has_done(Globals.GameState.MASK_TAKEN) \
				and Globals.has_done(Globals.GameState.DENTURES_TAKEN) \
				and Globals.has_done(Globals.GameState.LEGS_TAKEN) \
				and Globals.has_done(Globals.GameState.TAIL_TAKEN):
				
				if not disguised:
					Globals.did(Globals.GameState.DISGUISED)
					disguised = true
					yield(E.run([
						'Pato: WEEEEEEEEEE!',
						'Pato: I completed the costume',
						'Pato: Now... wolf transformation'
					]), 'completed')
					I.remove_item('Mask', false)
					I.remove_item('Dentures', false)
					I.remove_item('Tail', false)
					I.remove_item('Legs', false)
					anim_suffix = '_costume'
					idle(false)
					Globals.courage += 50
					yield(I, 'courage_update_shown')
					E.run(['Pato: I feel I\'m ready to talk with Lobo!'])
			else:
				anim_suffix = ''
				idle(false)
