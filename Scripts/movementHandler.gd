extends Node
#Nodes
onready var kinematicBody := self.get_parent()
onready var animator = kinematicBody.get_node("Animator") 


#Settings / Stats
var movementVector := Vector2.ZERO
var walkSpeed := 100


func moveBody(direction):
	movementVector = direction


func _ready():
	animator.play("Walk")

func _physics_process(_delta):
	if movementVector != Vector2.ZERO:
		kinematicBody.move_and_slide(movementVector * -walkSpeed)		
	
		
	movementVector = Vector2.ZERO



