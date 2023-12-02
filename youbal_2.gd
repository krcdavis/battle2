extends CharacterBody3D

const SPEED = 10.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var head

var dirnow
#var dirnext
#var dirnew
var mode = ""
#spintimer, spinstandard

@onready var area = $Area3D
#@onready var step = $step

var ongrass = false
var moving = false
var steptimer = -0.1

func _ready():
	restep()

func _physics_process(delta):
	#match mode
	if g.mode == "you":
		# Add the gravity.
		if not is_on_floor():
			velocity.y -= gravity * delta

		# reuse this for pause lol
		if Input.is_action_just_pressed("ui_accept"):# and is_on_floor():
			head.pause()
		
		else:
			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions. no i refuse
			var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
			var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			moving = false
			if direction:
				#print(direction)
				dirnow = -Vector2(direction.x,direction.z).angle()-PI/2
				$Sphere.set_rotation(Vector3(0,dirnow,0))
				velocity.x = direction.x * SPEED
				velocity.z = direction.z * SPEED
				
			else:#STOP
				velocity.x = move_toward(velocity.x, 0, SPEED)
				velocity.z = move_toward(velocity.z, 0, SPEED)
				#pause step timer
				#step.set_paused(true)
			if velocity.x != 0 or velocity.z != 0:
				moving = true
			
			#moving before checking for grass etc is probably best
			move_and_slide()
			
			#if you were moving on this frame, check for colis with grass, etc
			ongrass = false
			#and if g.wild_map or something
			if moving and g.wild_map:#use velocity instead?...
				var bodes = area.get_overlapping_bodies()
				for b in bodes:
					if b.has_method("is_grass"):
						ongrass = true
				
				if true:#ongrass:
					
					if steptimer <= 0:
						#set to random value. this way it'll be >0 when returning from battle
						restep()
						print(steptimer)
						head.init_battle()
					else:
						steptimer -= delta
						#this doesn't decrement sometimes when it should, possibly
						#due to grass colis being too small...
					
					
				

func restep():
	#the range will depend on various other factors
	steptimer = g.rng.randf_range(1.1,1.2)
