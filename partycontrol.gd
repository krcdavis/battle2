extends Node2D

var item = preload("res://optbase.tscn")
var items = []

var actives = []

var moveids = []
var moveidxs = []

var cursor = 0

#var xd = 220
var yd = 65

var btlhead

# Called when the node enters the scene tree for the first time.
func _ready():
	#hardcoded for four party slots, you're stuck with three for this demo anyway
	var itemst
	
	itemst = item.instantiate()
	itemst.highlight(false)
	items.append(itemst)
	items[0].get_node("Label").text = "Mon1"
	items[0].name = "move0"
	add_child(items[0])
	
	itemst = item.instantiate()
	itemst.highlight(false)
	items.append(itemst)
	items[1].get_node("Label").text = "Mon2"
	items[1].name = "move1"
	add_child(items[1])
	items[1].position += Vector2(0,yd)#lmao works
	
	
	itemst = item.instantiate()
	itemst.highlight(false)
	items.append(itemst)
	items[2].get_node("Label").text = "Mon3"
	items[2].name = "move2"
	add_child(items[2])
	items[2].position += Vector2(0,yd*2)#lmao works
	
	
	itemst = item.instantiate()
	itemst.highlight(false)
	items.append(itemst)
	items[3].get_node("Label").text = "Mon4"
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
	pupdate()

func pupdate(temp = -1):
	pass#btlhead.slots[slot].mon.getmove(n)
	
	var partyindex = 0
	
	#use index instead
	for it in range(0,4):#backlol
		
		if it < party.party.size():#0,1,2; 3
			if check_mon(party.party[partyindex],temp):
				pass
				#initiate 
				items[it].setlabel(party.party[partyindex].nname)
				
				items[it].clear_data()
				items[it].add_data(dt.tgname,party.party[partyindex].nname)
				items[it].add_data("index", it)
			
			partyindex += 1
		else:
			pass#deactivate items
		
		


func update_cursor(val = "Z"):#passes in "UP,"DW","LF","RT"
	var v = 0
	match val:#Fix
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
	
	#number
	cursor = (cursor + v + 5) % 5
	
	for n in range(0,5):
			items[n].highlight(n==cursor)
	


func execute_cursor(slot = 0):#
	#sets movenext for currently selected mon...
	
	#i forgot back lol
	if cursor == 4:#just hardcode the number for now idk
		btlhead.restate(btlhead.OPTIONS)
	else:
		btlhead.slots[slot].set_movenext(
			"switch",
			cursor,
			cursor#target
		)
	
		#if done with all mons on your side...
		btlhead.exec_turn()



#used in above and in eg loading party for swap menu
func check_mon(mon, temp = -1):
	#check if mom can be sent out
	#return false if empty slot, fainted, if temp matched (will not match -1 obvs)
	if !mon: return false #if null
	if mon.health <= 0: return false
	if mon.temp == temp: return false#does 'in' work for single values?
	#isn't implemented yet, but if some flag for empty slot is matched, eg species == -1, return false
	#muh nandummy
	#if you made it this far you're lino
	return true
