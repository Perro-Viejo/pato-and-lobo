extends CanvasLayer

enum Type {
	NONE,
	ACTIVE,
	DOWN,
	IDLE,
	LEFT,
	LOOK,
	RIGHT,
	SEARCH,
	TALK,
	UP,
	USE,
	WAIT,
}

export var hotspot := Vector2.ZERO


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_cursor()


func _process(_delta):
	$AnimatedSprite.position = $AnimatedSprite.get_global_mouse_position()
	$Sprite.position = $AnimatedSprite.get_global_mouse_position()
	$AnimatedSprite.position += hotspot
	$Sprite.position += hotspot


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func set_cursor(type := Type.IDLE) -> void:
	var anim_name: String = Type.keys()[Type.IDLE]
	if Type.values().has(type):
		anim_name = Type.keys()[type]
	$AnimatedSprite.play(anim_name.to_lower())


func set_item_cursor(texture: Texture) -> void:
	$AnimatedSprite.hide()
	$Sprite.texture = texture
	$Sprite.show()


func remove_item_cursor() -> void:
	$Sprite.texture = null
	$Sprite.hide()
	$AnimatedSprite.show()


func toggle_visibility(is_visible: bool) -> void:
	$AnimatedSprite.visible = is_visible
	$Sprite.visible = is_visible
