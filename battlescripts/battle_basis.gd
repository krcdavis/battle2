extends Node

#declare the variables here (:

var btlhead
var head#hmm

var slots = []#appended to in btl head
var points = []
var labels = []

#keep this synced with the list in dtags pls
#const SQ7 = 0
#const SQ2 = 1
#const SQ0 = 2
#const SQm2 = 3
#const SQm3 = 4

var squeue7 = []
var squeue2 = []
var squeue0 = []
var squeuem2 = []
var squeuem3 = []

var speedqueues = [squeue7, squeue2, squeue0, squeuem2, squeuem3]

var specialqueue = []

var activemenu

var turnhead_faint = false#?
signal thingdone#??

#modes
const OPTIONS = "options"
const MOVES = "moves"
const BAGM = "baggu"
const PARTYM = "partym"
const INTURN = "inturn"

var mode = "aaaaaaa"





