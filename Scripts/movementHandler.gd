extends Node
onready var kinematicBody := self.get_parent()

#Settings / Stats
var movementVector := Vector2.ZERO
var walkSpeed := 5000

var lastDashed := OS.get_ticks_msec() -10000
var dashSpeed := 20000
var dashDirection := Vector2(1,1)
var dashCooldown := 500
var dashDuration = 150

func moveBody(direction):
	movementVector = direction

func dash():
	if OS.get_ticks_msec() - lastDashed < dashCooldown: return
	lastDashed = OS.get_ticks_msec()
	dashDirection = (Vector2(-1,0) if movementVector == Vector2.ZERO else movementVector)

	
func _physics_process(delta):
	if OS.get_ticks_msec() - lastDashed < dashDuration:
		kinematicBody.move_and_slide(dashDirection * (-dashSpeed * delta))		
	
	if movementVector != Vector2.ZERO:
		kinematicBody.move_and_slide(movementVector * (-walkSpeed * delta))		
	
	movementVector = Vector2.ZERO



