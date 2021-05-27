class_name VfxSpin
extends Tween
# Hace girar por toda la eternidad los nodos que estén asignados al arreglo

# TODO: Que se puedan definir distintas velocidades.
# TODO: Que se puedan definir un número de repeticiones.

export(Array, NodePath) var targets = []
export var turn_duration := 3.0


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func _ready() -> void:
	repeat = true


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos públicos ░░░░
func spin_all() -> void:
	for t in targets:
		_spin(get_node(t))


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos privados ░░░░
func _spin(target: Node2D) -> void:
	interpolate_property(
		target, 'rotation_degrees',
		0, 360.0,
		turn_duration, Tween.TRANS_LINEAR, Tween.EASE_OUT
	)
	start()
