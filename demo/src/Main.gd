extends Node2D

const INKCPP := preload("res://addons/godot-inkcpp/bin/gdinkcpp.gdns")
var inkcpp

func _ready():
	inkcpp = INKCPP.new()
	inkcpp.path = "data/the_intercept.ink.json"

	inkcpp.play_story()
