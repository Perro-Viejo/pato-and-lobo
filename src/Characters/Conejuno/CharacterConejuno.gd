tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	D.show_dialog('ChatWithConejuno')


func on_look() -> void:
	E.run([
		C.player_say('Es el de la barra'),
		'...',
		C.player_say('Sirve tragos y escucha historias mierdas todos los días')
	])
