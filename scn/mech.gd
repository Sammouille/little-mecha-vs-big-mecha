extends CharacterBody3D


const SPEED = 23.0
const JUMP_VELOCITY = 38.0

@onready var anim_player:= %MechAnimationPlayer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 8.0
	# Handle jump.
	if Input.is_action_just_pressed("saut") and (is_on_floor() or is_on_wall()):
		velocity.y = JUMP_VELOCITY
	
	
	var sourinput: Vector2
	sourinput = Input.get_last_mouse_velocity()
	var maninput: Vector2
	maninput = Vector2(Input.get_axis("regarder_gauche", "regarder_droite"), Input.get_axis("regarder_haut", "regarder_bas"))
	if sourinput != Vector2.ZERO:
		rotate_y(-sourinput.x * delta * 0.004)
		%Pivot.rotate_x(-sourinput.y * delta * 0.004)
		%Pivot.rotation.x = clampf(%Pivot.rotation.x, -0.5, 0.7)
	elif maninput != Vector2.ZERO:
		rotate_y(-maninput.x * delta * 5.0)
		%Pivot.rotate_x(-maninput.y * delta * 5.0)
		%Pivot.rotation.x = clampf(%Pivot.rotation.x, -0.5, 0.7)
		
	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("gauche", "droite", "haut", "bas")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
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
