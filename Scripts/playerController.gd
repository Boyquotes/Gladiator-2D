extends Node

onready var kinematicBody := self.get_parent()
onready var combat := kinematicBody.get_node("Combat")
onready var movement := kinematicBody.get_node("Movement")



func _process(_delta):
	updateMovement()
	
	



func updateMovement():
	var direction := Vector2.ZERO
	
	if Input.is_key_pressed(KEY_W) : direction.y +=1;
	if Input.is_key_pressed(KEY_S) : direction.y -=1;
	if Input.is_key_pressed(KEY_A) : direction.x +=1;
	if Input.is_key_pressed(KEY_D) : direction.x -=1;
	
	if direction.length() != 0: movement.call("moveBody", direction)
	if Input.is_key_pressed(KEY_Q) : movement.call("dash")
