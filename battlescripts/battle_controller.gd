extends "battle_utils.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#disable if not global battle mode pls
	#match mode and catch inputs...
		match mode:
			"aa":
				pass
			"hf":
				pass
			OPTIONS, MOVES, BAGM, PARTYM:
				pass
				#here's hoping activemenu is set correctly
				if Input.is_action_just_pressed("ui_up"):
					activemenu.update_cursor("UP")#well it doesn't complain at least
				else: if Input.is_action_just_pressed("ui_down"):
					activemenu.update_cursor("DW")
				else: if Input.is_action_just_pressed("ui_left"):
					activemenu.update_cursor("LF")
				else: if Input.is_action_just_pressed("ui_right"):
					activemenu.update_cursor("RT")
				else: if Input.is_action_just_pressed("ui_accept"):
					activemenu.execute_cursor()
		pass

