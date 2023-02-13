extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MyClass = preload("Main.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	# movimenta as colunas para colisão
	print(MyClass)
	self.position.x -= 2 * MyClass.x
	$columns.position.x -= 2 * MyClass.x
	if ($columns.position.x) < -550:
		$columns.position.x = rand_range(0, 350) - 50
		$columns.position.y = rand_range(0, 400) - 200
