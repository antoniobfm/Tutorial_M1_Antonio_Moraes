extends Node2D

export(String) var title

func _ready():
	$task/title.text = title
