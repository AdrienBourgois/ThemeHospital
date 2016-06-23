extends Node

var map_ressource = preload("res://scripts/Map/MapRessources.gd").new()

var invisibility = {
	"NAME": "NAME_INVISIBILITY",
	"DESCRIPTION": "DESC_INVISIBILITY",
	"CAUSE": "CAUSE_INVISIBILITY",
	"TREATMENT": "TREATMENT_INVISIBILITY",
	"TREATMENT_ROOM": map_ressource.pharmacy["NAME"],
	"TREATMENT_EFFICIENCY": 0/100,
	"PERCENT": 100,
	"DEFAULT_COST": 1400,
	"NEW_COST": 1400,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
}

var bloaty_head = {
	"NAME": "NAME_BLOATY",
	"DESCRIPTION": "DESC_BLOATY",
	"CAUSE": "CAUSE_BLOATY",
	"TREATMENT": "TREATMENT_BLOATY",
	"TREATMENT_ROOM": map_ressource.inflation["NAME"],
	"TREATMENT_EFFICIENCY": 0/100,
	"PERCENT": 100,
	"DEFAULT_COST": 850,
	"NEW_COST": 850,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
}

var slack_tongue = {
	"NAME": "NAME_TONGUE",
	"DESCRIPTION": "DESC_TONGUE",
	"CAUSE": "CAUSE_TONGUE",
	"TREATMENT": "TREATMENT_TONGUE",
	"TREATMENT_ROOM": map_ressource.tongue["NAME"],
	"TREATMENT_EFFICIENCY": 0/100,
	"PERCENT": 100,
	"DEFAULT_COST": 900,
	"NEW_COST": 900,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
}

var sleeping_illness = {
	"NAME": "NAME_SLEEPING",
	"DESCRIPTION": "DESC_SLEEPING",
	"CAUSE": "CAUSE_SLEEPING",
	"TREATMENT": "TREATMENT_SLEEPING",
	"TREATMENT_ROOM": map_ressource.pharmacy["NAME"],
	"TREATMENT_EFFICIENCY": 0/100,
	"PERCENT": 100,
	"DEFAULT_COST": 750,
	"NEW_COST": 750,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
}

var uncommon_cold = {
	"NAME": "NAME_UNCOMMON",
	"DESCRIPTION": "DESC_UNCOMMON",
	"CAUSE": "CAUSE_UNCOMMON",
	"TREATMENT": "TREATMENT_UNCOMMON",
	"TREATMENT_ROOM": map_ressource.pharmacy["NAME"],
	"TREATMENT_EFFICIENCY": 0/100,
	"PERCENT": 100,
	"DEFAULT_COST": 300,
	"NEW_COST": 300,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
}

var TV_personalities = {
	"NAME": "NAME_TV",
	"DESCRIPTION": "DESC_TV",
	"CAUSE": "CAUSE_TV",
	"TREATMENT": "TREATMENT_TV",
	"TREATMENT_ROOM": map_ressource.psychiatric["NAME"],
	"TREATMENT_EFFICIENCY": 0/100,
	"PERCENT": 100,
	"DEFAULT_COST": 800,
	"NEW_COST": 800,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
}

var heaped_piles = {
	"NAME": "NAME_HEAPED",
	"DESCRIPTION": "DESC_HEAPED",
	"CAUSE": "CAUSE_HEAPED",
	"TREATMENT": "TREATMENT_HEAPED",
	"TREATMENT_ROOM": map_ressource.pharmacy["NAME"],
	"TREATMENT_EFFICIENCY": 0/100,
	"PERCENT": 100,
	"DEFAULT_COST": 400,
	"NEW_COST": 400,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
}

var the_squits = {
	"NAME": "NAME_SQUITS",
	"DESCRIPTION": "DESC_SQUITS",
	"CAUSE": "CAUSE_SQUITS",
	"TREATMENT": "TREATMENT_SQUITS",
	"TREATMENT_ROOM": map_ressource.pharmacy["NAME"],
	"TREATMENT_EFFICIENCY": 0/100,
	"PERCENT": 100,
	"DEFAULT_COST": 400,
	"NEW_COST": 400,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
}

var gp_diag = {
	"NAME": "NAME_GP_DIAGNOSIS",
	"PERCENT": 100,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
	"DEFAULT_COST": 100,
	"NEW_COST": 100
}

var general_diag = {
	"NAME": "NAME_GENERAL_DIAG",
	"PERCENT": 100,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
	"DEFAULT_COST": 150,
	"NEW_COST": 150
}

var diag_ward = {
	"NAME": "NAME_WARD",
	"PERCENT": 100,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
	"DEFAULT_COST": 100,
	"NEW_COST": 100
}

var diag_psychiatric = {
	"NAME": "NAME_PSYCHIATRIC",
	"PERCENT": 100,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
	"DEFAULT_COST": 200,
	"NEW_COST": 200
}

var diag_cardio = {
	"NAME": "NAME_CARDIO",
	"PERCENT": 100,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
	"DEFAULT_COST": 150,
	"NEW_COST": 150
}

var list_diseases = {
	"SQUITS": the_squits,
	"HEAPED": heaped_piles,
	"UNCOMMON": uncommon_cold,
	"INVISIBILITY": invisibility,
	"SLEEPING": sleeping_illness,
	"TONGUE": slack_tongue,
	"BLOATY": bloaty_head,
	"TV": TV_personalities,
	"DIAG_GP": gp_diag,
	"DIAG_GENERAL": general_diag,
	"DIAG_WARD": diag_ward,
	"DIAG_CARDIO": diag_cardio,
	"DIAG_PSYCHIATRIC": diag_psychiatric
}

var cure_at_pharmacy = [
	the_squits,
	heaped_piles,
	uncommon_cold,
	invisibility,
	sleeping_illness
]

var cure_at_clinics = [
	slack_tongue,
	bloaty_head
]

var cure_at_psychiatric = [
	TV_personalities
]