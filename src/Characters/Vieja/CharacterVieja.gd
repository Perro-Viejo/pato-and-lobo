tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if E.current_room.state.vieja_sleeping:
		E.run([
			'Pato: La vieja quedó foquiada con mi super coctel.',
			'Pato: Ojalá no le hagan cosas malas.'
		])
		return
	D.show_dialog('ChatWithVieja')


func on_look() -> void:
	.on_look()


func on_item_used(item: Item) -> void:
	if item.script_name == 'CocktailSuper':
		E.current_room.state.vieja_sleeping = true
		E.current_room.state.has_dentures = true
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
			'Pato: Vea señora. Le invito este traguito.',
			I.remove_item('CocktailSuper'),
			'Pato: Fuerte y con sabor a viejo.',
			'Vieja: Que el santo pollo la bendiga mija.',
			'Vieja: glup glup glup glup glup.',
			E.wait(3.0),
			'Vieja: Oh sí... como en los viejos tiempos.',
			'Vieja: Ahora sólo queda esperar a que....',
			sleep(),
			E.current_room.get_prop('GlassWithDentures').enable(),
			'Pato: ¡Ferpecto! Alcanzó a dejar sus muelas en el vaso.'
		]), 'completed')
	elif item.script_name == 'CocktailSecret':
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
			'Pato: ¿Qué opina de este trago?',
			I.remove_item('CocktailSecret'),
			'Vieja: Mmmmm... no está nada mal... pero',
			'Vieja: Como que le falta alguito. Sabe a viejo, pero no está tan fuerte.'
		]), 'completed')
	elif item.script_name == 'CocktailGolem':
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
			'Pato: Tómese este',
			I.remove_item('CocktailGolem'),
			'Vieja: Pfffffffff.......',
			'Vieja: Está fuerte pero mucho lo dulce.',
			'Vieja: El Gólem no me gusta por eso. Le falta el sabor a viejo.',
		]), 'completed')


func sleep(is_in_queue := true) -> void:
	if is_in_queue: yield()
	A.play('sfx_granny_sleep', global_position, false)
	$AnimationPlayer.play('sleep')
	yield(E.wait(1.0, false), 'completed')
