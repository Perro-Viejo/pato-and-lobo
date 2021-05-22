tool
extends Prop


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	yield(E.run([
		C.walk_to_clicked()
	]), 'completed')
	A.play('sfx_spaceship_transition', Vector2.ZERO, false)
	E.goto_room('Luna')


func on_look() -> void:
	pass


func on_item_used(item: Item) -> void:
	pass
