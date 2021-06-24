extends Area2D

var _inside = false

func _ready():
	connect('area_entered', self, '_on_area_entered')
	connect('area_exited', self, '_on_area_exited')

func _process(delta):
	if _inside:
		print(global_position.distance_to(C.player.global_position))

func _on_area_entered(body) -> void:
	if body.name == 'CharacterPato':
		_inside = true

func _on_area_exited(body) -> void:
	if body.name == 'CharacterPato':
		_inside = false
