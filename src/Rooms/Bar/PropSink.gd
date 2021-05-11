tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	yield(E.run([
		C.walk_to_clicked(),
		C.player.say('Me voy a lavar las alitas'),
		E.wait(),
		'Pato: ¡Ay qué rico!',
		'...',
		'Pato: ...y si...'
	]), 'completed')
	E.goto_room('Sea')


func on_look() -> void:
	E.run(['Pato: Ese es el lavamanos.'])


func on_item_used(item: Item) -> void:
	pass
