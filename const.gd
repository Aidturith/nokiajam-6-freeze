extends Node

const DEBUG = true

enum STAGES {EGG, BABY, CHILD, TEEN, ADULT, FINITO}
const STAGE_LABELS = {
	STAGES.EGG: 'egg',
	STAGES.BABY: 'baby',
	STAGES.CHILD: 'child',
	STAGES.TEEN: 'teen',
	STAGES.ADULT: 'adult',
}

const HAPPY_MAX = 4
const HUNGRY_MAX = 4
const STAMINA_MAX = 100
