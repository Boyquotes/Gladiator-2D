extends Node2D

onready var weaponData = load("res://Scripts/ItemData/Weapons.gd").new()
onready var weapon = $Weapon
onready var character = self.get_parent() 
var isAttacking = false #determines if hitbox shoudl work
const weaponDist = 7
var lastBasic = OS.get_ticks_msec() - 1000




func _input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		var currWeapon = weapon.get_child(0)
		var basicCoolDown = weaponData.data[currWeapon.name].CoolDown
		
		if OS.get_ticks_msec() - lastBasic > basicCoolDown:
			lastBasic = OS.get_ticks_msec()
			
			var animPlayer = currWeapon.get_node_or_null("AnimationPlayer")
			
			positionWeapon(currWeapon)
			currWeapon.visible = true

			animPlayer.connect("animation_finished", self, "attackStopped", [currWeapon])
			currWeapon.get_node("Hitbox").connect("body_entered", self, "handleHitbox", [currWeapon])
			animPlayer.play("Swing1")

func attackStopped(animName, weaponNode):
	weaponNode.visible = false
	weaponNode.get_node("Hitbox").disconnect("body_entered", self, "handleHitbox")

func positionWeapon(currWeapon):
	var direction = (get_local_mouse_position() - self.position).normalized()
	currWeapon.position = direction * weaponDist
	
	if direction.x < 0 : currWeapon.scale.x = -1	
	else: currWeapon.scale.x =1

func handleHitbox(hit, currWeapon):
	print("hello")
	print(currWeapon, hit)

