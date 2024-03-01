extends CharacterBody3D

enum MoveType
{
	crouch,
	run,
	sprint
}

@export_category("References")
@export var statManager : StatManager

@export_category("Movement")
@export var currentMoveType : MoveType
@export var normalScale : Vector3
@export var crouchScale : Vector3


@export_category("Movement Speed")
@export var currentSpeed : float = 5.0
@export var crouchSpeed : float = 3.0
@export var runSpeed : float = 5.0
@export var sprintSpeed : float = 7.0

@export_category("Jumping")
@export var jumpHeight : float = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export_category("Debug")
@export var direction : Vector3
@export var inputDir : Vector2

func _ready():
	changeMoveType(MoveType.run)

func _process(delta):
	
	if !cursorManager.isPaused:
		moveTypeDetection()
		
		#if the player is sprinting and moving lower their stamina
		if currentMoveType == MoveType.sprint and direction != Vector3.ZERO:
			statManager.ChangeStamina(statManager.staminaDepletion, true)
			#if the stamina is less than or equal to 0 and the player is sprinting, make them run
			if statManager.currentStamina <= 0:
				changeMoveType(MoveType.run)
		#if the player is not sprinting regen their stamina
		elif statManager.currentStamina < statManager.maxStamina and direction == Vector3.ZERO:
			statManager.ChangeStamina(statManager.staminaRegen, false)
		
		#detects if the player is below the map
		if position.y <= -10:
			position = Vector3.ZERO
			position.y = 5

func moveTypeDetection():
	if Input.is_action_just_pressed("crouch"):
		if currentMoveType != MoveType.crouch:
			changeMoveType(MoveType.crouch)
		else:
			changeMoveType(MoveType.run)
	if Input.is_action_just_pressed("sprint"):
		if currentMoveType != MoveType.sprint:
			changeMoveType(MoveType.sprint)
		else:
			changeMoveType(MoveType.run)
		
func changeMoveType(moveType : MoveType):
	currentMoveType = moveType
	if moveType == MoveType.crouch:
		scale = crouchScale
		currentSpeed = crouchSpeed
	if moveType == MoveType.run:
		scale = normalScale
		currentSpeed = runSpeed
	if moveType == MoveType.sprint:
		scale = normalScale
		currentSpeed = sprintSpeed

func _physics_process(delta):
	
	if !cursorManager.isPaused:
		#gravity
		if not is_on_floor():
			velocity.y -= gravity * delta
		
		#jumping
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y += jumpHeight
		
		move()

func move():
	#input direction
	if is_on_floor():
		inputDir = Input.get_vector("left", "right", "forward", "backwards")
		direction = (transform.basis * Vector3(inputDir.x, 0, inputDir.y)).normalized()
	if direction:
		velocity = Vector3(direction.x * currentSpeed, velocity.y, direction.z * currentSpeed)
	else:
		velocity.x = move_toward(velocity.x, 0, currentSpeed)
		velocity.z = move_toward(velocity.z, 0, currentSpeed)
	
	move_and_slide()
