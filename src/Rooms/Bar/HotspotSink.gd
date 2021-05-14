tool
extends Hotspot


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	yield(E.run([
		C.walk_to_clicked(),
		C.player.say('Me voy a lavar las alitas'),
		#TODO: Estos sonidos no deberían sonar hasta que llegue al lavamanos
		A.play('sfx_sink_head', global_position, false),
		A.play('sfx_sink_loop', global_position, false),
		
		E.wait(),
		'Pato: ¡Ay qué rico!',
		#Estos sonidos deberían sonar despues o antes de cada frase
		A.play('sfx_sink_wash', global_position, false),
		'...',
		A.play('sfx_sink_wash', global_position, false),
		'Pato: ...y si...',
		A.play('sfx_sink_wash', global_position, false),
		A.stop('bg_bar'),
		A.stop('mx_bar_01'),
		A.stop('sfx_sink_loop'),
	]), 'completed')
	E.goto_room('Sea')
	A.play('sfx_dream_transition', Vector2.ZERO, false)


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
