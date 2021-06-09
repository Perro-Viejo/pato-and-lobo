extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play('sfx_dentures_active', Vector2.ZERO, false)
	.on_interact()


func on_look() -> void:
	C.player_say('Items-Dentures-Pato-01', false)


func on_item_used(_item: Item) -> void:
	pass
