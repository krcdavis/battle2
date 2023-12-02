extends Node2D

var item = preload("res://optbase.tscn")
var items = []
var cursor = 0

var xd = 220
var yd = 80

var btlhead

# 2x2 square menu type thing
func _ready():
	
	var itemst
	
	
	itemst = item.instantiate()
	items.append(itemst)
	items[0].get_node("Label").text = "Battle"
	items[0].name = "opt0"
	add_child(items[0])
	
	itemst = item.instantiate()
	items.append(itemst)
	items[1].get_node("Label").text = "Bag"
	items[1].name = "opt1"
	add_child(items[1])
	items[1].position += Vector2(0,yd)#lmao works
	
	
	itemst = item.instantiate()
	items.append(itemst)
	items[2].get_node("Label").text = "Party"
	items[2].name = "opt2"
	add_child(items[2])
	items[2].position += Vector2(xd,0)#lmao works
	
	
	itemst = item.instantiate()
	items.append(itemst)
	items[3].get_node("Label").text = "Run"
	items[3].name = "opt3"
	add_child(items[3])
	items[3].position += Vector2(xd,yd)#lmao works
	
	update_cursor()

func update_cursor(val = "Z"):#passes in "UP,"DW","LF","RT"
	var v = 0
	match val:
		"Z":
			pass
		"UP":
			v = -1
		"DW":
			v = 1
		"LF":
			v = 2
		"RT":
			v = -2
		#etc
	
	#up and down scroll through the whole menu rather than switching rows. fix later i guess
	
	cursor = (cursor + v + 4) % 4
	
	for n in range(0,4):
			items[n].highlight(n==cursor)
	

func execute_cursor():
	#head.restate
	match cursor:
		0:
			btlhead.restate(btlhead.MOVES)
		1:
			pass#bag...
		2:
			btlhead.restate(btlhead.PARTYM)#party
		3:
			pass#run (:
			#rather, set active mon's next move to run
			btlhead.cleanup()
			#btlhead.slots[0].set_movenext( "run",0,0 )
