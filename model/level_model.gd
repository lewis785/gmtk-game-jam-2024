class_name LevelModel
extends Resource

## Base resource for different tower types.
## This will be handy for placement of towers, can potentially add more data to
## these too

## The name of the level.
@export var name:String

## The scene containing the scene of the level
@export var scene:PackedScene

## Level Thumbnail
@export var img: Texture

## Starting Gold
@export var start_gold: int

## Crystal Health
@export var health: int
