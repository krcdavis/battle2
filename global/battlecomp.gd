extends Node
class_name battlecomp
#TEMP
#the object which is stored in a slot[]. effectively extends a mon object with extra in-battle data


var mon #pointer to the mon
var model #pointer to the loaded model
var slot: int#needed for when the slots are resorted, eg speedqueue

#moves queued to be used in next turn- moveid, moveslot, target/targetfield
var movenext_id = ""#identifier of move data
var movenext_idx: int#0-3
var movenext_target: int#temp, or not
const movenext_targets = []#this actually works... probably

var ownr = ""

#stat boost/drop levels, clamped to n/-n as you please... define n somewhere
var satk: int
var sdef: int
var sspd: int
var sacc: int
var sdod: int#dodge aka evasion
#var sskl: int
#var sluk: int

#define n here for now- stat cap
const scap = 6

#calulated stats w/ mon stats plus above
var catk: int
var cdef: int
var cspd: int
#var cskl: int
#var cluk: int#bawk bawk bgawk

#redo as a dictionary so you can basically put whatever in it instead of hardcoding
#volatile statuses and such- 0 if not
var sleepturns: int
var confuseturns: int
var freezeturns: int
var badpoisonturns: int



func load_into_battle():#for now just
	catk = mon.attack
	cdef = mon.defense
	cspd = mon.speed
	#slot = s

func set_movenext(id, idx, target):#one-target version?
	#lmao verification/sanchecking
	movenext_id = id
	movenext_idx = idx
	movenext_target = target

func dec_pp(n):#also pressure
	pass

func set_pp(n):
	pass

func get_pp(n):
	pass

func heal_pp(n):#set to max
	pass

func get_health():
	return mon.health

func set_health(h):
	#pass to mon.set
	pass

#these can also be used to heal by amt/perc by sending in negative values
func damage_by_amt(amtd):
	mon.damage_by_amt(amtd)

func damage_by_perc(percd):
	pass#pass to mon

func get_hp():
	return mon.hp

