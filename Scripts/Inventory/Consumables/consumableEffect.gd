extends Resource
class_name consumableEffect

enum consumableEffectEnum
{
	thirst,
	food,
	health
}

@export var effect : consumableEffectEnum
@export var potency : float
