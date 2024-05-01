extends CharacterBody2D

var direction : Vector2 = Vector2.ZERO
var swing : bool = false

var last_direction = "Down"
@export var Bullet : PackedScene





func _physics_process(_delta):
	if not swing:
		velocity = direction * 75
	else:
		velocity = Vector2.ZERO
	if not swing:
		velocity = direction * 75
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _process(_delta):
	direction = Input.get_vector("Move_Left","Move_Right","Move_Up","Move_Down")
	
	if direction != Vector2.ZERO and not swing:
		set_walking(direction)
		#update_blend_position()
	else:
		set_walking(Vector2.ZERO)
	
	if Input.is_action_just_pressed("swing"):
		set_swing(true)
		
	if Input.is_action_just_pressed("Primary_Attack"):
		shoot()
			
func set_swing(value = false):
	swing = value
	#animation_tree["parameters/conditions/swing"] = value

func shoot():
	var bullet = Bullet.instantiate()
	owner.add_child(bullet)
	bullet.transform = $ReticleHolder/Sprite2D/Aim.global_transform

func set_walking(value):
	if value[1] == -1: # 0,-1
		last_direction = "Up"
	if value[1] == 1: # 0,1
		last_direction = "Down"
	if value[0] == -1: # -1,0
		last_direction = "Left"
	if value[0] == 1: # 1,0
		last_direction = "Right"

	if value == Vector2.ZERO:
		$AnimatedSprite2D.play("Idle_" + last_direction)
	else:
		$AnimatedSprite2D.play("Walk_" + last_direction)
	

#func update_blend_position():
	#animation_tree["parameters/attack/blend_position"] = direction
	#animation_tree["parameters/idle/blend_position"] = direction
	#animation_tree["parameters/walk/blend_position"] = direction


