extends Node3D

#current map and temp map
var cmap
var tmap
var wilds = []

var lastheal = ["formica_map_1_test_2", "point0"]#temporarily hardcoded

# Called when the node enters the scene tree for the first time.
func _ready():
	#(you) does not need to be loaded until the player first loads a map...
	#so move some of that to when setting up the map
	
	#$btlw1on1.deactivate()
	#$you/Camera3D.make_current()
	
	$you.head = self
	$you.visible = false
	$btlw1on1.head = self
	
	g.hud = $hud#done
	
	
	if FileAccess.file_exists("user://partysave.txt"):
		print("there it is")
		#read file then setup party
		var file = FileAccess.open("user://partysave.txt", FileAccess.READ)
		#file.get_line() into volume
		$pausehud/HSlider.set_value(float(file.get_line()))
		party.partyin.clear()
		for n in range(0,3):
			party.partyin.append([file.get_line(), int(file.get_line()), int(file.get_line())])
		print(party.partyin)
		file.close()
		party.setup_party(party.partyin)
		#loaded party is then used to fill load menu... which isn't loaded until changemap so should be fine
	else:
		print("there it isn't")
		#setup party then... don't write file yet
		#actually don't even set up party yet
	
	changemap(["newloadgame", "???"])
#	changemap(["formica_map_1_test_2", "point1"])
#	activ_player()
	#res://formica_map_1_test_2.tscn


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#e
func changemap(mapdata):#[map tscn name, point name]- point can be ignored for now (:
	#maybe change to map, point = null
	#everything is in one folder right now
	var temp = load("res://" + mapdata[0] + ".tscn")
	tmap = temp.instantiate()
	add_child(tmap)
	var snee = tmap.get_node_or_null(mapdata[1])
	#something
	if snee:#ideally, if you is undefined pos is undefined anyway
		$you.position = snee.position
	#queue free cmap
	if cmap:
		cmap.queue_free()
	cmap = tmap
	
	#all maps should have a head reference, maybe in a base script class
	#check map script for wild battle data and set something somewhere accordingly
	#if cmap has variable wilddata, load wilddata into ... here i guess
	#and set wilds=true, else clear wilds and set wild = false
	if "head" in cmap:#???
		cmap.head = self
	else:
		print("map missing head var")
	
	if "wilddata" in cmap:
		pass
		g.wild_map = true
		wilds = cmap.wilddata
	else:
		g.wild_map = false
		wilds = []#no cinnabar coast shenanigans here
	
	if cmap.has_method("loadingritual"):
		cmap.loadingritual()


#hm
var index = 0
#const wilds = [["flyder",10],["magnut",12],["lileaf",12],["slowcone",9],["shleep",11]]

func init_battle():
	#pause and hide current map, change global mode...
	index = g.rng.randi_range(0, wilds.size()-1)
	$btlw1on1.newbattle(wilds[index])
	cmap.visible = false

func endbattle():
	#undo init-battle
	cmap.visible = true
	$you/Camera3D.make_current()
	g.mode = "you"
	#do something to (you) to reset grasstimer

func wipeout():
	#called after btl-wipeout plays message and calls btl-cleanup
	g.mode = "wipeout-return"
	changemap(lastheal)

func saveparty():#and volume
	#next add hp
		var file = FileAccess.open("user://partysave.txt", FileAccess.WRITE)
		file.store_line(str($pausehud/HSlider.value))
		for mon in party.party:#species_id, level
			file.store_line(mon.species_id)
			file.store_line(str(mon.level))
			file.store_line(str(mon.health))
		file.close()

func loadfilegetstring():
	
	var stri = ""
	if FileAccess.file_exists("user://partysave.txt"):
		#print("there it is")
		#read file then do string
		var file = FileAccess.open("user://partysave.txt", FileAccess.READ)
		#file.get_line() into volume... yeah
		$pausehud/HSlider.set_value(float(file.get_line()))
		#party.partyin.clear()
		var discard = ""
		for n in range(0,3):
			stri += file.get_line() + ' Lv ' + file.get_line() + '\n'
			discard = file.get_line()
			#party.partyin.append([file.get_line(), int(file.get_line()), int(file.get_line())])
		#print(party.partyin)
		file.close()
		#party.setup_party(party.partyin)
		#loaded party is then used to fill load menu... which isn't loaded until changemap so should be fine
	else:
		print("there it isn't")
		stri = "No file found"
	return stri

func loadsav():
	if FileAccess.file_exists("user://partysave.txt"):
		var file = FileAccess.open("user://partysave.txt", FileAccess.READ)
		#file.get_line() into volume... yeah
		$pausehud/HSlider.set_value(float(file.get_line()))
		party.partyin.clear()
		var discard = ""
		for n in range(0,3):
			party.partyin.append([file.get_line(), int(file.get_line()), int(file.get_line())])
		print(party.partyin)
		file.close()
		party.setup_party(party.partyin)
	else:
		print("how are you even here if file no")

#enable/disable player control, similar to end-battle, maybe called from there
func activ_player(act=true):
	g.mode = "you"
	$you.visible = true
	$you/Camera3D.make_current()

func pause():
	$pausehud.visible = true
	g.mode = "paused"

func _on_button_pressed():
	saveparty()

func _on_button_4_pressed():#unpause
	$pausehud.visible = false
	g.mode = "you"

func unpause():
	$pausehud.visible = false
	g.mode = "you"

func loadbattlefield(tscn = "btlw_1_on_1"):
	pass
	#if not already loaded...
	#load res + tscn + .tscn, add child, set head
