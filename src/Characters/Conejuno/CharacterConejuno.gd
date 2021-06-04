tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	D.show_dialog('ChatWithConejuno')


func on_look() -> void:
	E.run([
		C.face_clicked(),
		'Pato: Character-Conejuno-OnLook-Pato-01',
		'Pato: Character-Conejuno-OnLook-Pato-02'
	])
