extends Node
#go ahead and give this both data dict and getter functs

#dt.tg

const moves = {#not const lol... or is it?
	"nutshot":{
		dt.tgname: "Nutshot",
		dt.tgtype: dt.tgsolid,
		dt.tgdamage: 15,
		dt.tgup: 10,
		dt.tgacc: 95,
	},
	"pollendust":{
		dt.tgname:"Pollen Dust",
		dt.tgtype: dt.tgsunny,
		dt.tgdamage:10,
		dt.tgup:15,
		},
	"leafscatter":{
		dt.tgname:"Leaf Scatter",
		dt.tgtype: dt.tgsunny,
		dt.tgdamage:15,
		dt.tgup:10,
		},
	"jetstream":{
		dt.tgname:"Jet Stream",
		dt.tgtype: dt.tgstormy,
		dt.tgdamage:15,
		dt.tgup:10,
		},
	"spacelazer":{
		dt.tgname:"Space Lazer",
		dt.tgtype: dt.tgspace,
		dt.tgdamage:15,
		dt.tgup:10,
		},
	"highkick":{
		dt.tgname:"High Kick",
		dt.tgtype: dt.tgsimple,
		dt.tgdamage:15,
		dt.tgup:10,
		},
	"dropkick":{
		dt.tgname:"Drop Kick",
		dt.tgtype: dt.tgsimple,
		dt.tgdamage:15,
		dt.tgup:10,
		},
	"chomp":{
		dt.tgname:"Chomp",
		dt.tgtype: dt.tgsimple,
		dt.tgdamage:15,
		dt.tgup:15,
		},
	"bonk":{
		dt.tgname:"Bonk",
		dt.tgtype: dt.tgsimple,
		dt.tgdamage:10,
		dt.tgup:15,
		},
	"claw":{
		dt.tgname:"Claw",
		dt.tgtype: dt.tgsimple,
		dt.tgdamage:10,
		dt.tgup:10,
		},
	"coldone":{
		dt.tgname:"Cold One",
		dt.tgtype: dt.tgstormy,
		dt.tgdamage:12,
		dt.tgup:10,
		},
	"hotspit":{
		dt.tgname:"Hot Spit",
		dt.tgtype: dt.tgsunny,
		dt.tgdamage:12,
		dt.tgup:10,
		},
	"sprinkle":{
		dt.tgname:"Sprinkle",
		dt.tgtype: dt.tgsilly,
		dt.tgdamage:10,
		dt.tgup:10,
		},
	"splash":{
		dt.tgname:"Splash",
		dt.tgtype: dt.tgstormy,
		dt.tgdamage:10,
		dt.tgup:10,
		},
	"swiftsmack":{
		dt.tgname:"Swift Smack",
		dt.tgtype: dt.tgsimple,
		dt.tgdamage:10,
		dt.tgup:10,
		dt.tgpriority:dt.SQ2,
		},
	"rollover":{
		dt.tgname:"Roll Over",
		dt.tgtype: dt.tgsimple,
		dt.tgdamage:-1,
		dt.tgup:10,
		dt.tgeffect:"rollover",
		},
	"splashzone":{
		dt.tgname:"Splash Zone",
		dt.tgtype: dt.tgstormy,
		dt.tgdamage:20,
		dt.tgup:10,
		},
	"superburst":{
		dt.tgname:"Super Burst",
		dt.tgtype: dt.tgsimple,
		dt.tgdamage:20,
		dt.tgup:10,
		},
	"flail":{
		dt.tgname:"Flailure",
		dt.tgtype: dt.tgsimple,
		dt.tgdamage:5,
		dt.tgup:10,
		dt.tgeffect:"flail-print-recoil",#handles both string printing and special recoil calc
		},
	
	"stunseed":{
		dt.tgname:"Stun Seed",
		dt.tgtype: dt.tgsunny,
		dt.tgdamage:-1,
		dt.tgup:10,
		dt.tgeffect:"stun",
		dt.tgacc:90,
		},
	"flybite":{
		dt.tgname:"Flybite",
		dt.tgtype: dt.tgbugs,
		dt.tgdamage:10,
		dt.tgup:10,
		},
	"brainwave":{
		dt.tgname:"Brainwave",
		dt.tgtype: dt.tgspecial,
		dt.tgdamage:10,
		dt.tgup:10,
		},
	
	
	#pseudomoves used for trainer actions etc
	"switch":
		{dt.tgpriority:99},
		#will use target to define mon to be switched to. basically targetting a
		#party member instead of a field slot
	"run":
		{dt.tgpriority:99},
	"item":
		{dt.tgpriority:99},
	
	
	"error":{
		dt.tgname:"error",
	}
	
}

#func ready: for all, .make_read_only()
func _ready():
	for move in moves:
		moves[move].make_read_only()#YES

func move_isvalid(id):
	#very simple
	var test = moves.get(id, moves["error"])
	return test[dt.tgname] != "error"

#the getter functions
func move_getmove(id):
	return moves.get(id, moves["error"])

#simple ones, but with some default/error checking
#should just use getmove
func move_getname(id):
	var ayy = moves.get(id, moves["error"])
	return ayy.get(dt.tgname, "error")

func move_gettype(id):#simple if error?
	var ayy = moves.get(id, moves["error"])
	return ayy.get(dt.tgtype, "simple")

func move_getprio(id):
	var ayy = moves.get(id, moves["error"])
	return ayy.get(dt.tgpriority, dt.SQ0)


#complex ones. effect handling probably handled in battle scripts
func move_getdmg(id):
	#values like -1 or 0 might indicate special damage calcs, non-damaging move, etc
	#these details will probably be handled in the battle script, probably
	return moves[id].get(dt.tgdamage, 7)


#if exists...
func move_geteffect(id):
	#if move .has(tgeffect): .has(tgeffchance)
	pass
