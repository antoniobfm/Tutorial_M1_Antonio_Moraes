extends Node2D

var tasks = []
var placeholder_tasks = ["Isso daqui é para concluir a primeira tarefa", "Sim", "uau"]

# Função que deleta todos os nodes filhos do node passado
static func delete_children(node):
	# Loopa pelos filhos do node passado
	for n in node.get_children():
		# Remove o filho da vez
		node.remove_child(n)
		
		# Limpa ele da queue do loop para que não loope por onde não existe filho
		n.queue_free()

# Atualiza a lista de tarefas
func update_list():
	# Chama a função que deleta os nodes filhos do Container Vertical
	delete_children($task_list)
	
	# Loopa pela lista de tasks
	for x in tasks:
		# Cria uma nova task
		var task_scene = load("res://task.tscn").instance()
		
		# Atualiza propriedades do novo node
		task_scene.title = x
		
		# Adiciona ele como filho do Container Vertical
		$task_list.add_child(task_scene)

# Salva a nova task para memoria
func add_task():
	# Adiciona o texto do input de texto para o final da lista de tarefas
	tasks.append($task_input.text)
	
	# Limpa o input de texto
	$task_input.text = ""
	
	# Chama a função que atualiza a lista
	update_list()

# Quando o botão para adicionar task for acionado
func _on_add_button_pressed():
	# Se o input de texto tiver conteudo
	if $task_input.text.length() >= 1:
		# Chame a função que adiciona task para memoria
		add_task()

# Essa função é disparada quando um evento é detectado
func _input(event):
	# Se o foco estiver no input, uma tecla de accept for apertada e o input de texto tiver conteudo
	if event.is_action_pressed("ui_accept") and $task_input.has_focus() and $task_input.text.length() >= 1:
		# Chame a função que adiciona task para memoria
		add_task()

func _ready():
	# Loopa pela lista de tasks
	for x in placeholder_tasks:
		# Cria uma nova task
		var task_scene = load("res://task.tscn").instance()
		
		# Atualiza propriedades da nova task
		task_scene.title = x
		
		# Adiciona ela como filho do Container Vertical
		$task_list.add_child(task_scene)
