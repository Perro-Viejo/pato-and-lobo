tool
extends Hotspot


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	yield(E.run([
		C.walk_to_clicked(),
		A.stop('bg_bar'),
		A.stop('mx_bar_01'),
		C.player.say('Me voy a lavar las alitas'),
		E.wait(),
		'Pato: ¡Ay qué rico!',
		'...',
		'Pato: ...y si...'
	]), 'completed')
	E.goto_room('Sea')


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
