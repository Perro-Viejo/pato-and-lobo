tool
extends Prop

export var is_the_one := false
export(String, MULTILINE) var details := ''
export(String, MULTILINE) var lobo_reaction := ''


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	if not Globals.has_done(Globals.GameState.GOT_HOME):
		yield(
			E.run([
				C.walk_to_clicked(),
				C.face_clicked(),
				'Pato: ' + details,
				'Pato: What do you think of this one?',
				'Lobo: ' + lobo_reaction,
			]), 'completed'
		)
		
		if is_the_one:
			yield(E.run(['Pato: So this one will be.']), 'completed')
			E.goto_room('Spaceship')
			Globals.did(Globals.GameState.GOT_HOME)
		else:
			E.run(["Pato: " + Utils.get_random_array_element(
				[
					"Agree, my love. Let's check other one.",
					"Yup. Maybe that one...",
					"You're right. I'll look another one."
				]
			)])
	else:
		E.run([G.display('Pato and Lobo already made a decision.')])

func on_look() -> void:
	E.run([
		'Pato: Is the sign with the detail of a house'
	])


func on_item_used(_item: Item) -> void:
	pass
