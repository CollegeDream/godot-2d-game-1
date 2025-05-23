extends CharacterBody2D

signal health_depleted

var health = 100.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		$HappyBoo.play_walk_animation()
	else:
		$HappyBoo.play_idle_animation()

	const DMG_RATE = 50.0
	var overlapping_bodies = %hurtBox.get_overlapping_bodies()
	if overlapping_bodies.size() > 0:
		health -= DMG_RATE * overlapping_bodies.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()
	
