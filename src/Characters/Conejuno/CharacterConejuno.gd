tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	D.show_dialog('ChatWithConejuno')


func on_look() -> void:
	E.run([
		'Pato: The barman',
		'...',
		'Pato: The one who serves drinks and listens to nonsense stories every night'
	])
