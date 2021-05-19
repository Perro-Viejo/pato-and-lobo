tool
extends Hotspot


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.SEA_DREAMED):
		yield(E.run([
			C.walk_to_clicked(),
			C.player.face_left(),
			C.player.say('Me voy a lavar las alitas'),
			#TODO: Estos sonidos no deberían sonar hasta que llegue al lavamanos
			A.play('sfx_sink_head', global_position),
			A.play('sfx_sink_loop', global_position),
			
			E.wait(),
			'Pato: ¡Ay qué rico!',
			#Estos sonidos deberían sonar despues o antes de cada frase
			A.play('sfx_sink_wash', global_position),
			'...',
			#Estos sonidos deberían sonar despues o antes de cada frase
			A.play('sfx_sink_wash', global_position),
			'Pato: ...y si',
			#Estos sonidos deberían sonar despues o antes de cada frase
			A.play('sfx_sink_wash', global_position),
			A.stop('bg_bar'),
			A.stop('mx_bar_01'),
			A.stop('sfx_sink_loop'),
		], false), 'completed')
		A.play('sfx_dream_transition', Vector2.ZERO, false)
		E.goto_room('Sea')
	else:
		E.run([
			C.player_say('Ya no me quiero lavar las alitas'),
			C.player_say('Tan limpias limpieciticas')
		])


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
