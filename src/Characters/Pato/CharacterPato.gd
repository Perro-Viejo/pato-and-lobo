tool
extends Character

var disguised := false
var walking := false
var current_surface := 'tile'


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos de Godot ░░░░
func _ready() -> void:
	I.connect('item_added', self, '_check_costume_completion')
	_check_costume_completion(null)
	$AnimationPlayer.connect('animation_started', self, '_animation_started')


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ métodos virtuales ░░░░
func on_interact() -> void:
	.on_interact()


func on_look() -> void:
	.on_look()


func dance(is_in_queue := true) -> void:
	if is_in_queue: yield()
	$AnimationPlayer.play('dance_%s' % _looking_dir)
	yield(get_tree().create_timer(0.5), 'timeout')


func _check_costume_completion(item: Item) -> void:
	if not is_instance_valid(item): return
	
	match item.script_name:
		'Mask', 'Dentures', 'Legs', 'Tail':
			if E.current_room.script_name == 'Bar' \
				and Globals.has_done(Globals.GameState.MASK_TAKEN) \
				and Globals.has_done(Globals.GameState.DENTURES_TAKEN) \
				and Globals.has_done(Globals.GameState.LEGS_TAKEN) \
				and Globals.has_done(Globals.GameState.TAIL_TAKEN):
				
				if not disguised:
					Globals.did(Globals.GameState.DISGUISED)
					disguised = true
					yield(E.run([
						'Pato: CharacterPato-CheckCostumeCompletion-Pato-01',
						'Pato: CharacterPato-CheckCostumeCompletion-Pato-02',
						'Pato: CharacterPato-CheckCostumeCompletion-Pato-03'
					]), 'completed')
					I.remove_item('Mask', false)
					I.remove_item('Dentures', false)
					I.remove_item('Tail', false)
					I.remove_item('Legs', false)
					anim_suffix = '_costume'
					idle(false)

					Globals.courage += 50
					yield(I, 'courage_update_shown')

					E.run(['Pato: CharacterPato-CheckCostumeCompletion-Pato-04'])
			else:
				anim_suffix = ''
				idle(false)

func _animation_started(anim) -> void:
	if anim == 'walk_l' or anim == 'walk_r' :
		if not walking:
			walking = true
			if $AnimatedSprite.is_connected('frame_changed', self, '_check_frame'):
				pass
			else:
				$AnimatedSprite.connect('frame_changed', self, '_check_frame')
	else:
		if $AnimatedSprite.is_connected('frame_changed', self, '_check_frame'):
			$AnimatedSprite.disconnect('frame_changed', self, '_check_frame')
		else:
			pass
		walking = false

func _check_frame() -> void:
	if $AnimatedSprite.frame == 11 or $AnimatedSprite.frame == 23:
		A.play({cue_name = 'sfx_fs_%s_0%s' % [current_surface, randi() % 4 + 1], pos = global_position, is_in_queue = false})
