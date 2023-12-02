extends CharacterBody3D

const SPEED = 10.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var head

var dirnow
var dirnext
var dirnew
var mode = ""
#spintimer, spinstandard

@onready var area = $Area3D
@onready var step = $step

var ongrass = false
var stepping = false
var steptimer = 0.1

func _physics_process(delta):
	#match mode
	if g.mode == "you":
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta

		# don't Handle Jump.
		#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#	velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions. no i refuse
		var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			#print(direction)
			dirnow = -Vector2(direction.x,direction.z).angle()-PI/2
			$Sphere.set_rotation(Vector3(0,dirnow,0))
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
			
			ongrass = false
			var bodes = area.get_overlapping_bodies()
			for b in bodes:
				#some kind of priority for multiple overlapping areas
				if b.has_method("is_grass"):
					ongrass = true
					
					if stepping:#continue step countdown
						
						if step.is_paused():
							step.set_paused(false)
					else:
						stepping = true
						#start timer w/ random-ish value
						step.start(g.rng.randf_range(1.1,3.2))
			
			#perhaps move ongrass stuff here after setting it?
			if ongrass:
				pass
				#you're moving, so manually deplete step pseudo-timer by delta
				#if < 0, ...
				if stepping:
					steptimer -= delta
				else:#wait no don't do that here... ?
					stepping = true
					steptimer = g.rng.randf_range(1.1,3.2)
			
			else:
				pass
				#step.set_paused(true)
			
		else:#STOP
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			#pause step timer
			#step.set_paused(true)
		
		
		move_and_slide()
		
		#yeah, just set flags in above blocks and try for wilds here.
		#check for bodies here even


func _on_step_timeout():
	step.set_paused(true)
	print("AAAAAAAAAAAAAAAAA")
	stepping = false
	#if in grass or what have you, init battle
	#needs a pointer to btl or head or stg
	#perhaps store the current/last grassplane object colided with and call something
	#with that...
	head.init_battle()

func reset_grasstimer():
	#for returning from battle. ...
	pass
