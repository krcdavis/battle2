extends Node2D

var item = preload("res://optbase.tscn")
var items = []

var actives = []

var cursor = 0

#var xd = 220
var yd = 65

var btlhead

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var itemst
	
	
	itemst = item.instantiate()
	itemst.highlight(false)
	items.append(itemst)
	items[0].get_node("Label").text = "Move3lol"
	items[0].name = "move0"
	add_child(items[0])
	
	itemst = item.instantiate()
	itemst.highlight(false)
	items.append(itemst)
	items[1].get_node("Label").text = "Move0"
	items[1].name = "move1"
	add_child(items[1])
	items[1].position += Vector2(0,yd)#lmao works
	
	
	itemst = item.instantiate()
	itemst.highlight(false)
	items.append(itemst)
	items[2].get_node("Label").text = "Move1"
	items[2].name = "move2"
	add_child(items[2])
	items[2].position += Vector2(0,yd*2)#lmao works
	
	
	itemst = item.instantiate()
	itemst.highlight(false)
	items.append(itemst)
	items[3].get_node("Label").text = "Move2"
	items[3].name = "move3"
	add_child(items[3])
	items[3].position += Vector2(0,yd*3)#lmao works
	
	
	itemst = item.instantiate()
	itemst.highlight(false)
	items.append(itemst)
	items[4].get_node("Label").text = "Back"
	items[4].name = "back"
	add_child(items[4])
	items[4].position += Vector2(0,yd*4)
	#will be reset to the position of the first non-vis move if less than 4 moves
	items[cursor].highlight()
	
	self.visible = false
	#update_cursor()


func mupdate(slot):#update menu w/ moves of mon in slot
	
	#i know: 'dummy' out all the moveslots then un-dummy them if valid moves exist
	#"Sprite2D2").visible = false/true, text = "--"
	actives.clear()
	for n in range(0,4):
		var move = btlhead.slots[slot].mon.getmove(n)
		
		if (g.lmoves.move_isvalid(move)):
			items[n].activate( true, g.lmoves.move_getname(move) + '\n' + str(btlhead.slots[slot].mon.usepoints[n]) + '/' + str(btlhead.slots[slot].mon.usemaxs[n]))
			
			actives.append(items[n])
			
			items[n].clear_data()
			items[n].add_data("moveid", move)
			items[n].add_data("moveindex", n)
		else:
			items[n].activate()
	
	
	#if no valid moves do... something
	#append back to actives
	actives.append( items[4] )

#tall menu
#up and right +1, down and left -1
func update_cursor(val = "Z"):#passes in "UP,"DW","LF","RT"
	var v = 0
	match val:
		"UP","LF":
			v = -1
		"DW","RT":
			v = 1
	cursor = (cursor + v + actives.size()) % actives.size()
	for n in range(0,actives.size()):
		actives[n].highlight(n == cursor)

func execute_cursor(slot = 0):#id, idx,
	if cursor == actives.size()-1:# back with yee
		btlhead.restate(btlhead.OPTIONS)
	else:
		#sets movenext for currently selected mon...
		#head.slots[slot].mon.getmove(cursor)
		#or items/actives [cursor] .get_data ("moveid" )
				#actives[cursor].get_data("moveid")
		btlhead.slots[slot].set_movenext(
			btlhead.slots[slot].mon.getmove(cursor),
			cursor,
			1#default...
		)
		
		#if done with all mons on your side...
		btlhead.exec_turn()
