extends Node

onready var kinematicBody = self.get_parent()
onready var movementNode = kinematicBody.get_node("Movement")
onready var animator = kinematicBody.get_node("Animator")


func _process(_delta):
	if OS.get_ticks_msec() - movementNode.lastDashed < movementNode.dashCooldown * 0.5:
		animator.play("Dash")
		print('dash')
	elif movementNode.movementVector != Vector2.ZERO:
		animator.play("Walk")
	else:
		animator.play("RESET")
		print("idle")
