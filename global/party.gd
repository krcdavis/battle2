extends Node

#hm

var party = []#array of mon objects...
var partyin = [ ["magnut",13,-1],["riffraft",20,-1],["flyder",20,-1] ]

var wildtemp = []#a general 'header' file or stg for this

var partyloaded = false#set if loaded from file in head before menu scene is loaded idk

# Called when the node enters the scene tree for the first time.
#change this to do nothing and have head handle the saving/loading
func _ready():
	pass
	
func aaa():
	if FileAccess.file_exists("user://partysave.txt"):
		print("there it is")
		#read file then setup party
		#file.get_line()
		var file = FileAccess.open("user://partysave.txt", FileAccess.READ)
		partyin.clear()
		for n in range(0,3):
			partyin.append([file.get_line(), int(file.get_line()), -1])
		print(partyin)
		file.close()
		setup_party(partyin)
		
		
	else:
		print("there it isn't")
		#setup party then write file
		setup_party(partyin)
		var file = FileAccess.open("user://partysave.txt", FileAccess.WRITE)
		for ay in partyin:
			file.store_line(ay[0])
			file.store_line(str(ay[1]))
		file.close()
	
	
	
	

func setup_party(inn):#[[],[],[]]
	var count = 0
	for thing in inn:
		party.append(Monster.new())
		party[count].setup_species_level(thing[0],thing[1], thing[2])
		count += 1
		#set temp?
		
		#print( party[count-1].health)
		#print( g.lspecies.getstg(thing[0],dt.tgmodel) )#well now it works
	#print(party.size())
