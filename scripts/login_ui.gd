extends Control

var email_input: LineEdit
var password_input: LineEdit
var login_button: Button
var signup_button: Button
var status_label: Label

var supabase_auth: Node


func _ready() -> void:

	supabase_auth = get_parent().get_node("SupabaseAuth")

	create_login_ui()

	supabase_auth.login_success.connect(
		_on_login_success
	)

	supabase_auth.login_failed.connect(
		_on_login_failed
	)


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

	var subtitle := Label.new()

	subtitle.text = "WELCOME BACK"

	subtitle.position = Vector2(0, 130)
	subtitle.size = Vector2(360, 40)

	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	subtitle.add_theme_font_size_override(
		"font_size",
		16
	)

	subtitle.add_theme_color_override(
		"font_color",
		Color("#788190")
	)

	add_child(subtitle)


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
	# SIGN UP BUTTON
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
	# STATUS
	# =====================================================

	status_label = Label.new()

	status_label.text = ""

	status_label.position = Vector2(30, 505)
	status_label.size = Vector2(300, 70)

	status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

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

	var email := email_input.text.strip_edges()
	var password := password_input.text

	if email.is_empty() or password.is_empty():

		status_label.text = "Enter email and password."

		return

	status_label.text = "Logging in..."

	login_button.disabled = true

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

	# Next step:
	# We will load the player's profile
	# and enter the game.


# =========================================================
# LOGIN FAILED
# =========================================================

func _on_login_failed(message: String) -> void:

	print("❌ LOGIN FAILED:", message)

	status_label.text = message

	login_button.disabled = false


# =========================================================
# SIGN UP
# =========================================================

func _on_signup_pressed() -> void:

	print("CREATE ACCOUNT PRESSED")

	status_label.text = "Account creation will be added next."