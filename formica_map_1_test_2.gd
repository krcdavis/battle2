extends Node3D

var head

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.name == "you":
		head.changemap(["forest_grass", "point1"])
	
	pass # Replace with function body.

func loadingritual():
	pass
	#if firstload, play some tutorial text
	#welcome to monstar town!
	#head to the pillars up ahead to enter the forest and fight some wild mons!
	#to talk to people, walk into their area! to talk to them again, move out of the area and in again.
	#to heal, walk into the area of the guy by the forest gate.
	
	#i think it needs to check head for that info... g.mode == "firstload" (:
	if g.mode == "firstload":
		print("it worked")
		g.runscript(ngscript002)
		await g.scriptdone
		g.mode = "you"
	else: if g.mode == "wipeout":
		healparty()

#yay
const ngscript002 = [
		{g.typ: g.txt, g.txt: "Welcome to Monstar Town!"},
		{g.typ: g.txt, g.txt: "Head to the pillars up ahead to enter the forest, where you can battle wild Monstars and level up your team."},
		{g.typ: g.txt, g.txt: "To talk to people, walk into their area. To talk again walk out then in again"},
		{g.typ: g.txt, g.txt: "To heal your team, walk into the area near the pillars."},
		{g.typ: g.txt, g.txt: "Have fun!"}
		]

const guyscript1 = [
	{g.typ: g.txt, g.txt: "To train your weaker Monstars, you can have a stronger one do most of the damage then switch in another to get the EXP."},
	{g.typ: g.txt, g.txt: "That's right, EXP isn't distributed between participants... I sure hope that's fixed eventually."}
]

const guyscript2 = [
	{g.typ: g.txt, g.txt: "You can't switch your party around so a different Monstar can come out first..."},
	{g.typ: g.txt, g.txt: "Man, I sure hope that's fixed soon."}
]

func _on_area_3d_body_entered2(body):
	pass # Replace with function body.
	if body.name == "you":
		g.mode = "pause"
		g.runscript(guyscript1)
		await g.scriptdone
		g.mode = "you"
		

func _on_area_3d_body_entered3(body):
	pass # Replace with function body.
	if body.name == "you":
		g.mode = "pause"
		g.runscript(guyscript2)
		await g.scriptdone
		g.mode = "you"


func _on_area_3d_body_enteredheal(body):
	if body.name == "you":
		healparty()

const healscript = [
	{g.typ: g.txt, g.txt: "Healed your team!"}
]

func healparty():
		g.mode = "pause"
		#party heal
		for mon in party.party:
			mon.heal_to_max()
		g.runscript(healscript)
		await g.scriptdone
		g.mode = "you"
