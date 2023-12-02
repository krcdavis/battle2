extends CanvasLayer

@onready var loadgame = $optbase
@onready var newgame = $optbase2
var ar = []
var cursor = false
var head

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#check for savefile and load up load game display
	
	ar = [loadgame,newgame]
	#optbase has been shanghai'd by replacing arr's sprite with the button background sprite, to
	#'highlight' the entire option
	#defaults to load message since that's selected
	g.hud.txb.textplay("Load a file if one exists, or start a new game",true)
	newgame.highlight(false)
	
#	if not party.partyloaded:
#		print("no")#optbase/Label2
#		$optbase/Label2.text = "no file found"
	

#stuff that needs to be done once head is set in head
func loadingritual():
	var tt = head.loadfilegetstring()
	#if file is not found, returns "no file found", else
	$optbase/Label2.text = tt

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#if up, down, left or right pressed, flip arrows on/off; 
	#lol
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		pass#swap cursor, update textbox
		loadgame.highlight(cursor)
		cursor = not cursor
		newgame.highlight(cursor)
		#if cursor, newgametext, else loadgametext
		#you know i could just use 0-1
	else: if Input.is_action_just_pressed("ui_accept"):
		pass#dewit
		if cursor:
			print("new?")
			#head.mapsetup()#but no 'you' yet
			head.changemap( ["newgameseq","dummy"] )#once this ends do mapsetup() to load (you)
		else:
			print("load?")
			#head.mapsetup()
			#head.changemap( town )
			#or maybe head.changemap(mapsetupper)
			
			head.loadsav()
			head.changemap(["formica_map_1_test_2", "point0"])
			head.activ_player()
			#clear textbox pls- in fact, new textbox funcs for instant text, blocking other inputs while tbox is waiting for enter, clearing
			g.hud.txb.texthide()

