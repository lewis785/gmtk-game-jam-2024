class_name SpawnModel
extends Resource

## Base resource for different tower types.
## This will be handy for placement of towers, can potentially add more data to
## these too

## Waves
@export var waves: Array[WaveModel]

## Time between waves
@export var wave_delay: float

## Intro Time before first wave
@export var intro_time: float
