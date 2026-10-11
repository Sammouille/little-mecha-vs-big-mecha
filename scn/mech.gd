extends CharacterBody3D


const SPEED = 23.0
const JUMP_VELOCITY = 38.0

var charge:= false
var charge_index:= 0.0
@export var charge_curve: Curve
var charge_rot_mod:= 0.3

@onready var anim_player:= %MechAnimationPlayer

var endurance:= 1.0
var hp:= 1.0


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func hit(degats:= 0.1):
	hp -= degats
	%Jauges.memoire_hp = hp

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 8.0
	elif endurance < 1.0:
		endurance = minf(endurance + delta * 0.8, 1.0)
		%Jauges.memoire_endu = endurance
	# Handle jump.
	if Input.is_action_just_pressed("saut") and (is_on_floor() or is_on_wall()):
		velocity.y = JUMP_VELOCITY
	
	
	var sourinput: Vector2
	sourinput = Input.get_last_mouse_velocity()
	var maninput: Vector2
	maninput = Vector2(Input.get_axis("regarder_gauche", "regarder_droite"), Input.get_axis("regarder_haut", "regarder_bas"))
	if sourinput != Vector2.ZERO:
		if charge:
			sourinput *= charge_rot_mod
		rotate_y(-sourinput.x * delta * 0.004)
		%Pivot.rotate_x(-sourinput.y * delta * 0.004)
		%Pivot.rotation.x = clampf(%Pivot.rotation.x, -0.5, 0.7)
	elif maninput != Vector2.ZERO:
		if charge:
			maninput *= charge_rot_mod
		rotate_y(-maninput.x * delta * 7.0)
		%Pivot.rotate_x(-maninput.y * delta * 5.0)
		%Pivot.rotation.x = clampf(%Pivot.rotation.x, -0.5, 0.7)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("gauche", "droite", "haut", "bas")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and !charge:
		charge_index = 0.0
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	elif charge:
		var mag_charge = charge_curve.sample(charge_index)
		charge_index += delta
		velocity = -%Pivot.global_basis.z.normalized() * mag_charge
		if endurance > 0.0:
			endurance -= delta * 0.12
			%Jauges.memoire_endu = endurance
		else:
			charge = false
	
	else:
		charge_index = 0.0
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
				
				
	if Input.is_action_just_pressed("proj") and endurance > 0.0:
		var dash_dir: Vector3
		if direction :
			dash_dir = (transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()
		else:
			dash_dir = -%Pivot.global_basis.z.normalized()
		velocity += dash_dir * 250.0
		endurance -= 0.1
		%Jauges.memoire_endu = endurance
		
	if Input.is_action_just_pressed("charge"):
		charge = !charge
		if endurance <= 0.0:
			charge = false
	
	
	if input_dir.y < 0.0:
		anim_player.play("Armature|RunForward", -1, 2.0)
	elif input_dir.y > 0.0:
		anim_player.play("Armature|RunBackward", -1, 2.0)
	elif input_dir.x < 0.0:
		anim_player.play("Armature|RunLeft", -1, 2.0)
	elif input_dir.x > 0.0:
		anim_player.play("Armature|RunRight", -1, 2.0)
	else:
		anim_player.play("Armature|Stand", -1, 2.0)
	
	move_and_slide()
