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
		'Pato: Hola',
	]), 'completed')
	
	if _using_mask:
		yield(E.run(['Lagarto: Punchis punchis. Hola.']), 'completed')
	elif _can_put_mask():
		yield(
			E.run([
				'Lagarto: Un momento. Una estrella no habla cara a cara con la chusma.',
				put_mask(),
				'Lagarto: Listo. ¿Qué pasó?'
			]),
			'completed'
		)
	else:
		yield(
			E.run([
				'Lagarto: Me lleva la verdura. Me robaron mi máscara.',
				'Lagarto: Puedes hablarme, pero no me mires a la cara.',
				C.player.face_right(),
				'Pato: Está bien...'
			]),
			'completed'
		)
	D.show_dialog('ChatWithLagarto')


func on_look() -> void:
	if _using_mask:
		E.run(['Pato: Esa máscara del DJ puede servirme como disfraz.'])
	elif _can_put_mask():
		E.run(['Pato: Con razón usaba esa máscara... está todo llevado.'])
	else:
		E.run(['Pato: Hay algo de angustia en sus mirada.'])


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
