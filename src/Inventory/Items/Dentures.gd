extends Item


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	A.play('sfx_dentures_active', Vector2.ZERO, false)
	.on_interact()


func on_look() -> void:
	C.player_say('Esta dentadura de lobo me servirá resto', false)


func on_item_used(item: Item) -> void:
	pass
