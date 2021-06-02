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
				'Pato: RoomHomesPlantation-PropSign-Pato-01',
				'Lobo: ' + lobo_reaction,
			]), 'completed'
		)
		
		if is_the_one:
			yield(E.run(['Pato: RoomHomesPlantation-PropSign-Pato-02']), 'completed')
			E.goto_room('Spaceship')
			Globals.did(Globals.GameState.GOT_HOME)
		else:
			E.run(["Pato: " + Utils.get_random_array_element(
				[
					"RoomHomesPlantation-PropSign-Pato-03",
					"RoomHomesPlantation-PropSign-Pato-04",
					"RoomHomesPlantation-PropSign-Pato-05"
				]
			)])
	else:
		E.run([G.display('Pato and Lobo already made a decision.')])

func on_look() -> void:
	E.run([
		'Pato: RoomHomesPlantation-PropSign-Pato-06'
	])


func on_item_used(_item: Item) -> void:
	pass
