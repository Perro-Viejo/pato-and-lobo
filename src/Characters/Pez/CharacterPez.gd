tool
extends Character

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	D.show_dialog('ChatWithPez')


func on_look() -> void:
	.on_look()


func get_dialog_pos() -> float:
	return $AnimatedSprite.position.y - 32.0
