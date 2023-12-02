extends Node
#accessible as g.whatever


#tag names...
const nme = "name"
const txt = "text"
const typ = "type"
const anm = "anim"
const trg = "target"
const vars = "vars"


const project = "monstars"

var lspecies
var species
var lmoves
var moves
#type rels, ...

var rng

var datapath = "res:/"#/data/default"
const mtscnpath = "/montscns/"

var n = .4#stat something blend value

var mode = "yosu"
var wild_map = false#whether or not the current map has wild encounters enabled

var hud#set in head?...
#? have a function to pass textplay right to textbox so you can just type g.textplay(whatever)
#well in some ways that's just scriptplay
#var head#lol
signal scrdone
signal scriptdone

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	
	#load data/project/species, moves, etc
	#loldatapath
	
	lspecies = load(datapath + "/species.gd").new()#ok
	species = lspecies.species#????
	
	#print(lspecies.getname("lileaf"))#this is... ok i guess
	
	lmoves = load(datapath + "/moves.gd").new()
	moves = lmoves.moves
	
	#print(moves["nutshot"])
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#keep a reference to current hud/textbox, normal overworld one and battlehud one...

func runscript(scr):
	#scr should be an array of dicts. check this somehow
	pass
	for line in scr:
		scri(line)
		await self.scrdone
	emit_signal("scriptdone")

func scri(line):
	pass
	#verify line is a script dict, then
	match line["type"]:
		"anim":
			pass
		"text":
			#if has "name", set name label (which doesn't exist yet), else hide name label
			#if has disable_enter_clearing or whatever, pass that in else false (default)
			hud.txb.textplay(line.get("text","line missing ):"),line.get("clear",false))
			#await and emit
			await hud.txb.textover
			emit_signal("scrdone")
		
