tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if E.current_room.state.vieja_sleeping:
		E.run([
			'Pato: ',
			'Pato: '
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
			'Pato: Character-Vieja-CocktailSuper-Pato-01',
			I.remove_item('CocktailSuper'),
			'Pato: Character-Vieja-CocktailSuper-Pato-02',
			'Vieja: Character-Vieja-CocktailSuper-Vieja-03',
			'Vieja: Character-Vieja-CocktailSuper-Vieja-04',
			A.play('sfx_granny_drink', C.get_character('Vieja').global_position),
			E.wait(3.0),
			'Vieja: Character-Vieja-CocktailSuper-Vieja-05',
			'Vieja: Character-Vieja-CocktailSuper-Vieja-06',
			A.play('sfx_mask_takeoff', C.get_character('Vieja').global_position),
			sleep(),
			E.current_room.get_prop('GlassWithDentures').enable(),
			'Pato: Character-Vieja-CocktailSuper-Pato-07'
		]), 'completed')
	elif item.script_name == 'CocktailSecret':
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
			'Pato: Character-Vieja-CocktailSecret-Pato-01',
			I.remove_item('CocktailSecret'),
			'Vieja: Character-Vieja-CocktailSecret-Vieja-02',
			'Vieja: Character-Vieja-CocktailSecret-Vieja-03'
		]), 'completed')
	elif item.script_name == 'CocktailGolem':
		yield(E.run([
			C.walk_to_clicked(),
			C.face_clicked(),
			'Pato: Character-Vieja-CocktailGolem-Pato-01',
			I.remove_item('CocktailGolem'),
			'Vieja: Character-Vieja-CocktailGolem-Vieja-02',
			'Vieja: Character-Vieja-CocktailGolem-Vieja-03',
			'Vieja: Character-Vieja-CocktailGolem-Vieja-04',
		]), 'completed')


func sleep(is_in_queue := true) -> void:
	if is_in_queue: yield()
	A.play('sfx_granny_sleep', global_position, false)
	$AnimationPlayer.play('sleep')
	yield(E.wait(1.0, false), 'completed')
