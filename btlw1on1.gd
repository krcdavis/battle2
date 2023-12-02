extends "battlescripts/battle_controller.gd"
#or head or whatever has process in it
#basis > utils > controller > here

var selecting = false#set to true if another wild mon arrives/new slot added, never set back
var fieldtype = 0
var returncamera
var wmon

#var head

var wtemp = ["flyder",10]

# Called when the node enters the scene tree for the first time.
func _ready():
	#will be loaded on map load and left there until time to battle
	#hiding things is done in deactivate() so the battlescene can be checked on its own
	
	#lel
	#should maybe be renamed since 'head' is the main... head
	$battlehud/optcontrol.btlhead = self
	$battlehud/movecontrol.btlhead = self
	$battlehud/partycontrol.btlhead = self
	btlhead = self#lol
	
	#slots.append( mon-in-battle.new() ) twice- loop?
	slots.append( battlecomp.new() )
	slots.append( battlecomp.new() )
	#? labels append, positions append
	points = [$point0,$point1]
	labels = [$battlehud/btl_left_big,$battlehud/btl_left_big2]
	#$battlehud.whatever
	
	#connect("thingdone",donething())#is in basis
	#self.thingdone.connect(donething)
	
	#restate(OPTIONS)
	
	#newbattle()

#all process stuff is done in controller, probably

func deactivate():#called on startup to hide field
	self.visible = false
	$battlehud.visible = false
	$battlehud/optcontrol.visible = false
	#$battlefield_placeholder.visible = false
	labelsoff()
	mode = "stopped"

func newbattle(passin = ["0",0]):#pass in wild mon's info... or have it prepared elsewhere
	#if pass-in is defined, set wtemp, else use default/last in wtemp
	mode = "battle"
	g.mode = "battle"
	$battlehud/optcontrol.visible = false
	
	labelsoff()
	
	#fix this for godot 4 pls
	#returncamera = get_viewport().get_camera()
	$Camera3D.make_current()
	
	self.visible = true
	$battlehud.visible = true
	#load battlefield model... or for now
	$battlefield_placeholder.visible = true
	
	var n = 0
	for mon in party.party:
		mon.temp = n
		n += 1
	
	var p = check_party()
	if !p: pass
	
	#load wild mon, await self.thingdonw
	#properly check this pls
	if passin[0] !="0": wtemp = passin
	load_wild(1)
	await self.thingdone
	
	load_yourside(0, p)
	await self.thingdone
	
	#load first live party member, yield
	
	#move cam into base position after load-yours anim
	#what do?
	turnhead()

#stuff that shares some functionality w/ double wild, etc
func load_wild(slot):
	wmon = Monster.new()
	wmon.setup_species_level(wtemp[0],wtemp[1])
	
	slots[slot].mon = wmon
	slots[slot].load_into_battle()
	
	loadmon_model(slot)
	
	#cam tween
	#maintext.textplay(str("Wild %s appeared!" % slots[slot].mon.nname))
	$battlehud/textbox.textplay(str("Wild %s appeared!" % slots[slot].mon.nname))
	await $battlehud/textbox.textover
	#await camtween and text
	
	labels[slot].settext(slots[slot].mon.nname)
	labels[slot].sethp(slots[slot].mon.hp,slots[slot].mon.health)
	
	#print(slots[slot].mon.health)
	
	#set temp default nextmove?
	#set slot owner to wild?
	
	#if small pp set for wild in debug menu, do that
	
	#$hud/debug1.loadpp(slots[1].mon)
	
	emit_signal("thingdone")

func load_yourside(slot, mon):
	
	slots[slot].mon = mon
	slots[slot].load_into_battle()
	
	loadmon_model(slot)
	
	#cam tween
	#maintext.textplay(str("Go, %s!" % slots[slot].mon.nname))
	#await camtween and text
	$battlehud/textbox.textplay(str("Go, %s!" % slots[slot].mon.nname))
	await $battlehud/textbox.textover
	
	labels[slot].settext(slots[slot].mon.nname)
	labels[slot].sethp(slots[slot].mon.hp,slots[slot].mon.health)
	
	emit_signal("thingdone")

func turnhead():
	labelson()
	$battlehud/textbox.textplay("What do?",true)
	#reset main menu cursor only here- restate could be from hitting 'back'
	
	#check party, check current mon
	if !check_party():
		#wipeout, cleanup
		wipeout()
		await self.thingdone
		cleanup()
	
	else: if !check_mon(slots[0].mon):
		$battlehud/textbox.textplay("Please switch to another Monstar",true)
	
	else: if !check_mon(slots[1].mon):
		#winner, cleanup
		win()
		await self.thingdone
		cleanup()
	
	#else:
	#textplay what do?
	#options.vis = true
	#options cursor vis = true
	restate(OPTIONS)#this does at least some of it

func restate(newstate):
	match newstate:
		OPTIONS:
			$battlehud/optcontrol.visible = true
			$battlehud/movecontrol.visible = false
			$battlehud/partycontrol.visible = false
			activemenu = $battlehud/optcontrol
			$battlehud/optcontrol.update_cursor()
			#hide other stuff
			#summon textstring
			$battlehud/textbox.textplay("What do?",true)
			mode = OPTIONS
		MOVES:
			$battlehud/optcontrol.visible = false
			$battlehud/movecontrol.visible = true
			activemenu = $battlehud/movecontrol
			$battlehud/movecontrol.mupdate(0)
			mode = MOVES
		PARTYM:
			pass
			$battlehud/optcontrol.visible = false
			$battlehud/movecontrol.visible = false
			$battlehud/partycontrol.visible = true
			activemenu = $battlehud/partycontrol
			$battlehud/partycontrol.pupdate(0)
			mode = PARTYM
		
		
		
		
		INTURN:
			mode = INTURN
			$battlehud/optcontrol.visible = false
			$battlehud/movecontrol.visible = false
			$battlehud/partycontrol.visible = false
		
		

func exec_turn():
	restate(INTURN)
	#hide menus
	$battlehud/movecontrol.visible = false
	$battlehud/optcontrol.visible = false
	
	#opponent ai selects move(s).. for now
	#for this version, make it... slightly less useless!!
	slots[1].set_movenext("bonk",0,0)
	
	for s in speedqueues: s.clear()
	specialqueue.clear()
	
	#for moncomp in slots: append depending on move prio
	#attempting to run is highest priority, switching, etc
	#add pseudo-moves to move data for actions like these (:
	for moncomp in slots:
		if moncomp.mon:#not null
			var pp = g.lmoves.move_getprio(moncomp.movenext_id)
			#sure hope the values are correct
			if pp == 99:# specialqueue, else
				specialqueue.append(moncomp)
			else:
				speedqueues[pp].append(moncomp)
			#a few special cases, like the windup and actual move of focus punch, pursuit...
	
	for s in speedqueues:
		if s.size() > 1:
			s.sort_custom(speedTie)
			
	#specialqueue is not sorted because trainers don't have speed.
	
	#ready
	
	#for s in speedq: for m in s: 
	#many many things
	#but first check the "special" queue for trainer catioons- items, switching, run etc
	for mon in specialqueue:
		
		match mon.movenext_id:
			"run":
				pass
			"switch":
				pass
				swap_mon(0, party.party[mon.movenext_target] )
				await self.thingdone
	for s in speedqueues:
		
		for mon in s:
			#if mon still alive pls
			#calcdmg takes attacker mon object and target slot, lol
			if mon.get_health() > 0:
				
				var m = g.lmoves.move_getname(mon.movenext_id)
				$battlehud/textbox.textplay(str("%s used %s!" % [mon.mon.nname,m]))
				await $battlehud/textbox.textover
				
				if mon.movenext_id != "rollover":
				
					var dmg = calcdamage(mon, mon.movenext_target)
					slots[mon.movenext_target].damage_by_amt(dmg)
					#update hp bar...
					labels[mon.movenext_target].sethp(slots[mon.movenext_target].mon.hp,slots[mon.movenext_target].mon.health)
				
				
	
	#once all done, try another turn
	turnhead()
	

func cleanup():
	
	$battlehud.visible = false#for some reason this needs to be done
	self.visible = false
	
	# models .queue_free()
	removemon(0)
	removemon(1)
	
	mode = "no"
	
	head.endbattle()


func opp_ai_select_move():
	pass
	#very beytah

func donething():#exists to exist
	pass


func labelson():
	for l in labels:
		l.visible = true

func labelsoff():
	for l in labels:
		l.visible = false
