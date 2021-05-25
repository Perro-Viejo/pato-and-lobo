tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	yield(E.run([
		A.play('sfx_spaceship_transition', Vector2.ZERO),
		C.walk_to_clicked()
	]), 'completed')
	E.goto_room('Luna')


func on_look() -> void:
	pass


func on_item_used(_item: Item) -> void:
	pass
