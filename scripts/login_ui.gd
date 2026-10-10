extends Control

var email_input: LineEdit
var password_input: LineEdit
var username_input: LineEdit

var login_button: Button
var signup_button: Button
var back_button: Button

var status_label: Label
var subtitle_label: Label

var supabase_auth: Node

var signup_mode: bool = false


func _ready() -> void:

	supabase_auth = get_parent().get_node("SupabaseAuth")

	create_login_ui()

	supabase_auth.login_success.connect(
		_on_login_success
	)

	supabase_auth.login_failed.connect(
		_on_login_failed
	)

	supabase_auth.signup_success.connect(
		_on_signup_success
	)

	supabase_auth.signup_failed.connect(
		_on_signup_failed
	)


# =========================================================
# CREATE LOGIN UI
# =========================================================

func create_login_ui() -> void:

	# =====================================================
	# BACKGROUND
	# =====================================================

	var background := ColorRect.new()

	background.color = Color("#070A0F")

	background.set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)

	add_child(background)


	# =====================================================
	# TITLE
	# =====================================================

	var title := Label.new()

	title.text = "DON'T TAP RED"

	title.position = Vector2(0, 80)
	title.size = Vector2(360, 50)

	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	title.add_theme_font_size_override(
		"font_size",
		28
	)

	title.add_theme_color_override(
		"font_color",
		Color.WHITE
	)

	add_child(title)


	# =====================================================
	# SUBTITLE
	# =====================================================

	subtitle_label = Label.new()

	subtitle_label.text = "WELCOME BACK"

	subtitle_label.position = Vector2(0, 130)
	subtitle_label.size = Vector2(360, 40)

	subtitle_label.horizontal_alignment = (
		HORIZONTAL_ALIGNMENT_CENTER
	)

	subtitle_label.add_theme_font_size_override(
		"font_size",
		16
	)

	subtitle_label.add_theme_color_override(
		"font_color",
		Color("#788190")
	)

	add_child(subtitle_label)


	# =====================================================
	# USERNAME
	# =====================================================

	username_input = LineEdit.new()

	username_input.placeholder_text = "USERNAME"

	username_input.position = Vector2(30, 200)
	username_input.size = Vector2(300, 52)

	username_input.add_theme_font_size_override(
		"font_size",
		16
	)

	username_input.visible = false

	add_child(username_input)


	# =====================================================
	# EMAIL
	# =====================================================

	email_input = LineEdit.new()

	email_input.placeholder_text = "EMAIL"

	email_input.position = Vector2(30, 220)
	email_input.size = Vector2(300, 52)

	email_input.add_theme_font_size_override(
		"font_size",
		16
	)

	add_child(email_input)


	# =====================================================
	# PASSWORD
	# =====================================================

	password_input = LineEdit.new()

	password_input.placeholder_text = "PASSWORD"

	password_input.position = Vector2(30, 290)
	password_input.size = Vector2(300, 52)

	password_input.secret = true

	password_input.add_theme_font_size_override(
		"font_size",
		16
	)

	add_child(password_input)


	# =====================================================
	# LOGIN BUTTON
	# =====================================================

	login_button = Button.new()

	login_button.text = "LOGIN"

	login_button.position = Vector2(30, 365)
	login_button.size = Vector2(300, 55)

	login_button.add_theme_font_size_override(
		"font_size",
		18
	)

	login_button.pressed.connect(
		_on_login_pressed
	)

	add_child(login_button)


	# =====================================================
	# CREATE ACCOUNT BUTTON
	# =====================================================

	signup_button = Button.new()

	signup_button.text = "CREATE ACCOUNT"

	signup_button.position = Vector2(30, 435)
	signup_button.size = Vector2(300, 50)

	signup_button.add_theme_font_size_override(
		"font_size",
		16
	)

	signup_button.pressed.connect(
		_on_signup_pressed
	)

	add_child(signup_button)


	# =====================================================
	# BACK BUTTON
	# =====================================================

	back_button = Button.new()

	back_button.text = "← BACK TO LOGIN"

	back_button.position = Vector2(30, 435)
	back_button.size = Vector2(300, 50)

	back_button.add_theme_font_size_override(
		"font_size",
		16
	)

	back_button.pressed.connect(
		_on_back_to_login_pressed
	)

	back_button.visible = false

	add_child(back_button)


	# =====================================================
	# STATUS
	# =====================================================

	status_label = Label.new()

	status_label.text = ""

	status_label.position = Vector2(30, 505)
	status_label.size = Vector2(300, 100)

	status_label.horizontal_alignment = (
		HORIZONTAL_ALIGNMENT_CENTER
	)

	status_label.vertical_alignment = (
		VERTICAL_ALIGNMENT_CENTER
	)

	status_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

	status_label.add_theme_font_size_override(
		"font_size",
		13
	)

	status_label.add_theme_color_override(
		"font_color",
		Color("#FF3152")
	)

	add_child(status_label)


# =========================================================
# LOGIN
# =========================================================

func _on_login_pressed() -> void:

	if signup_mode:
		_create_account()

		return

	var email := email_input.text.strip_edges()
	var password := password_input.text

	if email.is_empty() or password.is_empty():

		status_label.text = (
			"Enter email and password."
		)

		return

	status_label.text = "Logging in..."

	login_button.disabled = true
	signup_button.disabled = true

	supabase_auth.login(
		email,
		password
	)


# =========================================================
# LOGIN SUCCESS
# =========================================================

func _on_login_success(user_id: String) -> void:

	print("================================")
	print("✅ APP LOGIN SUCCESS")
	print("USER:", user_id)
	print("================================")

	status_label.text = "Login successful!"

	login_button.disabled = false
	signup_button.disabled = false


# =========================================================
# LOGIN FAILED
# =========================================================

func _on_login_failed(message: String) -> void:

	print("❌ LOGIN FAILED:", message)

	status_label.text = message

	login_button.disabled = false
	signup_button.disabled = false


# =========================================================
# CREATE ACCOUNT SCREEN
# =========================================================

func _on_signup_pressed() -> void:

	print("================================")
	print("🆕 CREATE ACCOUNT SCREEN")
	print("================================")

	signup_mode = true

	subtitle_label.text = "CREATE ACCOUNT"

	username_input.visible = true

	email_input.position = Vector2(30, 270)
	password_input.position = Vector2(30, 340)

	login_button.text = "CREATE ACCOUNT"
	login_button.position = Vector2(30, 415)

	signup_button.visible = false

	back_button.visible = true
	back_button.position = Vector2(30, 480)

	status_label.position = Vector2(30, 535)

	status_label.text = ""

	username_input.grab_focus()


# =========================================================
# CREATE ACCOUNT
# =========================================================

func _create_account() -> void:

	var username := username_input.text.strip_edges()
	var email := email_input.text.strip_edges()
	var password := password_input.text

	if username.is_empty():

		status_label.text = "Enter a username."

		return

	if email.is_empty():

		status_label.text = "Enter your email."

		return

	if password.is_empty():

		status_label.text = "Enter a password."

		return

	if password.length() < 6:

		status_label.text = (
			"Password must be at least 6 characters."
		)

		return

	status_label.text = "Creating account..."

	login_button.disabled = true
	back_button.disabled = true

	supabase_auth.signup(
		email,
		password,
		username
	)


# =========================================================
# SIGNUP SUCCESS
# =========================================================

func _on_signup_success(message: String) -> void:

	print("================================")
	print("✅ ACCOUNT CREATED")
	print("================================")

	status_label.text = (
		"Account created!\n\n"
		+ "Please check your email and "
		+ "confirm your account."
	)

	login_button.disabled = false
	back_button.disabled = false


# =========================================================
# SIGNUP FAILED
# =========================================================

func _on_signup_failed(message: String) -> void:

	print("❌ SIGNUP FAILED:", message)

	status_label.text = message

	login_button.disabled = false
	back_button.disabled = false


# =========================================================
# BACK TO LOGIN
# =========================================================

func _on_back_to_login_pressed() -> void:

	print("← BACK TO LOGIN")

	signup_mode = false

	subtitle_label.text = "WELCOME BACK"

	username_input.visible = false

	email_input.position = Vector2(30, 220)
	password_input.position = Vector2(30, 290)

	login_button.text = "LOGIN"
	login_button.position = Vector2(30, 365)

	signup_button.visible = true

	back_button.visible = false

	status_label.position = Vector2(30, 505)

	status_label.text = ""

	username_input.text = ""

	login_button.disabled = false
	signup_button.disabled = false