extends Node2D

const INITIAL_MAP_PATH := "res://assets/legacy/maps/ma1.json"
const ACCOUNT_STORE_PATH := "user://accounts.json"
const LEGACY_LOGIN_BACKGROUND := "res://assets/legacy/ui/login_background.png"
const JOB_PORTRAITS := [
	{"code": "ou0", "name": "Paladino", "path": "res://assets/legacy/ui/jobs/paladin.png"},
	{"code": "ou1", "name": "Elfa", "path": "res://assets/legacy/ui/jobs/elf.png"},
	{"code": "ou2", "name": "Assassino", "path": "res://assets/legacy/ui/jobs/assassin.png"},
	{"code": "ou3", "name": "Fada", "path": "res://assets/legacy/ui/jobs/fairy.png"},
	{"code": "ou4", "name": "Sacerdote", "path": "res://assets/legacy/ui/jobs/priest.png"},
	{"code": "ou5", "name": "Domador", "path": "res://assets/legacy/ui/jobs/trainer.png"},
	{"code": "ou6", "name": "Druida", "path": "res://assets/legacy/ui/jobs/druid.png"},
]

var _ui_layer: CanvasLayer
var _world_root: Node2D
var _status_label: Label
var _accounts: Dictionary = {}
var _current_account := ""
var _selected_job := "ou0"
var _current_map: Dictionary = {}
var _loading_step := 0


func _ready() -> void:
	print("Asa New Game iniciado.")
	print("Godot project path: ", ProjectSettings.globalize_path("res://"))
	_load_accounts()
	_build_roots()
	_show_boot()


func _build_roots() -> void:
	_world_root = Node2D.new()
	_world_root.name = "WorldRoot"
	add_child(_world_root)

	_ui_layer = CanvasLayer.new()
	_ui_layer.name = "UILayer"
	add_child(_ui_layer)


func _clear_ui() -> void:
	for child in _ui_layer.get_children():
		child.queue_free()


func _clear_world() -> void:
	for child in _world_root.get_children():
		child.queue_free()


func _make_screen(title: String, subtitle: String) -> VBoxContainer:
	_clear_ui()
	_add_legacy_background()

	var shade := ColorRect.new()
	shade.name = "LegacyShade"
	shade.set_anchors_preset(Control.PRESET_FULL_RECT)
	shade.color = Color(0, 0, 0, 0.22)
	_ui_layer.add_child(shade)

	var root := VBoxContainer.new()
	root.name = "Screen"
	root.offset_left = 66
	root.offset_top = 64
	root.offset_right = 1214
	root.offset_bottom = 680
	root.add_theme_constant_override("separation", 14)
	_ui_layer.add_child(root)

	var title_label := Label.new()
	title_label.text = title
	title_label.add_theme_font_size_override("font_size", 34)
	title_label.add_theme_color_override("font_color", Color(1.0, 0.91, 0.58))
	title_label.add_theme_color_override("font_shadow_color", Color(0.1, 0.04, 0, 1))
	title_label.add_theme_constant_override("shadow_offset_x", 2)
	title_label.add_theme_constant_override("shadow_offset_y", 2)
	root.add_child(title_label)

	var subtitle_label := Label.new()
	subtitle_label.text = subtitle
	subtitle_label.add_theme_font_size_override("font_size", 18)
	subtitle_label.add_theme_color_override("font_color", Color(0.93, 0.88, 0.72))
	subtitle_label.add_theme_color_override("font_shadow_color", Color(0, 0, 0, 1))
	root.add_child(subtitle_label)

	return root


func _add_legacy_background() -> void:
	var texture := _load_texture_from_file(LEGACY_LOGIN_BACKGROUND)
	if texture == null:
		return

	var background := TextureRect.new()
	background.name = "LegacyLoginBackground"
	background.texture = texture
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	background.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	background.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	_ui_layer.add_child(background)


func _style_legacy_panel(panel: PanelContainer) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.17, 0.14, 0.08, 0.86)
	style.border_color = Color(0.78, 0.62, 0.31, 1.0)
	style.set_border_width_all(2)
	style.corner_radius_top_left = 8
	style.corner_radius_top_right = 8
	style.corner_radius_bottom_left = 8
	style.corner_radius_bottom_right = 8
	style.content_margin_left = 18
	style.content_margin_right = 18
	style.content_margin_top = 18
	style.content_margin_bottom = 18
	panel.add_theme_stylebox_override("panel", style)


func _style_legacy_button(button: Button) -> void:
	button.custom_minimum_size = Vector2(180, 38)
	button.add_theme_font_size_override("font_size", 18)
	button.add_theme_color_override("font_color", Color(1.0, 0.91, 0.55))


func _show_boot() -> void:
	_clear_world()
	var screen := _make_screen(
		"Asa New Game",
		"Fluxo base: iniciar, registrar/login, carregar, entrar no mapa inicial a1."
	)

	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(620, 260)
	_style_legacy_panel(panel)
	screen.add_child(panel)

	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 12)
	panel.add_child(box)

	var text := Label.new()
	text.text = "Reconstrucao do cliente antigo:\n\n1. usar assets reais extraidos do SWF\n2. recriar login/loading/selecao de personagem\n3. carregar mapa inicial ma1/a1\n4. trocar placeholders por sprites originais"
	text.add_theme_font_size_override("font_size", 18)
	text.add_theme_color_override("font_color", Color(0.95, 0.9, 0.74))
	box.add_child(text)

	var start_button := Button.new()
	start_button.text = "Iniciar"
	_style_legacy_button(start_button)
	start_button.pressed.connect(_show_login)
	box.add_child(start_button)


func _show_login() -> void:
	var screen := _make_screen("Entrar", "Use uma conta local de teste enquanto o servidor novo nao esta ligado ao Godot.")
	var form := _make_auth_form("Entrar", _on_login_pressed)
	screen.add_child(form)

	var register_button := Button.new()
	register_button.text = "Criar conta nova"
	_style_legacy_button(register_button)
	register_button.pressed.connect(_show_register)
	screen.add_child(register_button)


func _show_register() -> void:
	var screen := _make_screen("Registrar Conta", "Registro local mock. Depois trocamos isso pelo servidor Python/PostgreSQL.")
	var form := _make_auth_form("Registrar", _on_register_pressed)
	screen.add_child(form)

	var login_button := Button.new()
	login_button.text = "Voltar para login"
	_style_legacy_button(login_button)
	login_button.pressed.connect(_show_login)
	screen.add_child(login_button)


func _make_auth_form(button_text: String, callback: Callable) -> PanelContainer:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(440, 220)
	_style_legacy_panel(panel)

	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 10)
	panel.add_child(box)

	var user_edit := LineEdit.new()
	user_edit.name = "UserEdit"
	user_edit.placeholder_text = "usuario"
	box.add_child(user_edit)

	var pass_edit := LineEdit.new()
	pass_edit.name = "PassEdit"
	pass_edit.placeholder_text = "senha"
	pass_edit.secret = true
	box.add_child(pass_edit)

	_status_label = Label.new()
	_status_label.text = ""
	box.add_child(_status_label)

	var action := Button.new()
	action.text = button_text
	_style_legacy_button(action)
	action.pressed.connect(func() -> void:
		callback.call(user_edit.text.strip_edges(), pass_edit.text)
	)
	box.add_child(action)

	return panel


func _on_register_pressed(username: String, password: String) -> void:
	if username.length() < 3:
		_set_status("Usuario precisa ter pelo menos 3 caracteres.")
		return
	if password.length() < 3:
		_set_status("Senha precisa ter pelo menos 3 caracteres.")
		return
	if _accounts.has(username):
		_set_status("Essa conta local ja existe.")
		return

	_accounts[username] = {
		"password": password,
		"created_at": Time.get_datetime_string_from_system(),
		"last_map": "a1"
	}
	_save_accounts()
	_current_account = username
	_show_role_select()


func _on_login_pressed(username: String, password: String) -> void:
	if not _accounts.has(username):
		_set_status("Conta local nao encontrada. Crie uma conta primeiro.")
		return
	if str(_accounts[username].get("password", "")) != password:
		_set_status("Senha incorreta.")
		return

	_current_account = username
	_show_role_select()


func _set_status(message: String) -> void:
	if _status_label:
		_status_label.text = message


func _show_role_select() -> void:
	var screen := _make_screen("Selecionar Personagem", "Primeira versao da tela de personagem usando retratos reais extraidos dos assets antigos.")

	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(1120, 470)
	_style_legacy_panel(panel)
	screen.add_child(panel)

	var root := VBoxContainer.new()
	root.add_theme_constant_override("separation", 12)
	panel.add_child(root)

	var grid := GridContainer.new()
	grid.columns = 7
	grid.add_theme_constant_override("h_separation", 10)
	grid.add_theme_constant_override("v_separation", 10)
	root.add_child(grid)

	for job in JOB_PORTRAITS:
		grid.add_child(_make_job_card(job))

	var footer := HBoxContainer.new()
	footer.add_theme_constant_override("separation", 14)
	root.add_child(footer)

	var create_button := Button.new()
	create_button.text = "Entrar com personagem"
	_style_legacy_button(create_button)
	create_button.pressed.connect(func() -> void:
		_accounts[_current_account]["last_job"] = _selected_job
		_save_accounts()
		_show_loading("Personagem selecionado. Carregando Aldeia Tyria...")
	)
	footer.add_child(create_button)

	var back_button := Button.new()
	back_button.text = "Voltar"
	_style_legacy_button(back_button)
	back_button.pressed.connect(_show_login)
	footer.add_child(back_button)


func _make_job_card(job: Dictionary) -> PanelContainer:
	var panel := PanelContainer.new()
	panel.custom_minimum_size = Vector2(145, 380)
	_style_legacy_panel(panel)

	var box := VBoxContainer.new()
	box.alignment = BoxContainer.ALIGNMENT_CENTER
	box.add_theme_constant_override("separation", 6)
	panel.add_child(box)

	var portrait := TextureRect.new()
	portrait.custom_minimum_size = Vector2(120, 270)
	portrait.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	portrait.texture = _load_texture_from_file(str(job["path"]))
	box.add_child(portrait)

	var name_label := Label.new()
	name_label.text = str(job["name"])
	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	name_label.add_theme_font_size_override("font_size", 17)
	name_label.add_theme_color_override("font_color", Color(1.0, 0.88, 0.45))
	box.add_child(name_label)

	var choose := Button.new()
	choose.text = "Escolher"
	_style_legacy_button(choose)
	choose.custom_minimum_size = Vector2(115, 32)
	choose.pressed.connect(func() -> void:
		_selected_job = str(job["code"])
		_show_role_select()
	)
	box.add_child(choose)

	if str(job["code"]) == _selected_job:
		var selected := Label.new()
		selected.text = "Selecionado"
		selected.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		selected.add_theme_color_override("font_color", Color(0.35, 1.0, 0.35))
		box.add_child(selected)

	return panel


func _load_texture_from_file(res_path: String) -> Texture2D:
	var image := Image.new()
	var image_path := ProjectSettings.globalize_path(res_path)
	if image.load(image_path) != OK:
		return null
	return ImageTexture.create_from_image(image)


func _show_loading(message: String) -> void:
	_clear_world()
	var screen := _make_screen("Carregando", message)
	_status_label = Label.new()
	_status_label.text = "Preparando recursos..."
	_status_label.add_theme_font_size_override("font_size", 20)
	screen.add_child(_status_label)

	_loading_step = 0
	var timer := Timer.new()
	timer.name = "LoadingTimer"
	timer.wait_time = 0.35
	timer.one_shot = false
	timer.timeout.connect(_advance_loading)
	_ui_layer.add_child(timer)
	timer.start()


func _advance_loading() -> void:
	_loading_step += 1
	var messages := [
		"Lendo conta local...",
		"Carregando configuracao do mapa a1...",
		"Montando marcadores do mundo...",
		"Entrando em Aldeia Tyria..."
	]

	if _loading_step <= messages.size():
		_status_label.text = messages[_loading_step - 1]
		return

	var timer := _ui_layer.get_node_or_null("LoadingTimer")
	if timer:
		timer.queue_free()
	_enter_initial_map()


func _enter_initial_map() -> void:
	var text := FileAccess.get_file_as_string(INITIAL_MAP_PATH)
	if text.is_empty():
		_show_error("Nao consegui ler " + INITIAL_MAP_PATH)
		return

	var parsed = JSON.parse_string(text)
	if typeof(parsed) != TYPE_DICTIONARY:
		_show_error("Mapa inicial invalido: " + INITIAL_MAP_PATH)
		return

	_current_map = parsed
	_draw_map_debug()
	_show_hud()


func _draw_map_debug() -> void:
	_clear_ui()
	_clear_world()

	var bg := ColorRect.new()
	bg.color = Color(0.045, 0.055, 0.05)
	bg.size = Vector2(1280, 720)
	_world_root.add_child(bg)

	var map_name := str(_current_map.get("name", "Mapa sem nome"))
	var map_id := str(_current_map.get("id", "a1"))
	var width := int(_current_map.get("width", 0))
	var height := int(_current_map.get("height", 0))
	var scale := 0.13
	var origin := Vector2(80, 100)

	var map_frame := ColorRect.new()
	map_frame.position = origin
	map_frame.size = Vector2(width * 32, height * 32) * scale
	map_frame.color = Color(0.12, 0.16, 0.13, 1.0)
	_world_root.add_child(map_frame)

	var layers: Array = _current_map.get("layers", [])
	if not layers.is_empty():
		var first_layer: Dictionary = layers[0]
		var content: Array = first_layer.get("content", [])
		var limit = min(content.size(), 120)
		for i in range(limit):
			var tile: Dictionary = content[i]
			var tile_rect := ColorRect.new()
			tile_rect.position = origin + Vector2(float(tile.get("px", 0)), float(tile.get("py", 0))) * scale
			tile_rect.size = Vector2(float(tile.get("w", 32)), float(tile.get("h", 32))) * scale
			tile_rect.color = Color(0.18 + float(i % 5) * 0.015, 0.24, 0.18, 0.9)
			_world_root.add_child(tile_rect)

	_add_marker_group(_current_map.get("entryArray", []), origin, scale, Color(0.25, 0.75, 1.0), "E")
	_add_marker_group(_current_map.get("exitArray", []), origin, scale, Color(1.0, 0.72, 0.22), "S")
	_add_marker_group(_current_map.get("npcList", []), origin, scale, Color(0.8, 0.35, 1.0), "N")

	var player := ColorRect.new()
	player.name = "PlayerPlaceholder"
	player.position = origin + Vector2(1120, 2080) * scale
	player.size = Vector2(18, 26)
	player.color = Color(0.9, 0.95, 1.0)
	_world_root.add_child(player)

	print("Mapa inicial carregado: ", map_id, " / ", map_name)


func _add_marker_group(items, origin: Vector2, scale: float, color: Color, prefix: String) -> void:
	if typeof(items) != TYPE_ARRAY:
		return

	for i in range(items.size()):
		var item = items[i]
		if typeof(item) != TYPE_DICTIONARY:
			continue

		var px := float(item.get("px", item.get("x", 0)))
		var py := float(item.get("py", item.get("y", 0)))
		var marker := Label.new()
		marker.text = prefix + str(i + 1)
		marker.position = origin + Vector2(px, py) * scale
		marker.add_theme_color_override("font_color", color)
		marker.add_theme_font_size_override("font_size", 16)
		_world_root.add_child(marker)


func _show_hud() -> void:
	_clear_ui()
	var hud := PanelContainer.new()
	hud.offset_left = 20
	hud.offset_top = 20
	hud.offset_right = 520
	hud.offset_bottom = 142
	_ui_layer.add_child(hud)

	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 4)
	hud.add_child(box)

	var title := Label.new()
	title.text = "Conta: %s | Mapa: %s (%s)" % [
		_current_account,
		str(_current_map.get("name", "Aldeia Tyria")),
		str(_current_map.get("id", "a1"))
	]
	title.add_theme_font_size_override("font_size", 18)
	box.add_child(title)

	var help := Label.new()
	help.text = "Debug inicial: E=entrada, S=saida, N=NPC. Proximo passo: assets reais e loading visual."
	box.add_child(help)

	var logout := Button.new()
	logout.text = "Sair para login"
	logout.pressed.connect(_show_login)
	box.add_child(logout)


func _show_error(message: String) -> void:
	var screen := _make_screen("Erro", message)
	var back := Button.new()
	back.text = "Voltar"
	back.pressed.connect(_show_login)
	screen.add_child(back)


func _load_accounts() -> void:
	if not FileAccess.file_exists(ACCOUNT_STORE_PATH):
		_accounts = {}
		return

	var text := FileAccess.get_file_as_string(ACCOUNT_STORE_PATH)
	var parsed = JSON.parse_string(text)
	_accounts = parsed if typeof(parsed) == TYPE_DICTIONARY else {}


func _save_accounts() -> void:
	var file := FileAccess.open(ACCOUNT_STORE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(_accounts, "\t"))
