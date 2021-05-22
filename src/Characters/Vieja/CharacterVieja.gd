tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if E.current_room.state.vieja_sleeping:
		E.run([
			'Pato: That cocktail made the job. She fell asleep.',
			'Pato: I hope she\' be fine.'
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
			'Pato: Old-y. I invite you this drink.',
			I.remove_item('CocktailSuper'),
			'Pato: Strong and with the flavor of an elder so old...',
			'Vieja: Glob bless you, my girl.',
			'Vieja: glup glup glup glup glup.',
			E.wait(3.0),
			'Vieja: FOCK YEAH!... like old times.',
			'Vieja: All I have to do now is wait for....',
			sleep(),
			E.current_room.get_prop('GlassWithDentures').enable(),
			'Pato: Great! She put her dentures in the glass.'
		]), 'completed')
	elif item.script_name == 'CocktailSecret':
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
			'Pato: What do you think of this drink old-y?',
			I.remove_item('CocktailSecret'),
			'Vieja: Mmmmm... not bad at all... but',
			'Vieja: But it lacks of something. It tastes like an elder, but it isn\'t strong.'
		]), 'completed')
	elif item.script_name == 'CocktailGolem':
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
			'Pato: Drink this!',
			I.remove_item('CocktailGolem'),
			'Vieja: Pfffffffff.......',
			'Vieja: What da fock. This is as sweet as a little pink baby.',
			'Vieja: I told you I don\'t like Golem cocktail. It lacks of the elder flavor.',
		]), 'completed')


func sleep(is_in_queue := true) -> void:
	if is_in_queue: yield()
	A.play('sfx_granny_sleep', global_position, false)
	$AnimationPlayer.play('sleep')
	yield(E.wait(1.0, false), 'completed')
