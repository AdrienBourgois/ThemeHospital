extends Node

var invisibility = {
	"NAME": "NAME_INVISIBILITY",
	"DESCRIPTION": "DESC_INVISIBILITY",
	"CAUSE": "CAUSE_INVISIBILITY",
	"TREATMENT": "TREATMENT_INVISIBILITY",
	"FOUND": true,
	"TREATMENT_FOUND": false,
	"TREATMENT_EFFICIENCY": 0/100,
	"COST": 1400,
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
	"FOUND": false,
	"TREATMENT_FOUND": false,
	"TREATMENT_EFFICIENCY": 0/100,
	"COST": 850,
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
	"FOUND": false,
	"TREATMENT_FOUND": false,
	"TREATMENT_EFFICIENCY": 0/100,
	"COST": 900,
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
	"FOUND": false,
	"TREATMENT_FOUND": false,
	"TREATMENT_EFFICIENCY": 0/100,
	"COST": 750,
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
	"FOUND": false,
	"TREATMENT_FOUND": false,
	"TREATMENT_EFFICIENCY": 0/100,
	"COST": 300,
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
	"FOUND": false,
	"TREATMENT_FOUND": false,
	"TREATMENT_EFFICIENCY": 0/100,
	"COST": 800,
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
	"FOUND": false,
	"TREATMENT_FOUND": false,
	"TREATMENT_EFFICIENCY": 0/100,
	"COST": 400,
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
	"FOUND": true,
	"TREATMENT_FOUND": false,
	"TREATMENT_EFFICIENCY": 0/100,
	"COST": 400,
	"MONEY_EARNED": 0,
	"RECOVERIES": 0,
	"FATALITIES": 0,
	"TURNED_AWAY": 0,
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
}

var cure_at_pharmacy = {
	"SQUITS": the_squits,
	"HEAPED": heaped_piles,
	"UNCOMMON": uncommon_cold,
	"INVISIBILITY": invisibility,
	"SLEEPING": sleeping_illness,
}

var cure_at_clinics = {
	"TONGUE": slack_tongue,
	"BLOATY": bloaty_head,
}

var cure_at_psychiatric = {
	"TV": TV_personalities,
}