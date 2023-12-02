extends "battle_basis.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#lol
func speedTie(mona, monb):
	if mona.cspd != monb.cspd:
		return mona.cspd > monb.cspd
	else: #speedtie
		return g.randi() < g.randi()#lmao

#unused whoops
func execmove(userslot):
	#temporary simple version
	#var target = slots[ slots[userslot].movenext_target ]
	var moveid = slots[userslot].movenext_id
	var movedat = g.lmoves.move_getmove(moveid)
	
	#check movedat for special effects
	var dmg = movedat.get(dt.tgdamage, 7)
	#nondamaging or special calc moves should have 0 or -1 dmg, not undefined
	if dmg == -1:#nondamaging effect move, probably
		pass
		#probably will move this somewhere else to avoid clogging these
		#functions up as more effects are added
		
	else:
		pass
	
	#calcdamage(user attack, user attack stat, target defense, types)
	#target.damage_by_amt(calcdamage)#implement this pls
	
	pass
	
	

func calcdamage(atkr,targslot):
	#var atkr = slots[atkslot]
	var targr = slots[ targslot ]
	
	if check_mon(atkr.mon) and check_mon(targr.mon):
		#begin
		var d = g.lmoves.move_getdmg(atkr.movenext_id)
		#var at = g.lmoves.move_gettype(atkr.movenext_id)
		#var tt = g.lspecies.getstg(targr.mon.species, dt.tgtype)
		
		#var rel = data.gettyperel(at,tt)#not yet implemented
		var rel = 1
		
		var cdmg = d * rel * atkr.catk / targr.cdef
		
		return cdmg


func loadmon_model(slot):
	#slots...
	var temp# = load(g.datapath + g.mtscnpath + g.lspecies.getstg(slots[slot].mon.species_id, dt.tgmodel) + ".tscn")#lol
	#lololol
	if true:#FileAccess.file_exists(g.datapath + g.mtscnpath + g.lspecies.getstg(slots[slot].mon.species_id, dt.tgmodel) + ".tscn"):
		temp = load(g.datapath + g.mtscnpath + g.lspecies.getstg(slots[slot].mon.species_id, dt.tgmodel) + ".tscn")#lol
	else:
		temp = load("res://cyoob.tscn")
		print(slots[slot].mon.species_id)
	var temp2 = temp.instantiate()
	temp2.name = "model"#yes, still necessary
	points[slot].add_child(temp2)
	

func removemon(slot):
	var lol = get_node_or_null("point"+str(slot)+"/model")
	if lol:
		get_node_or_null("point"+str(slot)+"/model").name = "delet"
		get_node_or_null("point"+str(slot)+"/delet").queue_free()
	
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

func swap_mon(slot, mon):
	#unload current mon's model
	removemon(slot)
	#and load new
	slots[slot].mon = mon
	slots[slot].load_into_battle()
	
	loadmon_model(slot)
	$battlehud/textbox.textplay(str("Go, %s!" % slots[slot].mon.nname))
	await $battlehud/textbox.textover
	
	labels[slot].settext(slots[slot].mon.nname)
	labels[slot].sethp(slots[slot].mon.hp,slots[slot].mon.health)
	
	emit_signal("thingdone")

func check_party(temp = -1):#start = 0 ?...
	for mon in party.party: #will eventually be a set of 4/6 with empty slots which need to be falsed; for now just faint status
		#check_mon(mon)
		if check_mon(mon, temp): return mon#rets first available mon for starting battle
	return null

func win():
	#for now, award one level to the mon currently out (in slot 0)
	print('win')
	slots[0].mon.addlevel()
	$battlehud/textbox.textplay(str("%s gained a level for securing the win!" % slots[0].mon.nname))
	await $battlehud/textbox.textover
	$battlehud/textbox.textplay("you've winned!!")
	await $battlehud/textbox.textover
	emit_signal("thingdone")

func wipeout():
	$battlehud/textbox.textplay("You've lost your last useable Monstar...")
	await $battlehud/textbox.textover
	$battlehud/textbox.textplay("... you wiped out!!")
	await $battlehud/textbox.textover
	emit_signal("thingdone")#before or after?
	head.wipeout()#should work now

func cleanup():
	pass
