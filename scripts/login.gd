extends Control

var email_input: LineEdit
var password_input: LineEdit
var login_button: Button
var status_label: Label

var card: Panel
var title_label: Label
var subtitle_label: Label
var email_label: Label
var password_label: Label
var create_account_button: Button


func _ready() -> void:

	print("================================")
	print("🔐 LOGIN SCREEN STARTED")
	print("================================")

	print(
		"AUTH FILE:",
		ProjectSettings.globalize_path(
			"user://auth_session.cfg"
		)
	)

	print(
		"AUTH FILE EXISTS:",
		FileAccess.file_exists(
			ProjectSettings.globalize_path(
				"user://auth_session.cfg"
			)
		)
	)

	# =====================================================
	# CREATE LOGIN UI
	# =====================================================

	create_login_ui()

	# Show loading state while checking saved session.
	visible = true

	if card:
		card.visible = false

	# =====================================================
	# LOADING LABEL
	# =====================================================

	var loading_label := Label.new()

	loading_label.name = "LoadingLabel"
	loading_label.text = "LOADING..."

	loading_label.set_anchors_and_offsets_preset(
		Control.PRESET_CENTER
	)

	loading_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	loading_label.add_theme_font_size_override(
		"font_size",
		16
	)

	loading_label.add_theme_color_override(
		"font_color",
		Color("#19E66F")
	)

	add_child(loading_label)

	# =====================================================
	# SUPABASE LOGIN SIGNALS
	# =====================================================

	if not SupabaseAuth.login_success.is_connected(
		_on_login_success
	):
		SupabaseAuth.login_success.connect(
			_on_login_success
		)

	if not SupabaseAuth.login_failed.is_connected(
		_on_login_failed
	):
		SupabaseAuth.login_failed.connect(
			_on_login_failed
	)

	# =====================================================
	# SESSION RESTORE SIGNALS
	# =====================================================

	if not SupabaseAuth.session_restored.is_connected(
		_on_session_restored
	):
		SupabaseAuth.session_restored.connect(
			_on_session_restored
		)

	if not SupabaseAuth.session_restore_failed.is_connected(
		_on_session_restore_failed
	):
		SupabaseAuth.session_restore_failed.connect(
			_on_session_restore_failed
		)

	# =====================================================
	# LOGOUT SIGNAL
	# =====================================================

	if not SupabaseAuth.logged_out.is_connected(
		_on_logged_out
	):
		SupabaseAuth.logged_out.connect(
			_on_logged_out
		)

	# =====================================================
	# CHECK SAVED LOGIN
	# =====================================================

	print("================================")
	print("🔐 CHECKING EXISTING SESSION")
	print("================================")

	SupabaseAuth.restore_session()

func create_login_ui() -> void:

	# =====================================================
	# BACKGROUND
	# =====================================================

	var background := ColorRect.new()

	background.name = "Background"
	background.color = Color("#070A0F")

	background.set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)

	background.mouse_filter = Control.MOUSE_FILTER_IGNORE

	add_child(background)


	# =====================================================
	# FIXED LOGIN CONTAINER
	# =====================================================

	var center := Control.new()

	center.name = "LoginCenter"

	center.set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)

	center.mouse_filter = Control.MOUSE_FILTER_IGNORE

	add_child(center)


	# =====================================================
	# MAIN CARD
	# =====================================================

	card = Panel.new()

	card.name = "LoginCard"

	card.size = Vector2(360, 470)
	card.custom_minimum_size = Vector2(360, 470)

	card.mouse_filter = Control.MOUSE_FILTER_IGNORE


	# -----------------------------------------------------
	# CARD STYLE
	# -----------------------------------------------------

	var card_style := StyleBoxFlat.new()

	card_style.bg_color = Color("#111822")
	card_style.border_color = Color("#202A38")

	card_style.set_border_width_all(1)

	card_style.corner_radius_top_left = 18
	card_style.corner_radius_top_right = 18
	card_style.corner_radius_bottom_left = 18
	card_style.corner_radius_bottom_right = 18

	card_style.content_margin_left = 25
	card_style.content_margin_right = 25
	card_style.content_margin_top = 25
	card_style.content_margin_bottom = 25

	card.add_theme_stylebox_override(
		"panel",
		card_style
	)

	center.add_child(card)


	# =====================================================
	# FIXED POSITION
	# =====================================================

	# IMPORTANT:
	# Do NOT center the card.
	# The iPhone keyboard can change the viewport height.
	# A centered Control would then move.

	var viewport_size := get_viewport_rect().size

	var card_x := (viewport_size.x - card.size.x) / 2.0

	var card_y := 60.0

	card.position = Vector2(
		card_x,
		card_y
	)


	# =====================================================
	# TITLE
	# =====================================================

	title_label = Label.new()

	title_label.text = "DON'T TAP RED"

	title_label.position = Vector2(0, 28)
	title_label.size = Vector2(360, 42)

	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	title_label.add_theme_font_size_override(
		"font_size",
		28
	)

	title_label.add_theme_color_override(
		"font_color",
		Color.WHITE
	)

	card.add_child(title_label)


	# =====================================================
	# SUBTITLE
	# =====================================================

	subtitle_label = Label.new()

	subtitle_label.text = "WELCOME BACK"

	subtitle_label.position = Vector2(0, 72)
	subtitle_label.size = Vector2(360, 30)

	subtitle_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	subtitle_label.add_theme_font_size_override(
		"font_size",
		13
	)

	subtitle_label.add_theme_color_override(
		"font_color",
		Color("#788190")
	)

	card.add_child(subtitle_label)


	# =====================================================
	# LOGIN HEADING
	# =====================================================

	var heading := Label.new()

	heading.text = "LOGIN"

	heading.position = Vector2(0, 115)
	heading.size = Vector2(360, 35)

	heading.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	heading.add_theme_font_size_override(
		"font_size",
		22
	)

	heading.add_theme_color_override(
		"font_color",
		Color.WHITE
	)

	card.add_child(heading)


	# =====================================================
	# EMAIL LABEL
	# =====================================================

	email_label = Label.new()

	email_label.text = "EMAIL"

	email_label.position = Vector2(25, 165)
	email_label.size = Vector2(310, 20)

	email_label.add_theme_font_size_override(
		"font_size",
		11
	)

	email_label.add_theme_color_override(
		"font_color",
		Color("#788190")
	)

	card.add_child(email_label)


	# =====================================================
	# EMAIL INPUT
	# =====================================================

	email_input = LineEdit.new()

	email_input.name = "EmailInput"

	email_input.placeholder_text = "you@example.com"

	email_input.position = Vector2(25, 188)
	email_input.size = Vector2(310, 48)

	email_input.focus_mode = Control.FOCUS_CLICK

	email_input.add_theme_font_size_override(
		"font_size",
		15
	)

	email_input.add_theme_color_override(
		"font_color",
		Color.WHITE
	)

	email_input.add_theme_color_override(
		"font_placeholder_color",
		Color("#596372")
	)

	email_input.clear_button_enabled = true

	_apply_input_style(email_input)

	email_input.text_submitted.connect(
		_on_email_submitted
	)

	card.add_child(email_input)


	# =====================================================
	# PASSWORD LABEL
	# =====================================================

	password_label = Label.new()

	password_label.text = "PASSWORD"

	password_label.position = Vector2(25, 248)
	password_label.size = Vector2(310, 20)

	password_label.add_theme_font_size_override(
		"font_size",
		11
	)

	password_label.add_theme_color_override(
		"font_color",
		Color("#788190")
	)

	card.add_child(password_label)


	# =====================================================
	# PASSWORD INPUT
	# =====================================================

	password_input = LineEdit.new()

	password_input.name = "PasswordInput"

	password_input.placeholder_text = "••••••••"

	password_input.position = Vector2(25, 271)
	password_input.size = Vector2(310, 48)

	password_input.secret = true

	password_input.focus_mode = Control.FOCUS_CLICK

	password_input.add_theme_font_size_override(
		"font_size",
		15
	)

	password_input.add_theme_color_override(
		"font_color",
		Color.WHITE
	)

	password_input.add_theme_color_override(
		"font_placeholder_color",
		Color("#596372")
	)

	_apply_input_style(password_input)

	password_input.text_submitted.connect(
		_on_password_submitted
	)

	card.add_child(password_input)


	# =====================================================
	# LOGIN BUTTON
	# =====================================================

	login_button = Button.new()

	login_button.name = "LoginButton"

	login_button.text = "LOGIN"

	login_button.position = Vector2(25, 335)
	login_button.size = Vector2(310, 52)

	login_button.add_theme_font_size_override(
		"font_size",
		16
	)

	login_button.add_theme_color_override(
		"font_color",
		Color("#06100A")
	)

	login_button.add_theme_color_override(
		"font_hover_color",
		Color("#06100A")
	)

	login_button.add_theme_color_override(
		"font_pressed_color",
		Color("#06100A")
	)

	_apply_button_style(login_button)

	login_button.pressed.connect(
		_on_login_pressed
	)

	card.add_child(login_button)


	# =====================================================
	# STATUS
	# =====================================================

	status_label = Label.new()

	status_label.name = "StatusLabel"

	status_label.text = ""

	status_label.position = Vector2(25, 395)
	status_label.size = Vector2(310, 35)

	status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	status_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

	status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

	status_label.add_theme_font_size_override(
		"font_size",
		12
	)

	status_label.add_theme_color_override(
		"font_color",
		Color("#FF3152")
	)

	card.add_child(status_label)


	# =====================================================
	# CREATE ACCOUNT
	# =====================================================

	create_account_button = Button.new()

	create_account_button.name = "CreateAccountButton"

	create_account_button.text = "DON'T HAVE AN ACCOUNT?  CREATE ACCOUNT"

	create_account_button.position = Vector2(15, 438)
	create_account_button.size = Vector2(330, 25)

	create_account_button.flat = true

	create_account_button.focus_mode = Control.FOCUS_NONE

	create_account_button.add_theme_font_size_override(
		"font_size",
		9
	)

	create_account_button.add_theme_color_override(
		"font_color",
		Color("#596372")
	)

	create_account_button.add_theme_color_override(
		"font_hover_color",
		Color("#19E66F")
	)

	create_account_button.add_theme_color_override(
		"font_pressed_color",
		Color("#19E66F")
	)

	create_account_button.pressed.connect(
		_on_create_account_pressed
	)

	card.add_child(create_account_button)


	# =====================================================
	# KEYBOARD
	# =====================================================
	#
	# Inputs use FOCUS_CLICK.
	# The iPhone keyboard opens only when the user taps
	# an input field.
	#
	# No manual keyboard-positioning code is used.

# =========================================================
# SESSION RESTORED
# =========================================================

func _on_session_restored(logged_in_user_id: String) -> void:

	print("================================")
	print("🚀 AUTO LOGIN SUCCESS")
	print("USER ID:", logged_in_user_id)
	print("================================")

	_hide_keyboard()

	get_tree().change_scene_to_file(
		"res://main.tscn"
	)

# =========================================================
# SESSION RESTORE FAILED
# =========================================================

func _on_session_restore_failed() -> void:

	print("================================")
	print("🔐 NO VALID SESSION")
	print("SHOWING LOGIN")
	print("================================")

	visible = true

	if card:
		card.visible = true
	var loading_label := get_node_or_null("LoadingLabel")
	if loading_label:
		loading_label.queue_free()

	if login_button:
		login_button.disabled = false

	if email_input:
		email_input.editable = true

	if password_input:
		password_input.editable = true

	if email_input:
		email_input.release_focus()

	if password_input:
		password_input.release_focus()

# =========================================================
# LOGGED OUT
# =========================================================

func _on_logged_out() -> void:

	print("================================")
	print("🚪 LOGOUT SIGNAL RECEIVED")
	print("RETURNING TO LOGIN")
	print("================================")

	_hide_keyboard()

	get_tree().change_scene_to_file(
		"res://login.tscn"
	)

# =========================================================
# INPUT STYLE
# =========================================================

func _apply_input_style(input: LineEdit) -> void:

	var normal := StyleBoxFlat.new()

	normal.bg_color = Color("#070A0F")
	normal.border_color = Color("#27313D")

	normal.set_border_width_all(1)

	normal.corner_radius_top_left = 10
	normal.corner_radius_top_right = 10
	normal.corner_radius_bottom_left = 10
	normal.corner_radius_bottom_right = 10

	normal.content_margin_left = 14
	normal.content_margin_right = 14


	var focus := normal.duplicate()

	focus.border_color = Color("#19E66F")

	focus.set_border_width_all(1)


	input.add_theme_stylebox_override(
		"normal",
		normal
	)

	input.add_theme_stylebox_override(
		"focus",
		focus
	)


# =========================================================
# BUTTON STYLE
# =========================================================

func _apply_button_style(button: Button) -> void:

	var normal := StyleBoxFlat.new()

	normal.bg_color = Color("#19E66F")

	normal.corner_radius_top_left = 10
	normal.corner_radius_top_right = 10
	normal.corner_radius_bottom_left = 10
	normal.corner_radius_bottom_right = 10


	var hover := normal.duplicate()

	hover.bg_color = Color("#24F17A")


	var pressed := normal.duplicate()

	pressed.bg_color = Color("#13C95D")


	var disabled := normal.duplicate()

	disabled.bg_color = Color("#31543F")


	button.add_theme_stylebox_override(
		"normal",
		normal
	)

	button.add_theme_stylebox_override(
		"hover",
		hover
	)

	button.add_theme_stylebox_override(
		"pressed",
		pressed
	)

	button.add_theme_stylebox_override(
		"disabled",
		disabled
	)


# =========================================================
# LOGIN
# =========================================================

func _on_login_pressed() -> void:

	var email := email_input.text.strip_edges()
	var password := password_input.text


	if email.is_empty():

		_show_error(
			"Please enter your email."
		)

		email_input.grab_focus()

		return


	if not email.contains("@") or not email.contains("."):

		_show_error(
			"Please enter a valid email."
		)

		email_input.grab_focus()

		return


	if password.is_empty():

		_show_error(
			"Please enter your password."
		)

		password_input.grab_focus()

		return


	if password.length() < 6:

		_show_error(
			"Password must be at least 6 characters."
		)

		password_input.grab_focus()

		return


	print("================================")
	print("🔐 APP LOGIN")
	print("EMAIL:", email)
	print("================================")


	_hide_keyboard()


	status_label.add_theme_color_override(
		"font_color",
		Color("#19E66F")
	)

	status_label.text = "LOGGING IN..."

	login_button.disabled = true

	email_input.editable = false
	password_input.editable = false


	SupabaseAuth.login(
		email,
		password
	)


# =========================================================
# EMAIL SUBMITTED
# =========================================================

func _on_email_submitted(_text: String) -> void:

	password_input.grab_focus()


# =========================================================
# PASSWORD SUBMITTED
# =========================================================

func _on_password_submitted(_text: String) -> void:

	_on_login_pressed()


# =========================================================
# ERROR
# =========================================================

func _show_error(message: String) -> void:

	status_label.add_theme_color_override(
		"font_color",
		Color("#FF3152")
	)

	status_label.text = message


# =========================================================
# HIDE KEYBOARD
# =========================================================

func _hide_keyboard() -> void:

	if email_input:
		email_input.release_focus()

	if password_input:
		password_input.release_focus()

	DisplayServer.virtual_keyboard_hide()


# =========================================================
# LOGIN SUCCESS
# =========================================================

func _on_login_success(logged_in_user_id: String) -> void:

	print("================================")
	print("🎮 APP LOGIN SUCCESS")
	print("USER ID:", logged_in_user_id)
	print("================================")

	_hide_keyboard()

	status_label.add_theme_color_override(
		"font_color",
		Color("#19E66F")
	)

	status_label.text = "LOGIN SUCCESS!"

	await get_tree().create_timer(
		0.4
	).timeout

	get_tree().change_scene_to_file(
		"res://main.tscn"
	)

# =========================================================
# LOGIN FAILED
# =========================================================

func _on_login_failed(message: String) -> void:

	print("================================")
	print("❌ APP LOGIN FAILED")
	print("MESSAGE:", message)
	print("================================")

	status_label.add_theme_color_override(
		"font_color",
		Color("#FF3152")
	)

	status_label.text = message

	login_button.disabled = false

	email_input.editable = true
	password_input.editable = true

	# Do NOT automatically reopen the iPhone keyboard.
	email_input.release_focus()
	password_input.release_focus()

# =========================================================
# CREATE ACCOUNT
# =========================================================

func _on_create_account_pressed() -> void:

	print("================================")
	print("🌐 OPENING CREATE ACCOUNT")
	print("================================")

	# Close iPhone keyboard
	_hide_keyboard()

	# Small delay so iOS finishes closing keyboard
	await get_tree().create_timer(0.25).timeout

	var signup_url := "https://donttapred-web.vercel.app/signup"

	print("🔗 SIGNUP URL:")
	print(signup_url)

	var error := OS.shell_open(signup_url)

	if error != OK:

		print("❌ COULD NOT OPEN WEBSITE")
		print("ERROR:", error)

	else:

		print("✅ WEBSITE OPENED")

# =========================================================
# DEEP LINK
# =========================================================

func _on_deeplink_deeplink_received(url) -> void:

	print("================================")
	print("🔥 DEEPLINK RECEIVED")

	var link: String = url.get_link_url()

	print("🔗 URL:", link)

	print("================================")
