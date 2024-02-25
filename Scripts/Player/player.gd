extends CharacterBody3D

enum MoveType
{
	crouch,
	run,
	sprint
}

@export_category("References")
@export var cursorManager : CursorManager

@export_category("Movement")
@export var currentMoveType : MoveType
@export var normalScale : Vector3
@export var crouchScale : Vector3

@export_category("Stamina")
@export var currentStamina : float
@export var maxStamina : float = 100
@export var staminaRegen : float = 1.0 
@export var staminaDepletion : float = 1.0

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
	currentStamina = maxStamina

func _process(delta):
	
	if !cursorManager.isPaused:
		moveTypeDetection()
		
		if currentMoveType == MoveType.sprint and direction != Vector3.ZERO:
			currentStamina -= staminaDepletion * delta
			currentStamina = clamp(currentStamina, 0, maxStamina)
			
			if currentStamina <= 0:
				changeMoveType(MoveType.run)
		elif currentStamina < maxStamina and direction == Vector3.ZERO:
			currentStamina += staminaRegen * delta
			currentStamina = clamp(currentStamina, 0, maxStamina)
		
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
