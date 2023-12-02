extends Node3D

const music_track = "res://Eterna Forest (Resampled) loopable.mp3"

var head
const wilddata = [["flyder",8],["magnut",10],["lileaf",10],["slowcone",9],["shleep",9]]

func _ready():
	pass # Replace with function body.
	#instantiate btlw1on1 under head, if not already loaded.
	#this function should be in head so it can set itself as btl.head
	#irrelevant for now tho


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.name == "you":
		head.changemap(["formica_map_1_test_2", "point1"])
