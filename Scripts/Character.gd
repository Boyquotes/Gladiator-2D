extends KinematicBody2D

var movementDiretion = Vector2.ZERO;
var movementSpeed = 100;
var dashSpeed = 550
var dashDuration = 0.1 * 1000
var lastDashed = OS.get_ticks_msec() - 10000
var dashCoolDown = 1 * 1000

#will handle updating movement dir, and also handle dahsing
func processInput():
	movementDiretion = Vector2.ZERO;
	if Input.is_key_pressed(KEY_A): 
		movementDiretion += Vector2(1,0)
	
	if Input.is_key_pressed(KEY_D): 
		movementDiretion += Vector2(-1,0)
	
	if Input.is_key_pressed(KEY_W): 
		movementDiretion += Vector2(0,1)	
	
	if Input.is_key_pressed(KEY_S): 
		movementDiretion += Vector2(0,-1)
	
	var dash = Input.is_key_pressed(KEY_Q)
	if((OS.get_ticks_msec() - lastDashed) < dashCoolDown) : dash = false
	updateChar(dash)
	


func updateChar(dash): #dash will be a bool
	if dash or (OS.get_ticks_msec() - lastDashed) < dashDuration:
		if(dash and (OS.get_ticks_msec() - lastDashed) > dashCoolDown): lastDashed = OS.get_ticks_msec()
		if(movementDiretion == Vector2.ZERO): movementDiretion = Vector2(1,0)
		
		self.move_and_slide(-movementDiretion * dashSpeed)
	else:
		self.move_and_slide(-movementDiretion * movementSpeed)


func _physics_process(delta):
	processInput()

#Flips body based on mouse
func _process(delta):
	var direction = (self.position - get_global_mouse_position()).normalized()
	if direction.x < 0: self.get_node("Body").scale.x = 1
	else: self.get_node("Body").scale.x = -1

