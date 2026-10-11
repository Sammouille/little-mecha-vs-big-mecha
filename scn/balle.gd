extends Area3D

@export var acceleration:= 5.0
@export var vitesse_max:= 20.0
@export var vitesse_rot:= 3.0
@export var mod_frein_rot:= 1.0
@export var delai_proc:= 0.2

var vitesse:= 1.0

@export var cible: Node3D

var touched:= false

func _physics_process(delta: float) -> void:
	if !touched:
		vitesse = minf(vitesse + acceleration * delta, vitesse_max)
		if cible:
			var rot_init = rotation
			look_at(cible.position + Vector3.UP * 2.0)
			var rot_aim = rotation
			var diff = (rot_aim - rot_init).length()
			if abs(diff) > 0.0:
				rotation = rot_init.slerp(rot_aim, vitesse_rot * delta)
				vitesse = maxf(0.0, vitesse - (rot_init - rotation).length() * mod_frein_rot)
			
		position += vitesse * -basis.z * delta

func detonation():
	touched = true
	vitesse = 0.0
	%Mesh.hide()
	%VFXImpactSmall_01.play()
	%Timer.wait_time = delai_proc
	%Timer.start()
	await %Timer.timeout
	for i in %Hit.get_overlapping_areas():
		if i.name == "BodyHit":
			i.get_parent().hit()
	await %VFXImpactSmall_01.finished
	queue_free()

func _on_body_entered(_body: Node3D) -> void:
	detonation()
	
