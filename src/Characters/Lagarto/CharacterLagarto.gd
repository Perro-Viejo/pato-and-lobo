tool
extends Character

var _using_mask := true

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	_looking_dir = 'mask'
	idle(false)


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	
	yield(E.run([
		C.walk_to_clicked(),
		C.face_clicked(),
		'Pato: Hi-ya',
	]), 'completed')
	
	if _using_mask:
		yield(E.run(['Lagarto: Punchis punchis. Hi.']), 'completed')
	elif _can_put_mask():
		yield(
			E.run([
				'Lagarto: Wait. A star can\'t talk to nobody without a mask.',
				put_mask(),
				'Lagarto: So. What do you want?'
			]),
			'completed'
		)
	else:
		yield(
			E.run([
				'Lagarto: Fock. Someone stole my mask.',
				'Lagarto: You can talk to me, but don\'t dare to look at me.',
				C.player.face_right(),
				'Pato: Aaaaall right...'
			]),
			'completed'
		)
	D.show_dialog('ChatWithLagarto')


func on_look() -> void:
	if _using_mask:
		E.run(['Pato: I can use the DJ\'s wolf mask for my costume.'])
	elif _can_put_mask():
		E.run(['Pato: So that\'s why he uses the mask. Drogs!'])
	else:
		E.run(['Pato: His gaze is full of anguish.'])


func remove_mask(is_in_queue := true) -> void:
	if is_in_queue: yield()
	yield(_toggle_mask(false), 'completed')


func put_mask(is_in_queue := true) -> void:
	if is_in_queue: yield()
	yield(_toggle_mask(), 'completed')


func _toggle_mask(put := true) -> void:
	if not _can_put_mask():
		yield(get_tree(), 'idle_frame')
		return
	
	_using_mask = put
	_looking_dir = 'mask' if put else 'd'
	E.current_room.state.dj_uses_mask = put

	if put:
		E.current_room.get_prop('WolfMask').disable(false)
	else:
		E.current_room.get_prop('WolfMask').enable(false)

	idle(false)
	yield(get_tree().create_timer(0.3), 'timeout')


func _can_put_mask():
	return E.current_room.state.has_mask
