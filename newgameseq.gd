extends CanvasLayer

#tag names- these will be global'd
const nme = "name"
const txt = "text"
const typ = "type"
const anm = "anim"
const trg = "target"
const vars = "vars"

var head
signal scriptdone

var mode = "notparty"

const party1 = [["magnut",12,-1],["flyder",12,-1],["lileaf",12,-1]]
const party2 = [["slowcone",15,-1],["flyder",15,-1],["riffraft",15,-1]]
const party3 = [["magnut",7,-1],["shleep",7,-1],["eggry",7,-1]]

var popts = []
var pcurs = 0
var yn = []
var yncurs = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#set labels
	yn = [$yn/yes,$yn/no]
	popts = [$p1,$p2,$p3]
	
	$yn/yes/Label.text = "Yes"
	$yn/no/Label.text = "No"
	
	var st = ""
	for mon in party1:
		st += g.lspecies.getname(mon[0]) + " Lv. " + str(mon[1]) + "\n"
	$p1/Label.text = st
	
	st = ""
	for mon in party2:
		st += g.lspecies.getname(mon[0]) + " Lv. " + str(mon[1]) + "\n"
	$p2/Label.text = st
	
	st = ""
	for mon in party3:
		st += g.lspecies.getname(mon[0]) + " Lv. " + str(mon[1]) + "\n"
	$p3/Label.text = st
	
	g.runscript(ngscript001)
	#await g.wholescriptdone, switch to party-selecting mode
	await g.scriptdone
	print("aa")
	#show parties, mode = party
	#wait a sec before accepting input again...
	await get_tree().create_timer(0.07).timeout
	$controls.visible = false
	showp()
	mode = "party"
	update_cursors(0)


#this will be used for party-selection menu mode
#really need a base menu type plus active-menu pointer... anyway
func _process(_delta):
	if mode == "party" or mode == "yesno":#or yesno, pass -1 or 1
		pass
		if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left"):
			update_cursors(-1)
		if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_right"):
			update_cursors(1)
		else: if Input.is_action_just_pressed("ui_accept"):#needs a delay...
			if mode == "party":
				pass#switch to yes/no, update textbox
				g.hud.txb.textplay("use this party?",true)
				mode = "yesno"
				update_cursors(0)
				$yn.visible = true
			else:#yes/no
				pass
				#match yncurs first pls
				if yncurs == 1:#no
					$yn.visible = false
					mode = "party"
					g.hud.txb.textplay("Choose a party",true)
				else:
					chooseparty()
		

func chooseparty():
					mode = "m"
					#match pcurs, set partyin, run setup-party
					match pcurs:
						0:
							pass
							party.setup_party(party1)
						1:
							pass
							party.setup_party(party2)
						_:
							pass
							party.setup_party(party3)
					pass
					#and run ngscript002
					g.hud.txb.textplay("All set up! Now... On to the world of Monstars!")
					await g.hud.txb.textover
					head.activ_player()
					g.mode = "firstload"
					head.changemap(["formica_map_1_test_2", "point0"])

const ngscript001 = [
		{typ: txt, txt: "Welcome to the world of Monstars Game!"},
		{typ: txt, txt: "In this game you will befriend the creatures called Monstars, raise them, battle them, and maybe find out about a deep secret of the world..."},
		{typ: txt, txt: "Well, that's for the final game. For now, choose a starting party!", "clear":true}#,#still need to emit textover if true...
		#show
	
]

const ngscript002 = [
		{typ: txt, txt: "E"},
		{typ: txt, txt: "E"},
		]

func showp(v=true):
	#unhide party options... or hide
	for pp in popts:
		pp.visible = v

func update_cursors(val = 0):
	#match mode
	if mode == "party":
		pcurs = (pcurs +val +3)%3
		for opt in range(0,3):
			popts[opt].highlight( opt == pcurs )
	if mode == "yesno":
		yncurs = (yncurs +val +2)%2
		for opt in range(0,2):
			yn[opt].highlight( opt == yncurs )
