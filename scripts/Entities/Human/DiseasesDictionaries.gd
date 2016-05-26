extends Node

var invisibility = {
	"NAME": "NAME_INVISIBILITY",
	"DESCRIPTION": "DESC_INVISIBILITY",
	"CAUSE": "CAUSE_INVISIBILITY",
	"TREATMENT": "TREATMENT_INVISIBILITY",
	"COST": 1400,
}

var bloaty_head = {
	"NAME": "NAME_BLOATY",
	"DESCRIPTION": "DESC_BLOATY",
	"CAUSE": "CAUSE_BLOATY",
	"TREATMENT": "TREATMENT_BLOATY",
	"COST": 850,
}

var slack_tongue = {
	"NAME": "NAME_TONGUE",
	"DESCRIPTION": "DESC_TONGUE",
	"CAUSE": "CAUSE_TONGUE",
	"TREATMENT": "TREATMENT_TONGUE",
	"COST": 900,
}

var sleeping_illness = {
	"NAME": "NAME_SLEEPING",
	"DESCRIPTION": "DESC_SLEEPING",
	"CAUSE": "CAUSE_SLEEPING",
	"TREATMENT": "TREATMENT_SLEEPING",
	"COST": 750,
}

var uncommon_cold = {
	"NAME": "NAME_UNCOMMON",
	"DESCRIPTION": "DESC_UNCOMMON",
	"CAUSE": "CAUSE_UNCOMMON",
	"TREATMENT": "TREATMENT_UNCOMMON",
	"COST": 300,
}

var TV_personalities = {
	"NAME": "NAME_TV",
	"DESCRIPTION": "DESC_TV",
	"CAUSE": "CAUSE_TV",
	"TREATMENT": "TREATMENT_TV",
	"COST": 800,
}

var heaped_piles = {
	"NAME": "NAME_HEAPED",
	"DESCRIPTION": "DESC_HEAPED",
	"CAUSE": "CAUSE_HEAPED",
	"TREATMENT": "TREATMENT_HEAPED",
	"COST": 400,
}

var the_squits = {
	"NAME": "NAME_SQUITS",
	"DESCRIPTION": "DESC_SQUITS",
	"CAUSE": "CAUSE_SQUITS",
	"TREATMENT": "TREATMENT_SQUITS",
	"COST": 400,
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