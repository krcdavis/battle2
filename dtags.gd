extends Node
#some of these can be moved to a generalized thing somewhere


#const tgspecies = "species"
const tgname = "name"
const tgmodel = "model"
const tgtype = "type"
const tgbase = "base"#d on what?
const tbmoves = "basemoves"
const tgmoves = "moves"#things

const tgdamage = "damage"
const tgup = "up"
const tgacc = "acc"
const tgpriority = "priority"
const tgeffect = "effect"
const tgeffchance = "effectchance"
const tgtarget = "target"

#brain idea
const tghp = "hp"
const tgatk = "attack"
const tgdef = "defense"
const tgluck = "luck"
const tgskill = "skill"
const tgstat4 = tgluck
const tgstat5 = tgskill
const tgspeed = "speed"

#types
const tgsimple = "simple"
const tgsunny = "sunny"
const tgstormy = "stormy"
const tgspace = "space"
const tgsolid = "solid"
const tgsound = "sound"
const tgspecial = "special"
const tgspooky = "spooky"
const tgsilly = "silly"
const tgbugs = "bugs"
const tgsparkle = "sparkle"
const tgsomething = "something"

const typetags = [tgsimple, tgsunny, tgstormy, tgspace, tgsolid, tgsound, 
	tgspecial, tgspooky, tgsilly, tgsparkle, tgsomething]
const metatypetags = ["tgsimple", "tgsunny", "tgstormy", "tgspace", "tgsolid",
 "tgsound", "tgspecial", "tgspooky", "tgsilly", "tgsparkle", "tgsomething"]


const SQ7 = 0
const SQ2 = 1
const SQ0 = 2
const SQm2 = 3
const SQm3 = 4
#an array of all of these or stg?
const SQcount = 5#is also the max
