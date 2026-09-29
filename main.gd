extends Node2D

# =========================================================
# DON'T TAP RED - V6
# POLISHED MOBILE UI
# =========================================================

# -------------------------
# GAME
# -------------------------

var score: int = 0
var best_score: int = 0
var combo: int = 0
var max_combo: int = 0

var playing: bool = false
var show_result: bool = false
var new_best: bool = false

var current_is_green: bool = true

# -------------------------
# DIFFICULTY
# -------------------------

var reaction_time: float = 1.0
var timer: float = 1.0

# -------------------------
# TARGET
# -------------------------

var target_radius: float = 102.0
var target_scale: float = 1.0
var pulse_time: float = 0.0

# =========================================================
# HOME SCREEN CIRCULAR BUTTONS
# =========================================================

var play_button_rect: Rect2 = Rect2()

var home_button_radius: float = 52.0

# -------------------------
# SCREEN
# -------------------------

var screen_size: Vector2 = Vector2(360, 640)
var scale_factor: float = 1.0
var safe_area: Rect2
var safe_top: float = 0.0
var safe_bottom: float = 0.0

# -------------------------
# EFFECTS
# -------------------------

var shake_strength: float = 0.0
var flash_alpha: float = 0.0
var flash_color: Color = Color.WHITE

var particles: Array = []

# -------------------------
# FAKE OUT
# -------------------------

var fake_out: bool = false
var fake_timer: float = 0.0

var revive_loading: bool = false

# -------------------------
# RESULT
# -------------------------

var result_timer: float = 0.0

# -------------------------
# SHARE
# -------------------------

var share_message: String = ""

# -------------------------
# STORAGE
# -------------------------

var best_file: String = ""
var profile_stats_file: String = ""
var player_settings_file: String = ""

# =========================================================
# LEADERBOARD UI
# =========================================================

var show_leaderboard: bool = false
var show_menu: bool = false

# =========================================================
# PLAYER NAME
# =========================================================

var player_name: String = "PLAYER"
var name_input: LineEdit
var name_input_visible: bool = false

# =========================================================
# PERSONAL RANKING
# =========================================================

var my_rank: int = 0
var my_leaderboard_score: int = 0
var leaderboard_entries: Array = []
var my_max_combo: int = 0

var player_id: String = ""

var rank_http: HTTPRequest
var player_score_http: HTTPRequest

var daily_leaderboard_http: HTTPRequest
var daily_rank_http: HTTPRequest
var daily_player_score_http: HTTPRequest

# =========================================================
# GLOBAL TOP NAVIGATION
# =========================================================

var settings_rect := Rect2()
var global_profile_rect := Rect2()

var show_settings: bool = false

# =========================================================
# LOADING SCREEN
# =========================================================

var show_loading_screen: bool = true

var loading_time: float = 0.0
var loading_progress: float = 0.0

var loading_spinner_angle: float = 0.0
var loading_pulse: float = 0.0
var loading_particle_time: float = 0.0

const LOADING_MIN_TIME: float = 2.5

# =========================================================
# SETTINGS
# =========================================================

var settings_back_rect := Rect2()
var sound_setting_rect := Rect2()
var vibration_setting_rect := Rect2()

var sound_enabled: bool = true
var vibration_enabled: bool = true

const SETTINGS_FILE := "user://game_settings.cfg"

# =========================================================
# SUPABASE
# =========================================================

const SUPABASE_URL: String = "https://cyobggtrsmldmaalitpi.supabase.co"

const SUPABASE_KEY: String = "sb_publishable__Kg9gSUD5tgHQWsSmLCcJA_Sk0yn4rw"

const GAME_CHALLENGE_URL := "https://donttapred-web.vercel.app/challenge"

var leaderboard_http: HTTPRequest
var submit_http: HTTPRequest
var daily_submit_http: HTTPRequest
var leaderboard_scores: Array = []
var leaderboard_loaded: bool = false

var tap_effect: float = 0.0
var game_over_effect: float = 0.0
var combo_effect: float = 0.0

var target_pop: float = 0.0
var best_effect: float = 0.0

var milestone_text: String = ""
var milestone_timer: float = 0.0

var leaderboard_scroll: float = 0.0
var leaderboard_dragging: bool = false
var leaderboard_last_y: float = 0.0

var leaderboard_back_rect := Rect2()
var share_score_rect := Rect2()
var play_again_rect := Rect2()
var daily_challenge_rect := Rect2()
var start_button_rect := Rect2()
var profile_rect := Rect2()
var leaderboard_button_rect := Rect2()
var home_leaderboard_rect: Rect2
const DAILY_SAVE_PATH := "user://daily_challenge.cfg"
const DAILY_COOLDOWN_DAYS: int = 1
var daily_completed_date: String = ""
var daily_date: String = ""
var show_profile: bool = false

var green_grace_timer: float = 0.0
var last_touch_time: int = 0

var pressed_button: String = ""
var button_press_timer: float = 0.0

var pending_button_action: String = ""

var cloud_stats_loaded: bool = false
var cloud_profile_loaded: bool = false

# =========================================================
# CHALLENGE MODE
# =========================================================

var challenge_score: int = 0
var challenge_player: String = ""
var challenge_active: bool = false
var challenge_completed: bool = false

# =========================================================
# INCOMING CHALLENGE
# =========================================================

var incoming_challenge: bool = false
var incoming_challenge_score: int = 0

# =========================================================
# DAILY CHALLENGE
# =========================================================

var daily_best: int = 0
var daily_completed: bool = false
var daily_active: bool = false
var last_game_was_daily: bool = false

var leaderboard_from_result: bool = false

# =========================================================
# DAILY LEADERBOARD
# =========================================================

var daily_leaderboard_scores: Array = []
var leaderboard_daily_mode: bool = false

var global_tab_rect := Rect2()
var daily_tab_rect := Rect2()
var daily_leaderboard_loaded: bool = false

var daily_seed: int = 0
var daily_date_key: String = ""

var daily_my_rank: int = 0
var daily_my_best: int = 0
var daily_my_max_combo: int = 0

# =========================================================
# REVIVE
# =========================================================

var revive_available: bool = true
var revive_used: bool = false
var revive_button_rect := Rect2()

# =========================================================
# ADMOB - REWARDED REVIVE
# =========================================================

var rewarded_ad: RewardedAd = null
var rewarded_loaded: bool = false
var revive_reward_earned: bool = false

var rewarded_fullscreen_callback := FullScreenContentCallback.new()

var revive_reward_listener := OnUserEarnedRewardListener.new()

var rewarded_load_callback := RewardedAdLoadCallback.new()

const TEST_REWARDED_ANDROID := "ca-app-pub-5417052420459652/7059079931"
const TEST_REWARDED_IOS := "ca-app-pub-3940256099942544/1712485313"

var show_revive_page: bool = false
var revive_page_rect := Rect2()
var revive_continue_rect := Rect2()
var revive_play_again_rect := Rect2()

var daily_random := RandomNumberGenerator.new()
# =========================================================
# UI POLISH — SCREEN TRANSITION FADE
# =========================================================

var screen_fade_alpha: float = 0.0
var screen_transition_tween: Tween
var ui_action_pending: bool = false
# =========================================================
# PROFILE STATS
# =========================================================

var games_played: int = 0
var all_time_max_combo: int = 0
var achievements_unlocked: Array[String] = []
var player_score_request_running := false

# Final hardening: prevent duplicate game-over handling/submissions.
var game_over_processed: bool = false
var score_submission_running: bool = false
var daily_score_submission_running: bool = false

# =========================================================
# REVIVE COUNTDOWN
# =========================================================

var revive_countdown_active: bool = false
var revive_countdown_value: int = 3
var revive_countdown_timer: float = 0.0
const REVIVE_COUNTDOWN_STEP: float = 0.6

# =========================================================
# UI POLISH — CORNER RADIUS
# =========================================================

const BUTTON_RADIUS: float = 14.0
const CARD_RADIUS: float = 18.0
const TAB_RADIUS: float = 10.0

const ICON_SETTINGS = preload("res://assets/icons/settings.svg")
const ICON_PROFILE = preload("res://assets/icons/profile.svg")
const ICON_SOUND = preload("res://assets/icons/sound.svg")
const ICON_VIBRATION = preload("res://assets/icons/vibration.svg")
const ICON_HEART = preload("res://assets/icons/heart.svg")
const ICON_LIGHTNING = preload("res://assets/icons/lightning.svg")
const ICON_SHIELD = preload("res://assets/icons/shield.svg")
const ICON_TROPHY = preload("res://assets/icons/trophy.svg")
const ICON_FIRE = preload("res://assets/icons/fire.svg")
const ICON_SHARE = preload("res://assets/icons/share.svg")
const ICON_LEADERBOARD = preload("res://assets/icons/leaderboard.svg")
const ICON_PLAY = preload("res://assets/icons/play.svg")

const HOME_BUTTON_RADIUS: float = 43.0

var game_over_close_rect := Rect2()
var settings_logout_rect := Rect2()

var settings_delete_account_rect: Rect2

var delete_account_dialog: ConfirmationDialog
var account_delete_in_progress: bool = false


func _ready() -> void:

	# =====================================================
	# SUPABASE AUTH AUTOLOAD
	# =====================================================

	if not SupabaseAuth.profile_loaded.is_connected(
		_on_profile_loaded_from_supabase
	):

		SupabaseAuth.profile_loaded.connect(
			_on_profile_loaded_from_supabase
		)

	if not SupabaseAuth.stats_loaded.is_connected(
		_on_stats_loaded_from_supabase
	):

		SupabaseAuth.stats_loaded.connect(
			_on_stats_loaded_from_supabase
		)

	if not SupabaseAuth.logged_out.is_connected(_on_account_deleted):
		SupabaseAuth.logged_out.connect(_on_account_deleted)


	# =====================================================
	# HTTP REQUESTS
	# =====================================================

	leaderboard_http = HTTPRequest.new()

	daily_leaderboard_http = HTTPRequest.new()

	add_child(daily_leaderboard_http)

	daily_leaderboard_http.request_completed.connect(
		_on_daily_leaderboard_request_completed
	)

	add_child(leaderboard_http)

	leaderboard_http.request_completed.connect(
		_on_leaderboard_request_completed
	)

	daily_rank_http = HTTPRequest.new()
	add_child(daily_rank_http)

	daily_rank_http.request_completed.connect(
		_on_daily_rank_request_completed
	)

	daily_player_score_http = HTTPRequest.new()
	add_child(daily_player_score_http)

	daily_player_score_http.request_completed.connect(
		_on_daily_player_score_request_completed
	)

	rank_http = HTTPRequest.new()

	add_child(rank_http)

	rank_http.request_completed.connect(
		_on_rank_request_completed
	)


	player_score_http = HTTPRequest.new()

	add_child(player_score_http)

	player_score_http.request_completed.connect(
		_on_player_score_request_completed
	)


	submit_http = HTTPRequest.new()

	add_child(submit_http)

	submit_http.request_completed.connect(
		_on_submit_score_completed
	)


	daily_submit_http = HTTPRequest.new()

	add_child(daily_submit_http)

	daily_submit_http.request_completed.connect(
		_on_daily_submit_completed
	)


	# =====================================================
	# LOCAL DATA
	# =====================================================

	load_game_settings()
	load_daily_state()

	update_screen_size()

	get_viewport().size_changed.connect(
		_on_resize
	)

	print("================================")
	print("VIEWPORT SIZE:", get_viewport_rect().size)
	print("SCREEN SIZE:", screen_size)
	print("SAFE AREA:", safe_area)
	print("SAFE TOP:", safe_top)
	print("SAFE BOTTOM:", safe_bottom)
	print("================================")

	print("GAME START")
	print("VIEWPORT:", get_viewport_rect().size)
	print("SCREEN:", screen_size)

	

	# =====================================================
	# PLAYER SETTINGS
	# =====================================================

	var config := ConfigFile.new()

	if not player_settings_file.is_empty():

		if config.load(player_settings_file) == OK:

			player_name = str(
				config.get_value(
					"player",
					"name",
					""
				)
			)

			player_id = str(
				config.get_value(
					"player",
					"id",
					""
				)
			)

	# =====================================================
	# USE SUPABASE USER ID
	# =====================================================

	if SupabaseAuth.user_id != "":
	
		player_id = SupabaseAuth.user_id
	
		print("================================")
		print("🔐 LOGGED IN PLAYER")
		print("PLAYER ID:", player_id)
		print("LOADING PROFILE...")
		print("================================")

		setup_account_storage()

		load_best_score()
		load_profile_stats()

		SupabaseAuth.load_profile()
		SupabaseAuth.load_stats()

	else:
	
		print("⚠️ NO SUPABASE USER ID")

	# =====================================================
	# NAME ENTRY
	# =====================================================

	if player_name == "":

		show_name_entry()

	else:

		show_menu = true
		queue_redraw()

	# =====================================================
	# LOAD LEADERBOARD
	# =====================================================

	load_leaderboard()

	# =====================================================
	# CHECK INCOMING CHALLENGE
	# =====================================================

	check_for_challenge()
	activate_incoming_challenge()

	# =====================================================
	# ADMOB
	# =====================================================

	if OS.has_feature("mobile"):

		# =================================================
		# REWARD LISTENER
		# =================================================

		revive_reward_listener.on_user_earned_reward = func(reward) -> void:

			print("================================")
			print("🎁 REWARD EARNED")
			print("Amount: ", reward.amount)
			print("Type: ", reward.type)
			print("❤️ REVIVE UNLOCKED")
			print("================================")

			revive_reward_earned = true

			complete_revive()


		# =================================================
		# REWARDED AD FULL SCREEN CALLBACK
		# =================================================

		rewarded_fullscreen_callback.on_ad_dismissed_full_screen_content = func() -> void:

			print("================================")
			print("📺 REWARDED AD DISMISSED")
			print("📺 CURRENT AD FINISHED")
			print("📺 LOADING NEXT REWARDED AD")
			print("================================")

			# Old ad is finished
			rewarded_ad = null
			rewarded_loaded = false

			# Load a completely new ad
			load_rewarded_ad()


		rewarded_fullscreen_callback.on_ad_failed_to_show_full_screen_content = func(
			ad_error: AdError
		) -> void:

			print("================================")
			print("❌ REWARDED AD FAILED TO SHOW")
			print("ERROR:", ad_error)
			print("================================")

			rewarded_ad = null
			rewarded_loaded = false

			load_rewarded_ad()


		# =================================================
		# ADMOB INITIALIZATION
		# =================================================

		var init_listener := OnInitializationCompleteListener.new()

		init_listener.on_initialization_complete = func(
			status: InitializationStatus
		) -> void:

			print("================================")
			print("✅ ADMOB INITIALIZATION COMPLETE")
			print("================================")

			load_rewarded_ad()

		MobileAds.initialize(init_listener)

	print("================================")
	print("🔊 AUDIO CHECK")

	if has_node("TapSound"):

		var tap_sound = get_node("TapSound")

		print("TapSound node:", tap_sound)
		print("TapSound type:", tap_sound.get_class())

		if tap_sound is AudioStreamPlayer:

			print("TapSound stream:", tap_sound.stream)

			if tap_sound.stream == null:

				print("❌ TapSound HAS NO STREAM")

			else:

				print("✅ TapSound STREAM OK")

		else:

			print("❌ TapSound IS NOT AudioStreamPlayer")

	else:

		print("❌ TapSound NODE NOT FOUND")


	if has_node("GameOverSound"):

		var game_over_sound = get_node("GameOverSound")

		print("GameOverSound node:", game_over_sound)
		print("GameOverSound type:", game_over_sound.get_class())

		if game_over_sound is AudioStreamPlayer:

			print("GameOverSound stream:", game_over_sound.stream)

			if game_over_sound.stream == null:

				print("❌ GameOverSound HAS NO STREAM")

			else:

				print("✅ GameOverSound STREAM OK")

		else:

			print("❌ GameOverSound IS NOT AudioStreamPlayer")

	else:

		print("❌ GameOverSound NODE NOT FOUND")

	print("================================")
	
	show_loading_screen = true
	loading_time = 0.0
	loading_progress = 0.0
	loading_spinner_angle = 0.0
	loading_pulse = 0.0
	loading_particle_time = 0.0

	queue_redraw()

# =========================================================
# CHECK CHALLENGE DATA
# =========================================================

func check_for_challenge() -> void:

	var args := OS.get_cmdline_args()

	print("================================")
	print("🔗 CHECKING FOR CHALLENGE")
	print("ARGS:", args)
	print("================================")

	for arg in args:

		if arg.begins_with("score="):

			var score_text := arg.trim_prefix("score=")

			if score_text.is_valid_int():

				var received_score := int(score_text)

				if received_score > 0:

					set_incoming_challenge(received_score)

					return


# =========================================================
# SET INCOMING CHALLENGE
# =========================================================

func set_incoming_challenge(received_score: int) -> void:

	if received_score <= 0:

		return

	incoming_challenge = true
	incoming_challenge_score = received_score

	print("================================")
	print("🔥 INCOMING CHALLENGE")
	print("TARGET:", received_score)
	print("================================")

	activate_incoming_challenge()

# =========================================================
# PARSE CHALLENGE URL
# =========================================================

func parse_challenge_url(url: String) -> void:

	print("================================")
	print("🔗 CHALLENGE URL RECEIVED")
	print(url)
	print("================================")

	if url.is_empty():

		return


	# Find ?score=
	var score_marker := "score="

	var score_index := url.find(score_marker)

	if score_index == -1:

		print("❌ NO CHALLENGE SCORE FOUND")

		return


	var score_start := (
		score_index +
		score_marker.length()
	)

	var score_text := url.substr(
		score_start
	)


	# Remove any additional query parameters
	var amp_index := score_text.find("&")

	if amp_index != -1:

		score_text = score_text.substr(
			0,
			amp_index
		)


	if not score_text.is_valid_int():

		print("❌ INVALID CHALLENGE SCORE:", score_text)

		return


	var received_score := int(score_text)


	if received_score <= 0:

		print("❌ INVALID SCORE")

		return


	set_incoming_challenge(
		received_score
	)

# =========================================================
# ACTIVATE INCOMING CHALLENGE
# =========================================================

func activate_incoming_challenge() -> void:

	if not incoming_challenge:
		return

	if incoming_challenge_score <= 0:
		return

	challenge_score = incoming_challenge_score
	challenge_active = true
	challenge_completed = false

	print("================================")
	print("🔥 CHALLENGE MODE ACTIVATED")
	print("TARGET SCORE:", challenge_score)
	print("================================")

	# Clear incoming challenge so it isn't activated again
	incoming_challenge = false
	incoming_challenge_score = 0

	queue_redraw()

# =========================================================
# LOAD REWARDED AD
# =========================================================

func load_rewarded_ad() -> void:

	if not OS.has_feature("mobile"):

		print("⚠️ Rewarded ads only run on Android/iOS")

		return


	# =====================================================
	# DON'T LOAD DUPLICATE ADS
	# =====================================================

	if rewarded_loaded and rewarded_ad != null:

		print("📺 REWARDED AD ALREADY READY")

		return


	print("================================")
	print("📺 LOADING REWARDED AD")
	print("================================")


	var unit_id: String = ""


	if OS.get_name() == "Android":

		unit_id = TEST_REWARDED_ANDROID

	elif OS.get_name() == "iOS":

		unit_id = TEST_REWARDED_IOS

	else:

		print("⚠️ Unsupported platform")

		return


	var callback := RewardedAdLoadCallback.new()

	callback.on_ad_loaded = func(
		ad: RewardedAd
	) -> void:

		print("================================")
		print("✅ REWARDED AD LOADED")
		print("AD OBJECT:", ad)
		print("================================")

		rewarded_ad = ad
		rewarded_loaded = true
		revive_loading = false

		rewarded_ad.full_screen_content_callback = (
			rewarded_fullscreen_callback
		)

		queue_redraw()


	# =====================================================
	# LOAD FAILED
	# =====================================================

	callback.on_ad_failed_to_load = func(
		error: LoadAdError
	) -> void:

		print("================================")
		print("❌ REWARDED AD FAILED")
		print("ERROR:", error.message)
		print("================================")

		rewarded_ad = null
		rewarded_loaded = false

		# Retry after 5 seconds

		get_tree().create_timer(5.0).timeout.connect(
			func():
				if rewarded_ad == null or not rewarded_loaded:
					load_rewarded_ad()
		)


	RewardedAdLoader.new().load(
		unit_id,
		AdRequest.new(),
		callback
	)
	print("🔥 REWARDED UNIT ID: ", unit_id)

# =========================================================
# SCREEN
# =========================================================

func update_screen_size() -> void:

	screen_size = get_viewport_rect().size

	scale_factor = min(
		screen_size.x / 360.0,
		screen_size.y / 640.0
	)

	# =====================================================
	# SAFE AREA
	# =====================================================

	var display_safe_area := DisplayServer.get_display_safe_area()

	var viewport_transform := get_viewport().get_final_transform()

	var viewport_safe_area: Rect2 = (
		Rect2(display_safe_area) *
		viewport_transform.affine_inverse()
	)

	var viewport_rect := get_viewport().get_visible_rect()

	safe_top = max(
		0.0,
		viewport_safe_area.position.y - viewport_rect.position.y
	)

	safe_bottom = max(
		0.0,
		viewport_rect.end.y - viewport_safe_area.end.y
	)

	safe_area = Rect2(
		viewport_rect.position.x,
		viewport_rect.position.y + safe_top,
		viewport_rect.size.x,
		viewport_rect.size.y - safe_top - safe_bottom
	)

func _on_resize() -> void:

	update_screen_size()

	queue_redraw()


# =========================================================
# PROCESS
# =========================================================

func _process(delta: float) -> void:

	# =========================================================
	# LOADING SCREEN ANIMATION
	# =========================================================

	if show_loading_screen:

		loading_time += delta
		loading_spinner_angle += delta * 4.0
		loading_particle_time += delta
		loading_pulse += delta * 3.0

		# Smooth loading progress
		loading_progress = min(
			loading_time / LOADING_MIN_TIME,
			1.0
		)

		queue_redraw()

		# Finish loading
		if loading_time >= LOADING_MIN_TIME:

			finish_loading_screen()

		return

	pulse_time += delta

	# =====================================================
	# BUTTON PRESS FEEDBACK / ACTION EXECUTION
	# =====================================================

	if button_press_timer > 0.0:

		button_press_timer -= delta

		if button_press_timer <= 0.0:

			button_press_timer = 0.0
			pressed_button = ""

			var action := pending_button_action
			pending_button_action = ""

			print("================================")
			print("🎮 EXECUTING UI ACTION:", action)
			print("================================")

			# ---------------------------------------------
			# EXECUTE UI ACTION
			# ---------------------------------------------

			if action == "home_leaderboard":

				playing = false
				fake_out = false

				show_menu = false
				show_result = false
				show_profile = false
				show_revive_page = false
				show_leaderboard = true

				leaderboard_daily_mode = false
				leaderboard_scroll = 0.0
				leaderboard_dragging = false

				load_leaderboard()
				load_daily_leaderboard()

				start_screen_transition()


			elif action == "leaderboard":

				print("🏆 OPENING LEADERBOARD")

				playing = false
				fake_out = false
				show_revive_page = false

				timer = 0.0

				show_menu = false
				show_result = false
				show_profile = false
				show_leaderboard = true

				leaderboard_daily_mode = false
				leaderboard_scroll = 0.0
				leaderboard_dragging = false

				load_leaderboard()
				load_daily_leaderboard()

				start_screen_transition()

			elif action == "settings":

				print("⚙ OPENING SETTINGS")

				show_settings = true
				show_menu = false
				show_profile = false
				show_leaderboard = false
				show_result = false
				show_revive_page = false
				playing = false

				start_screen_transition()
				queue_redraw()


			elif action == "profile":

				print("👤 OPENING PROFILE")

				show_profile = true
				show_settings = false
				show_menu = false
				show_leaderboard = false
				show_result = false
				show_revive_page = false
				playing = false

				if SupabaseAuth.user_id != "":
					player_id = SupabaseAuth.user_id
					SupabaseAuth.load_stats()

				load_my_score()

				start_screen_transition()
				queue_redraw()


			elif action == "back":

				show_leaderboard = false
				leaderboard_scroll = 0.0
				leaderboard_dragging = false

				if leaderboard_from_result:

					show_result = true
					show_menu = false

				else:

					show_result = false
					show_menu = true

				start_screen_transition()


			elif action == "start":

				start_game()


			elif action == "daily":

				start_daily_challenge()


			elif action == "play":

				if last_game_was_daily:
					start_daily_challenge()
				else:
					start_game()


			elif action == "share":

				share_score()


			elif action == "revive":

				revive_game()


			elif action == "revive_continue":

				start_revive_after_reward()


			elif action == "revive_play_again":

				show_revive_page = false
				show_result = false

				start_game()


			elif action == "continue":

				confirm_player_name()


			ui_action_pending = false

			queue_redraw()

			return

	# =====================================================
	# REVIVE COUNTDOWN
	# =====================================================

	if revive_countdown_active:

		revive_countdown_timer -= delta

		if revive_countdown_timer <= 0.0:

			revive_countdown_value -= 1

			if revive_countdown_value <= 0:

				revive_countdown_active = false
				playing = true

			else:

				revive_countdown_timer = REVIVE_COUNTDOWN_STEP

		queue_redraw()
		return


	# =====================================================
	# UI SCREENS
	# =====================================================

	if (
		show_menu
		or show_leaderboard
		or show_profile
		or show_settings
		or show_result
		or show_revive_page
		or not playing
	):

		queue_redraw()
		return


	# =====================================================
	# NORMAL GAME PROCESSING
	# =====================================================

	update_particles(delta)

	# -----------------------------------------------------
	# FLASH
	# -----------------------------------------------------

	if flash_alpha > 0.0:

		flash_alpha -= delta * 4.0

		if flash_alpha < 0.0:
			flash_alpha = 0.0

	# -----------------------------------------------------
	# SHAKE
	# -----------------------------------------------------

	if shake_strength > 0.0:

		shake_strength -= delta * 25.0

		if shake_strength < 0.0:
			shake_strength = 0.0

	# -----------------------------------------------------
	# GAME OVER SCREEN
	# -----------------------------------------------------

	if show_result:

		queue_redraw()
		return

	# -----------------------------------------------------
	# FAKE OUT
	# -----------------------------------------------------

	if fake_out:

		fake_timer -= delta

		if fake_timer <= 0.0:

			fake_out = false
			current_is_green = true
			timer = reaction_time

			queue_redraw()

			return

		queue_redraw()
		return

	# =====================================================
	# ACTIVE GAME
	# =====================================================

	timer -= delta

	target_scale = (
		1.0 +
		sin(pulse_time * 8.0) * 0.018
	)

	if timer <= 0.0:

		if current_is_green:

			game_over()
			return

		else:

			change_color()

	if tap_effect > 0.0:
		tap_effect -= delta * 5.0

	if game_over_effect > 0.0:
		game_over_effect -= delta * 2.5

	if combo_effect > 0.0:
		combo_effect -= delta * 3.0

	if target_pop > 0.0:
		target_pop -= delta * 5.0

	if best_effect > 0.0:
		best_effect -= delta * 1.8

	if milestone_timer > 0.0:

		milestone_timer -= delta

		if milestone_timer <= 0.0:
			milestone_text = ""

	queue_redraw()

func button_pressed(
	button_name: String,
	action: String
) -> void:

	# Prevent another touch while button action is waiting
	if ui_action_pending:
		return

	ui_action_pending = true

	pressed_button = button_name
	pending_button_action = action
	button_press_timer = 0.12

	queue_redraw()

# =========================================================
# UI POLISH — ROUNDED RECTANGLE HELPER
# =========================================================
#
# draw_rect() in Godot 4 has no corner-radius support, so every
# card/button in this game was a hard-edged box. This builds a
# rounded rect out of a polygon by sampling an arc per corner.

func draw_rounded_rect(
	rect: Rect2,
	radius: float,
	color: Color
) -> void:

	var r: float = min(
		radius,
		min(rect.size.x, rect.size.y) * 0.5
	)

	if r <= 0.5:

		draw_rect(rect, color)

		return

	var points: PackedVector2Array = PackedVector2Array()
	var segments: int = 8

	var corners: Array = [
		{
			"center": rect.position + Vector2(r, r),
			"start": PI,
			"end": PI * 1.5
		},
		{
			"center": rect.position + Vector2(rect.size.x - r, r),
			"start": PI * 1.5,
			"end": TAU
		},
		{
			"center": rect.position + Vector2(rect.size.x - r, rect.size.y - r),
			"start": 0.0,
			"end": PI * 0.5
		},
		{
			"center": rect.position + Vector2(r, rect.size.y - r),
			"start": PI * 0.5,
			"end": PI
		}
	]

	for corner in corners:

		var start_angle: float = corner["start"]
		var end_angle: float = corner["end"]
		var center: Vector2 = corner["center"]

		for i in range(segments + 1):

			var t: float = start_angle + (
				(end_angle - start_angle) *
				(float(i) / float(segments))
			)

			points.append(
				center + Vector2(cos(t), sin(t)) * r
			)

	draw_polygon(points, PackedColorArray([color]))

# =========================================================
# UI POLISH — SCREEN TRANSITION FADE
# =========================================================
#
# Call this whenever the game switches screens (menu -> game,
# game -> result, result -> leaderboard, etc). It briefly fades
# a dark overlay out over the new screen instead of hard-cutting,
# which is the difference between "prototype" and "shipped app".

func start_screen_transition() -> void:

	screen_fade_alpha = 1.0

	queue_redraw()

	if screen_transition_tween:
		screen_transition_tween.kill()

	screen_transition_tween = create_tween()

	screen_transition_tween.tween_method(
		_set_screen_fade,
		1.0,
		0.0,
		0.22
	).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)


func _set_screen_fade(value: float) -> void:

	screen_fade_alpha = value

	queue_redraw()


func _draw_screen_fade() -> void:

	if screen_fade_alpha > 0.0:

		draw_rect(
			Rect2(Vector2.ZERO, screen_size),
			Color(0.03, 0.04, 0.06, screen_fade_alpha)
		)

func start_challenge(target_score: int) -> void:

	if target_score <= 0:
		return

	challenge_score = target_score
	challenge_active = true
	challenge_completed = false

	print("================================")
	print("🔥 CHALLENGE STARTED")
	print("BEAT:", challenge_score)
	print("================================")

	start_game()

# =========================================================
# PERSISTENT PROFILE HEADER
# =========================================================

func draw_profile_header() -> void:

	var w: float = screen_size.x

	var profile_size: float = 40.0

	profile_rect = Rect2(
		w - profile_size - 15.0,
		safe_top + 5.0,
		profile_size,
		profile_size
	)

	var profile_center := profile_rect.get_center()

	draw_circle(
		profile_center,
		22.0,
		Color(0.10, 0.90, 0.43, 0.10)
	)

	draw_circle(
		profile_center,
		20.0,
		Color("#111822")
	)

	draw_arc(
		profile_center,
		20.0,
		0.0,
		TAU,
		40,
		Color("#19E66F"),
		2.0
	)

	var initial := "P"

	if not player_name.is_empty():
		initial = player_name.substr(0, 1).to_upper()

	draw_centered(
		initial,
		Vector2(
			profile_center.x,
			profile_center.y + 7.0
		),
		17,
		Color("#19E66F")
	)

# =========================================================
# DRAW
# =========================================================

func _draw() -> void:

	var w: float = screen_size.x
	var h: float = screen_size.y

	# =====================================================
	# LOADING SCREEN
	# =====================================================
	if show_loading_screen:
		draw_loading_screen()
		return

	if name_input_visible:

		draw_rect(
			Rect2(Vector2.ZERO, screen_size),
			Color("#070A0F")
		)

		draw_centered(
			"DON'T TAP RED",
			Vector2(w / 2, 100),
			28,
			Color.WHITE
		)

		draw_centered(
			"ENTER YOUR NAME",
			Vector2(w / 2, 180),
			18,
			Color("#19E66F")
		)

		draw_button(
			Rect2(
				25,
				400,
				w - 50,
				55
			),
			"CONTINUE",
			Color("#19E66F"),
			"continue"
		)

		_draw_screen_fade()

		return

	# =====================================================
	# PROFILE SCREEN
	# =====================================================

	if show_settings:

		draw_settings_screen()
		_draw_screen_fade()
		return

	if show_profile:

		draw_profile_screen()
		_draw_screen_fade()
		return

	# -----------------------------------------------------
	# BACKGROUND
	# -----------------------------------------------------

	draw_rect(
		Rect2(Vector2.ZERO, screen_size),
		Color("#070A0F")
	)
	draw_global_navigation()

	# =====================================================
	# LEADERBOARD SCREEN
	# =====================================================

	if show_leaderboard:

		draw_leaderboard_screen()

		_draw_screen_fade()

		return


	# =====================================================
	# HOME SCREEN
	# =====================================================

	if show_menu:
		draw_home_menu()

	# =====================================================
	# GAME OVER OVERLAY
	# =====================================================

	if show_result:
		draw_game_over_screen()

		if show_revive_page:
			draw_revive_page()

		_draw_screen_fade()
		return

	# =====================================================
	# HOME MENU
	# =====================================================

	if show_menu:

		_draw_screen_fade()

		return

	# -----------------------------------------------------
	# SHAKE
	# -----------------------------------------------------

	var shake_offset := Vector2.ZERO

	if shake_strength > 0.0:

		shake_offset = Vector2(
			randf_range(-shake_strength, shake_strength),
			randf_range(-shake_strength, shake_strength)
		)


	var title_font_size: int = 22

	if w < 380:
		title_font_size = 20

	draw_centered(
		"DON'T TAP RED",
		Vector2(
			w / 2.0,
			safe_top + 35.0
		),
		title_font_size,
		Color.WHITE
	)


	# =====================================================
	# START BUTTON / TARGET HITBOX
	# =====================================================

	var start_radius: float = target_radius * scale_factor

	start_button_rect = Rect2(
		w / 2.0 - start_radius,
		h / 2.0 - 30.0 - start_radius,
		start_radius * 2.0,
		start_radius * 2.0
	)


	# -----------------------------------------------------
	# SCORE
	# -----------------------------------------------------

	draw_centered(
		str(score),
		Vector2(w / 2, safe_top + 85),
		50,
		Color("#FFFFFF")
	)


	# -----------------------------------------------------
	# BEST
	# -----------------------------------------------------

	draw_centered(
		"BEST " + str(best_score),
		Vector2(w / 2, safe_top + 113),
		14,
		Color("#788190")
	)

	# =====================================================
	# FRIEND CHALLENGE
	# =====================================================

	if playing and challenge_active:

		draw_icon(
			ICON_FIRE,
			Vector2(
				w / 2 - 36,
				safe_top + 134
			),
			18.0
		)

		draw_centered(
			"BEAT " + str(challenge_score),
			Vector2(
				w / 2 + 12,
				safe_top + 145
			),
			14,
			Color("#FFD447")
		)


	# -----------------------------------------------------
	# COMBO
	# -----------------------------------------------------

	if playing and combo >= 2:

		var combo_size: int = 18

		if combo >= 10:
			combo_size = 22

		if combo >= 20:
			combo_size = 26

		if combo >= 50:
			combo_size = 30

		var combo_y: float = safe_top + 165.0

		if combo_effect > 0.0:
			combo_y -= 12.0 * combo_effect

		draw_icon(
			ICON_FIRE,
			Vector2(
				w / 2 - 66,
				combo_y - 6.0
			),
			float(combo_size)
		)

		draw_centered(
			str(combo) + " COMBO!",
			Vector2(
				w / 2 + 10,
				combo_y
			),
			combo_size,
			Color("#FFD447")
		)

	# =====================================================
	# MILESTONE
	# =====================================================

	if milestone_timer > 0.0:

		var milestone_alpha: float = min(
			milestone_timer * 2.0,
			1.0
		)

		draw_centered(
			milestone_text,
			Vector2(
				w / 2,
				205
			),
			24,
			Color(
				1.0,
				0.83,
				0.25,
				milestone_alpha
			)
		)

	# -----------------------------------------------------
	# TARGET
	# -----------------------------------------------------

	var center := Vector2(
		w / 2,
		h / 2 - 30
	)

	var radius: float = (
		target_radius *
		scale_factor *
		target_scale
	)

	if target_pop > 0.0:

		radius += 18.0 * target_pop

	var target_color: Color

	if current_is_green:

		target_color = Color("#19E66F")

	else:

		target_color = Color("#FF3152")


	# Shadow

	draw_circle(
		center + Vector2(0, 9),
		radius,
		Color("#000000")
	)


	# Outer circle

	draw_circle(
		center,
		radius,
		target_color
	)


	# Inner circle

	draw_circle(
		center,
		radius * 0.82,
		target_color.lightened(0.08)
	)


	# Target text

	var target_text: String

	if fake_out:

		target_text = "GAME OVER"

	elif not playing:

		target_text = "TAP TO START"

	elif current_is_green:

		target_text = "TAP!"

	else:

		target_text = "DON'T TAP!"


	draw_centered(
		target_text,
		center + Vector2(0, 8),
		23,
		Color.WHITE
	)

	# =====================================================
	# REVIVE COUNTDOWN OVERLAY
	# =====================================================

	if revive_countdown_active:

		draw_rect(
			Rect2(Vector2.ZERO, screen_size),
			Color(0.02, 0.03, 0.05, 0.55)
		)

		draw_centered(
			str(revive_countdown_value),
			center + Vector2(0, 18),
			70,
			Color("#FFD447")
		)

	# =====================================================
	# HOME — RANK + PLAY
	# =====================================================

	if not playing and not show_result:

		var button_radius: float = HOME_BUTTON_RADIUS

		var button_y: float = (
			h - safe_bottom - button_radius - 12.0
		)

		# =================================================
		# RANK
		# =================================================

		var rank_center := Vector2(
			95.0,
			button_y
		)

		leaderboard_button_rect = Rect2(
			rank_center - Vector2(button_radius, button_radius),
			Vector2(
				button_radius * 2.0,
				button_radius * 2.0
			)
		)

		# =================================================
		# PLAY
		# =================================================

		var play_center := Vector2(
			w - 95.0,
			button_y
		)

		play_button_rect = Rect2(
			play_center - Vector2(button_radius, button_radius),
			Vector2(
				button_radius * 2.0,
				button_radius * 2.0
			)
		)

		# =================================================
		# RANK SHADOW
		# =================================================

		draw_circle(
			rank_center + Vector2(0, 5),
			button_radius,
			Color(0, 0, 0, 0.55)
		)

		# =================================================
		# RANK CIRCLE
		# =================================================

		draw_circle(
			rank_center,
			button_radius,
			Color("#202A38")
		)

		# =================================================
		# RANK BORDER
		# =================================================

		draw_arc(
			rank_center,
			button_radius - 1.5,
			0.0,
			TAU,
			64,
			Color("#19E66F"),
			3.0
		)

		# =================================================
		# RANK ICON
		# =================================================

		draw_icon(
			ICON_TROPHY,
			rank_center + Vector2(0, -7),
			20.0
		)

		draw_centered(
			"RANK",
			rank_center + Vector2(0, 25),
			11,
			Color.WHITE
		)

		# =================================================
		# PLAY SHADOW
		# =================================================

		draw_circle(
			play_center + Vector2(0, 5),
			button_radius,
			Color(0, 0, 0, 0.55)
		)

		# =================================================
		# PLAY CIRCLE
		# =================================================

		draw_circle(
			play_center,
			button_radius,
			Color("#19E66F")
		)

		# =================================================
		# PLAY BORDER
		# =================================================

		draw_arc(
			play_center,
			button_radius - 1.5,
			0.0,
			TAU,
			64,
			Color("#19E66F"),
			3.0
		)

		# =================================================
		# PLAY ICON
		# =================================================

		draw_icon(
			ICON_PLAY,
			play_center + Vector2(0, -7),
			20.0
		)

		draw_centered(
			"PLAY",
			play_center + Vector2(0, 25),
			11,
			Color.WHITE
		)

	# =====================================================
	# TAP EFFECT
	# =====================================================

	if tap_effect > 0.0:

		var effect_radius: float = (
			radius +
			(35.0 * tap_effect)
		)

		var effect_color := Color(
			0.10,
			0.90,
			0.45,
			0.35 * tap_effect
		)

		draw_arc(
			center,
			effect_radius,
			0.0,
			TAU,
			64,
			effect_color,
			4.0
		)

	if combo_effect > 0.0 and combo >= 2:

		var combo_effect_y := 180 - (20.0 * combo_effect)

		draw_icon(
			ICON_FIRE,
			Vector2(
				w / 2 - 55,
				combo_effect_y - 6.0
			),
			20.0
		)

		draw_centered(
			str(combo) + " COMBO!",
			Vector2(
				w / 2 + 10,
				combo_effect_y
			),
			20,
			Color(
				1.0,
				0.83,
				0.25,
				combo_effect
			)
		)

	# -----------------------------------------------------
	# SPEED
	# -----------------------------------------------------

	if playing:

		var speed: float = 1.0 / reaction_time

		draw_centered(
			"SPEED " + str(snappedf(speed, 0.1)) + "x",
			Vector2(w / 2, h - safe_bottom - 55),
			14,
			Color("#737C8A")
		)

	else:

		draw_centered(
			"GREEN = TAP",
			Vector2(
				w / 2,
				h - safe_bottom - 205
			),
			13,
			Color("#19E66F")
		)

		draw_centered(
			"RED = DON'T TAP",
			Vector2(
				w / 2,
				h - safe_bottom - 180
			),
			13,
			Color("#FF3152")
		)


	# -----------------------------------------------------
	# FLASH
	# -----------------------------------------------------

	if flash_alpha > 0.0:

		var flash := Color(
			flash_color.r,
			flash_color.g,
			flash_color.b,
			flash_alpha
		)

		draw_rect(
			Rect2(Vector2.ZERO, screen_size),
			flash
		)

	if game_over_effect > 0.0:

		draw_rect(
			Rect2(
				Vector2.ZERO,
				screen_size
			),
			Color(
				1.0,
				0.05,
				0.15,
				0.18 * game_over_effect
			)
		)

	_draw_screen_fade()

# =========================================================
# PROFILE SCREEN — FINAL
# =========================================================

func draw_profile_screen() -> void:

	var w: float = screen_size.x
	var h: float = screen_size.y

	var profile_best_score: int = max(

		best_score,
		my_leaderboard_score
	)

	# =====================================================
	# BACKGROUND
	# =====================================================

	draw_rect(
		Rect2(Vector2.ZERO, screen_size),
		Color("#070A0F")
	)

	draw_global_navigation()

	# =====================================================
	# TOP ACCENT
	# =====================================================

	draw_rect(
		Rect2(
			0,
			safe_top,
			w,
			5
		),
		Color("#19E66F")
	)

	# =====================================================
	# TITLE
	# =====================================================

	draw_centered(
		"PROFILE",
		Vector2(
			w / 2,
			safe_top + 60
		),
		27,
		Color.WHITE
	)

	# =====================================================
	# AVATAR
	# =====================================================

	var avatar_center := Vector2(
		w / 2,
		safe_top + 125
	)

	# Glow
	draw_circle(
		avatar_center,
		51,
		Color(0.10, 0.90, 0.43, 0.10)
	)

	# Avatar
	draw_circle(
		avatar_center,
		45,
		Color("#111822")
	)

	var initial := "P"

	if not player_name.is_empty():
		initial = player_name.substr(0, 1).to_upper()

	draw_centered(
		initial,
		Vector2(
			avatar_center.x,
			avatar_center.y + 13
		),
		34,
		Color("#19E66F")
	)

	# =====================================================
	# NAME
	# =====================================================

	var display_name := player_name

	if display_name.is_empty():
		display_name = "PLAYER"

	if display_name.length() > 16:
		display_name = display_name.substr(0, 16)

	draw_centered(
		display_name,
		Vector2(
			w / 2,
			safe_top + 195
		),
		23,
		Color.WHITE
	)

	# =====================================================
	# PLAYER / RANK
	# =====================================================

	var rank_text := "PLAYER"

	if my_rank > 0:

		rank_text = (
			"PLAYER  •  GLOBAL #" +
			str(my_rank)
		)

	draw_centered(
		rank_text,
		Vector2(
			w / 2,
			safe_top + 218
		),
		10,
		Color("#697382")
	)

	# =====================================================
	# BEST SCORE CARD
	# =====================================================

	var main_card := Rect2(
		20,
		safe_top + 250,
		w - 40,
		115
	)

	draw_rounded_rect(
		main_card,
		16,
		Color("#111822")
	)

	# Green accent
	draw_rounded_rect(
		Rect2(
			main_card.position.x,
			main_card.position.y,
			main_card.size.x,
			5
		),
		3,
		Color("#19E66F")
	)

	draw_icon(
		ICON_TROPHY,
		Vector2(
			w / 2.0 - 55.0,
			safe_top + 280.0
		),
		18.0
	)

	draw_centered(
		"BEST SCORE",
		Vector2(
			w / 2.0 + 10.0,
			safe_top + 283
		),
		11,
		Color("#788190")
	)

	draw_centered(
		str(profile_best_score),
		Vector2(
			w / 2,
			safe_top + 325
		),
		38,
		Color("#19E66F")
	)

	if my_rank > 0:

		draw_centered(
			"GLOBAL RANK  #" + str(my_rank),
			Vector2(
				w / 2,
				safe_top + 350
			),
			11,
			Color("#FFD447")
		)

	# =====================================================
	# SMALL STAT CARDS
	# =====================================================

	var gap := 10.0

	var small_w := (
		w -
		40.0 -
		gap
	) / 2.0

	var stat_y := safe_top + 380

	var daily_card := Rect2(
		20,
		stat_y,
		small_w,
		90
	)

	var combo_card := Rect2(
		20 + small_w + gap,
		stat_y,
		small_w,
		90
	)

	# -----------------------------------------------------
	# DAILY
	# -----------------------------------------------------

	draw_rounded_rect(
		daily_card,
		14,
		Color("#111822")
	)

	draw_icon(
		ICON_FIRE,
		Vector2(
			daily_card.get_center().x - 45.0,
			stat_y + 20.0
		),
		16.0
	)

	draw_centered(
		"DAILY BEST",
		Vector2(
			daily_card.get_center().x + 8.0,
			stat_y + 29
		),
		10,
		Color("#788190")
	)

	draw_centered(
		str(daily_my_best),
		Vector2(
			daily_card.get_center().x,
			stat_y + 67
		),
		27,
		Color("#FFD447")
	)

	# -----------------------------------------------------
	# ALL-TIME MAX COMBO
	# -----------------------------------------------------

	draw_rounded_rect(
		combo_card,
		14,
		Color("#111822")
	)

	draw_icon(
		ICON_FIRE,
		Vector2(
			combo_card.get_center().x - 45.0,
			stat_y + 20.0
		),
		16.0
	)

	draw_centered(
		"MAX COMBO",
		Vector2(
			combo_card.get_center().x + 8.0,
			stat_y + 29
		),
		10,
		Color("#788190")
	)

	draw_centered(
		str(max(all_time_max_combo, my_max_combo)),
		Vector2(
			combo_card.get_center().x,
			stat_y + 67
		),
		27,
		Color("#19E66F")
	)

	# =====================================================
	# ACHIEVEMENTS
	# =====================================================

	var achievement_y := safe_top + 495

	draw_centered(
		"ACHIEVEMENTS",
		Vector2(
			w / 2,
			achievement_y
		),
		10,
		Color("#697382")
	)

	# -----------------------------------------------------
	# SCORE MILESTONES
	# -----------------------------------------------------

	var achievement_values := [
		10,
		25,
		50,
		100
	]

	var achievement_x := [
		w * 0.17,
		w * 0.39,
		w * 0.61,
		w * 0.83
	]

	for i in range(achievement_values.size()):

		var required_score: int = achievement_values[i]

		var unlocked := profile_best_score >= required_score

		var achievement_color := Color("#202A38")

		var text_color := Color("#596372")

		if unlocked:

			achievement_color = Color("#19E66F")
			text_color = Color("#06100A")

		var achievement_rect := Rect2(
			achievement_x[i] - 25,
			achievement_y + 12,
			50,
			32
		)

		draw_rounded_rect(
			achievement_rect,
			10,
			achievement_color
		)

		draw_centered(
			str(required_score),
			Vector2(
				achievement_x[i],
				achievement_y + 34
			),
			11,
			text_color
		)

	# =====================================================
	# GAMES PLAYED
	# =====================================================

	var games_y := safe_top + 555

	draw_icon(
		ICON_PLAY,
		Vector2(
			w / 2.0 - 75.0,
			games_y - 3.0
		),
		16.0
	)

	draw_centered(
		"GAMES PLAYED  " + str(games_played),
		Vector2(
			w / 2.0 + 10.0,
			games_y
		),
		12,
		Color("#788190")
	)

	# =====================================================
	# PLAYER LEVEL / TITLE
	# =====================================================

	var player_title := "KEEP PLAYING"

	var player_title_icon: Texture2D = null

	if best_score >= 100:

		player_title = "UNSTOPPABLE"
		player_title_icon = ICON_TROPHY

	elif best_score >= 50:

		player_title = "INSANE"
		player_title_icon = ICON_FIRE

	elif best_score >= 25:

		player_title = "FAST"
		player_title_icon = ICON_LIGHTNING

	elif best_score >= 10:

		player_title = "GETTING GOOD"
		player_title_icon = ICON_FIRE

	elif best_score > 0:

		player_title = "FIRST BLOOD"
		player_title_icon = ICON_SHIELD

	# Small title badge — replace the whole block with:
	var badge_w: float = 200.0
	var badge_h: float = 34.0

	var title_rect := Rect2(
		w / 2.0 - badge_w / 2.0,
		safe_top + 585,
		badge_w,
		badge_h
	)

	draw_rounded_rect(
		title_rect,
		badge_h / 2.0,      # full pill radius, not the old 10
		Color("#202A38")
	)

	if player_title_icon != null:

		draw_icon(
			player_title_icon,
			Vector2(
				w / 2.0 - 65.0,
				safe_top + 585 + 15.0
			),
			18.0
		)

	draw_centered(
		player_title,
		Vector2(
			w / 2.0 + 8.0,
			safe_top + 585 + badge_h / 2.0 + 4.0
		),
		12,
		Color("#FFD447")
	)

	# =====================================================
	# BACK BUTTON
	# =====================================================

	leaderboard_back_rect = Rect2(
		40,
		h - safe_bottom - 65,
		w - 80,
		55
	)

	draw_button(
		leaderboard_back_rect,
		"← BACK",
		Color("#202A38"),
		"profile_back"
	)

# =========================================================
# HOME SCREEN — CIRCULAR BUTTON DESIGN
# =========================================================

func draw_home_menu() -> void:

	var w: float = screen_size.x
	var h: float = screen_size.y

	# =====================================================
	# BACKGROUND
	# =====================================================

	draw_rect(
		Rect2(Vector2.ZERO, screen_size),
		Color("#070A0F")
	)

	# =====================================================
	# TOP NAVIGATION
	# =====================================================

	draw_global_navigation()

	# =====================================================
	# TITLE
	# =====================================================

	var title_y: float = safe_top + 140.0

	draw_centered(
		"DON'T TAP",
		Vector2(
			w / 2.0,
			title_y
		),
		32,
		Color.WHITE
	)

	draw_centered(
		"RED",
		Vector2(
			w / 2.0,
			title_y + 42.0
		),
		34,
		Color("#FF3152")
	)

	# =====================================================
	# RULE
	# =====================================================

	draw_centered(
		"THE ONLY RULE",
		Vector2(
			w / 2.0,
			title_y + 105.0
		),
		11,
		Color("#788190")
	)

	draw_centered(
		"DON'T TAP RED",
		Vector2(
			w / 2.0,
			title_y + 130.0
		),
		12,
		Color("#19E66F")
	)

	# =====================================================
	# BEST SCORE
	# =====================================================

	var score_y: float = title_y + 190.0

	draw_centered(
		"BEST SCORE",
		Vector2(
			w / 2.0,
			score_y
		),
		12,
		Color("#788190")
	)

	draw_centered(
		str(best_score),
		Vector2(
			w / 2.0,
			score_y + 48.0
		),
		52,
		Color("#19E66F")
	)

	# =====================================================
	# TODAY SCORE
	# =====================================================

	draw_icon(
		ICON_FIRE,
		Vector2(
			w / 2.0 - 48.0,
			score_y + 92.0
		),
		20.0
	)

	draw_centered(
		"TODAY  " + str(daily_my_best),
		Vector2(
			w / 2.0 + 20.0,
			score_y + 105.0
		),
		12,
		Color("#FFD447")
	)

	# =====================================================
	# BOTTOM INSTRUCTIONS
	# =====================================================

	var instruction_y: float = score_y + 175.0

	draw_centered(
		"GREEN = TAP",
		Vector2(
			w / 2.0,
			instruction_y
		),
		12,
		Color("#19E66F")
	)

	draw_centered(
		"RED = DON'T TAP",
		Vector2(
			w / 2.0,
			instruction_y + 25.0
		),
		12,
		Color("#FF3152")
	)


	# =====================================================
	# DAILY CHALLENGE BUTTON
	# =====================================================

	if not daily_completed:

		var daily_width: float = min(
			w - 140.0,
			230.0
		)

		var daily_height: float = 38.0

		var daily_x: float = (
			w - daily_width
		) / 2.0

		var daily_y: float = score_y + 115.0

		daily_challenge_rect = Rect2(
			daily_x,
			daily_y,
			daily_width,
			daily_height
		)

		# -------------------------------------------------
		# SHADOW
		# -------------------------------------------------

		draw_style_box(
			make_rounded_box(
				Color(0, 0, 0, 0.55),
				10.0
			),
			Rect2(
				daily_x,
				daily_y + 4.0,
				daily_width,
				daily_height
			)
		)

		# -------------------------------------------------
		# BUTTON
		# -------------------------------------------------

		draw_style_box(
			make_rounded_box(
				Color("#202A38"),
				10.0
			),
			daily_challenge_rect
		)

		# -------------------------------------------------
		# FIRE ICON
		# -------------------------------------------------

		draw_icon(
			ICON_FIRE,
			Vector2(
				daily_x + 25.0,
				daily_y + daily_height / 2.0
			),
			16.0
		)

		# -------------------------------------------------
		# TEXT
		# -------------------------------------------------

		draw_centered(
			"DAILY CHALLENGE",
			Vector2(
				w / 2.0 + 8.0,
				daily_y + 14.0
			),
			10,
			Color.WHITE
		)

	# =====================================================
	# CIRCULAR BUTTON SETTINGS
	# =====================================================

	var button_radius: float = 40.0

	var button_y: float = (
		h -
		safe_bottom -
		button_radius -
		10.0
	)

	var button_gap: float = 25.0

	var center_x: float = w / 2.0

	var rank_center := Vector2(
		center_x - button_radius - button_gap / 2.0,
		button_y
	)

	var play_center := Vector2(
		center_x + button_radius + button_gap / 2.0,
		button_y
	)

	# =====================================================
	# HITBOXES
	# =====================================================
	#
	# Keep Rect2 hitboxes because your existing _input()
	# code already checks these rectangles.

	var diameter: float = button_radius * 2.0

	leaderboard_button_rect = Rect2(
		rank_center - Vector2(button_radius, button_radius),
		Vector2(diameter, diameter)
	)

	play_button_rect = Rect2(
		play_center - Vector2(button_radius, button_radius),
		Vector2(diameter, diameter)
	)

	# =====================================================
	# RANK CIRCLE SHADOW
	# =====================================================

	draw_circle(
		rank_center + Vector2(0, 5),
		button_radius + 2.0,
		Color(0, 0, 0, 0.65)
	)

	# =====================================================
	# RANK OUTER RING
	# =====================================================

	draw_circle(
		rank_center,
		button_radius + 2.0,
		Color("#19E66F")
	)

	# =====================================================
	# RANK INNER CIRCLE
	# =====================================================

	draw_circle(
		rank_center,
		button_radius,
		Color("#18212D")
	)

	# =====================================================
	# RANK INNER HIGHLIGHT
	# =====================================================

	draw_arc(
		rank_center,
		button_radius - 5.0,
		PI,
		TAU,
		64,
		Color("#303B48"),
		2.0
	)

	# =====================================================
	# RANK ICON
	# =====================================================

	draw_icon(
		ICON_TROPHY,
		rank_center + Vector2(0, -14),
		23.0
	)

	draw_centered(
		"RANK",
		rank_center + Vector2(0, 30),
		13,
		Color.WHITE
	)

	# =====================================================
	# PLAY CIRCLE SHADOW
	# =====================================================

	draw_circle(
		play_center + Vector2(0, 5),
		button_radius + 2.0,
		Color(0, 0, 0, 0.65)
	)

	# =====================================================
	# PLAY OUTER RING
	# =====================================================

	draw_circle(
		play_center,
		button_radius + 2.0,
		Color("#19E66F")
	)

	# =====================================================
	# PLAY INNER CIRCLE
	# =====================================================

	draw_circle(
		play_center,
		button_radius,
		Color("#19E66F")
	)

	# =====================================================
	# PLAY HIGHLIGHT
	# =====================================================

	draw_arc(
		play_center,
		button_radius - 5.0,
		PI,
		TAU,
		64,
		Color("#8AFFB7"),
		2.0
	)

	# =====================================================
	# PLAY ICON
	# =====================================================

	draw_icon(
		ICON_PLAY,
		play_center + Vector2(0, -14),
		23.0
	)

	draw_centered(
		"PLAY",
		play_center + Vector2(0, 30),
		13,
		Color("#05080B")
	)

func save_player_name() -> void:

	if name_input == null:
		return

	var entered_name := name_input.text.strip_edges()

	if entered_name.is_empty():
		entered_name = "PLAYER"

	player_name = entered_name

	var config := ConfigFile.new()

	config.set_value(
		"player",
		"name",
		player_name
	)

	config.save(player_settings_file)
	
# =========================================================
# PLAYER NAME INPUT
# =========================================================

func create_name_input() -> void:

	if name_input != null:
		return

	name_input = LineEdit.new()

	name_input.placeholder_text = "ENTER YOUR NAME"

	name_input.text = player_name

	name_input.max_length = 16

	name_input.alignment = HORIZONTAL_ALIGNMENT_CENTER

	name_input.position = Vector2(
		25,
		330
	)

	name_input.size = Vector2(
		screen_size.x - 50,
		50
	)

	add_child(name_input)

	name_input.grab_focus()

# =========================================================
# GLOBAL TOP NAVIGATION
# =========================================================

func draw_global_navigation() -> void:

	var w: float = screen_size.x

	var button_size: float = 42.0
	var margin: float = 14.0

	var y: float = safe_top + 8.0

	# =====================================================
	# SETTINGS — TOP LEFT
	# =====================================================

	settings_rect = Rect2(
		margin,
		y,
		button_size,
		button_size
	)

	draw_nav_icon_button(
		settings_rect,
		ICON_SETTINGS,
		"settings"
	)

	# =====================================================
	# PROFILE — TOP RIGHT
	# =====================================================

	global_profile_rect = Rect2(
		w - margin - button_size,
		y,
		button_size,
		button_size
	)

	draw_profile_icon(
		global_profile_rect,
		"profile"
	)

# =========================================================
# NAV ICON BUTTON
# =========================================================

func draw_nav_icon_button(
	rect: Rect2,
	icon: Texture2D,
	button_id: String
) -> void:

	var is_pressed: bool = (
		pressed_button == button_id and
		button_press_timer > 0.0
	)

	var draw_rect := rect

	if is_pressed:
		draw_rect.position.y += 3.0

	# Shadow
	draw_circle(
		draw_rect.get_center() + Vector2(0, 3),
		22.0,
		Color(0, 0, 0, 0.35)
	)

	# Background
	draw_circle(
		draw_rect.get_center(),
		20.0,
		Color("#111923")
	)

	# Border
	draw_arc(
		draw_rect.get_center(),
		20.0,
		0.0,
		TAU,
		40,
		Color("#27313D"),
		1.5
	)

	# Icon
	draw_icon(
		icon,
		draw_rect.get_center(),
		20.0
	)

# =========================================================
# GLOBAL PROFILE ICON
# =========================================================

func draw_profile_icon(
	rect: Rect2,
	button_id: String
) -> void:

	var is_pressed: bool = (
		pressed_button == button_id and
		button_press_timer > 0.0
	)

	var center := rect.get_center()

	if is_pressed:
		center.y += 3.0

	# =====================================================
	# GLOW
	# =====================================================

	draw_circle(
		center,
		23.0,
		Color(
			0.10,
			0.90,
			0.43,
			0.10
		)
	)

	# =====================================================
	# SHADOW
	# =====================================================

	draw_circle(
		center + Vector2(0, 3),
		20.0,
		Color(0, 0, 0, 0.40)
	)

	# =====================================================
	# PROFILE CIRCLE
	# =====================================================

	draw_circle(
		center,
		20.0,
		Color("#111923")
	)

	# =====================================================
	# GREEN BORDER
	# =====================================================

	draw_arc(
		center,
		20.0,
		0.0,
		TAU,
		40,
		Color("#19E66F"),
		2.0
	)

	# =====================================================
	# USER LOGO
	# =====================================================

	# Head
	draw_circle(
		center + Vector2(0, -5),
		5.5,
		Color("#19E66F")
	)

	# Body
	draw_arc(
		center + Vector2(0, 10),
		10.0,
		PI,
		TAU,
		24,
		Color("#19E66F"),
		4.0
	)

# =========================================================
# PROFILE LOADED FROM SUPABASE
# =========================================================

func _on_profile_loaded_from_supabase(
	profile_name: String
) -> void:

	print("================================")
	print("👤 PROFILE CALLBACK RECEIVED")
	print("RAW PROFILE NAME:", profile_name)
	print("SUPABASE USER ID:", SupabaseAuth.user_id)
	print("================================")

	player_name = profile_name.strip_edges()

	if player_name.is_empty():
		print("⚠️ PROFILE NAME IS EMPTY")
		player_name = "PLAYER"

	player_id = SupabaseAuth.user_id

	print("================================")
	print("✅ FINAL PROFILE")
	print("PLAYER NAME:", player_name)
	print("PLAYER ID:", player_id)
	print("================================")

	var config := ConfigFile.new()

	config.set_value(
		"player",
		"name",
		player_name
	)

	config.set_value(
		"player",
		"id",
		player_id
	)

	var save_error := config.save(player_settings_file)

	print("PROFILE LOCAL SAVE RESULT:", save_error)

	load_my_score()

	queue_redraw()

# =========================================================
# GAME OVER SCREEN — POPUP OVER HOME SCREEN
# =========================================================

func draw_game_over_screen() -> void:

	var w: float = screen_size.x
	var h: float = screen_size.y

	# =====================================================
	# DARK OVERLAY
	# =====================================================

	# This does NOT replace the Home Screen.
	# It simply dims the Home Screen behind the popup.

	draw_rect(
		Rect2(Vector2.ZERO, screen_size),
		Color(0, 0, 0, 0.55)
	)

	# =====================================================
	# POPUP CARD
	# =====================================================

	var popup_width: float = w - 50.0

	# Keep the popup large enough for all your existing UI.
	var popup_height: float = min(
		600.0,
		h - safe_top - safe_bottom - 30.0
	)

	var popup_pos := Vector2(
		25.0,
		safe_top + (
			h - safe_top - safe_bottom - popup_height
		) / 2.0
	)

	var result_card := Rect2(
		popup_pos,
		Vector2(
			popup_width,
			popup_height
		)
	)

	# =====================================================
	# SHADOW
	# =====================================================

	draw_rounded_rect(
		Rect2(
			result_card.position + Vector2(0, 8),
			result_card.size
		),
		24.0,
		Color(0, 0, 0, 0.65)
	)

	# =====================================================
	# MAIN CARD
	# =====================================================

	draw_rounded_rect(
		result_card,
		24.0,
		Color("#111923")
	)

	# =====================================================
	# TOP GREEN ACCENT
	# =====================================================

	draw_rounded_rect(
		Rect2(
			result_card.position.x,
			result_card.position.y,
			result_card.size.x,
			7.0
		),
		4.0,
		Color("#19E66F")
	)

	# =====================================================
	# CLOSE X BUTTON
	# =====================================================

	var close_size: float = 48.0

	game_over_close_rect = Rect2(
		Vector2(
			result_card.end.x - close_size - 16.0,
			result_card.position.y + 16.0
		),
		Vector2(
			close_size,
			close_size
		)
	)

	# X button background

	draw_circle(
		game_over_close_rect.get_center(),
		23.0,
		Color("#202A38")
	)

	# X

	draw_string(
		ThemeDB.fallback_font,
		game_over_close_rect.get_center() + Vector2(-9.0, 10.0),
		"×",
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		30,
		Color.WHITE
	)

	# =====================================================
	# CARD VARIABLES
	# =====================================================

	var card_x: float = result_card.position.x
	var card_y: float = result_card.position.y
	var card_w: float = result_card.size.x
	var card_h: float = result_card.size.y

	# =====================================================
	# GAME OVER HEADER
	# =====================================================

	var header_y: float = card_y + 52.0

	draw_centered(
		"GAME OVER",
		Vector2(
			w / 2.0,
			header_y
		),
		30,
		Color("#FF3152")
	)

	draw_centered(
		"YOUR SCORE",
		Vector2(
			w / 2.0,
			header_y + 27.0
		),
		11,
		Color("#788190")
	)

	# =====================================================
	# BIG SCORE
	# =====================================================

	draw_centered(
		str(score),
		Vector2(
			w / 2.0,
			header_y + 92.0
		),
		62,
		Color.WHITE
	)

	# =====================================================
	# NEW BEST
	# =====================================================

	if new_best:

		draw_centered(
			"NEW BEST!",
			Vector2(
				w / 2.0,
				header_y + 116.0
			),
			13,
			Color("#FFD447")
		)

	else:

		draw_centered(
			"BEST  " + str(best_score),
			Vector2(
				w / 2.0,
				header_y + 116.0
			),
			12,
			Color("#788190")
		)

	# =====================================================
	# SCORE PROGRESS CARD
	# =====================================================

	var progress_card := Rect2(
		card_x + 20.0,
		header_y + 135.0,
		card_w - 40.0,
		82.0
	)

	draw_rounded_rect(
		progress_card,
		16.0,
		Color("#19222D")
	)

	draw_centered(
		"SCORE MILESTONES",
		Vector2(
			w / 2.0,
			progress_card.position.y + 19.0
		),
		9,
		Color("#697382")
	)

	# =====================================================
	# PROGRESS BAR
	# =====================================================

	var bar_x: float = progress_card.position.x + 28.0
	var bar_y: float = progress_card.position.y + 40.0
	var bar_w: float = progress_card.size.x - 56.0
	var bar_h: float = 7.0

	draw_rounded_rect(
		Rect2(
			bar_x,
			bar_y,
			bar_w,
			bar_h
		),
		4.0,
		Color("#303B48")
	)

	var progress: float = clamp(
		float(score) / 100.0,
		0.0,
		1.0
	)

	var progress_w: float = bar_w * progress

	if progress_w > 0.0:

		draw_rounded_rect(
			Rect2(
				bar_x,
				bar_y,
				progress_w,
				bar_h
			),
			4.0,
			Color("#19E66F")
		)

	# =====================================================
	# MILESTONE MARKERS
	# =====================================================

	var milestones := [10, 25, 50, 100]

	for milestone in milestones:

		var milestone_position: float = (
			float(milestone) / 100.0
		)

		var star_x: float = (
			bar_x +
			bar_w * milestone_position
		)

		var unlocked: bool = score >= milestone

		var marker_color := Color("#4B5663")

		if unlocked:

			marker_color = Color("#FFD447")

			draw_circle(
				Vector2(
					star_x,
					bar_y + bar_h / 2.0
				),
				9.0,
				Color(
					1.0,
					0.83,
					0.25,
					0.10
				)
			)

		draw_circle(
			Vector2(
				star_x,
				bar_y + bar_h / 2.0
			),
			5.5,
			marker_color
		)

		draw_centered(
			str(milestone),
			Vector2(
				star_x,
				bar_y + 15
			),
			8,
			marker_color
		)

	# =====================================================
	# BEST SCORE
	# =====================================================

	draw_centered(
		"BEST SCORE  •  " + str(best_score),
		Vector2(
			w / 2.0,
			progress_card.position.y + 73.0
		),
		9,
		Color("#788190")
	)

	# =====================================================
	# STATS
	# =====================================================

	var stats_y: float = progress_card.position.y + 94.0
	var stat_gap: float = 10.0

	var stat_w: float = (
		(card_w - 40.0 - stat_gap) / 2.0
	)

	var combo_card := Rect2(
		card_x + 20.0,
		stats_y,
		stat_w,
		66.0
	)

	var speed_card := Rect2(
		card_x + 20.0 + stat_w + stat_gap,
		stats_y,
		stat_w,
		66.0
	)

	# =====================================================
	# COMBO CARD
	# =====================================================

	draw_rounded_rect(
		combo_card,
		14.0,
		Color("#19222D")
	)

	draw_icon(
		ICON_FIRE,
		Vector2(
			combo_card.get_center().x - 30.0,
			stats_y + 21.0
		),
		16.0
	)

	draw_centered(
		"MAX COMBO",
		Vector2(
			combo_card.get_center().x + 8.0,
			stats_y + 24.0
		),
		9,
		Color("#788190")
	)

	draw_centered(
		str(max(max_combo, my_max_combo)),
		Vector2(
			combo_card.get_center().x,
			stats_y + 49.0
		),
		22,
		Color("#FFD447")
	)

	# =====================================================
	# SPEED CARD
	# =====================================================

	draw_rounded_rect(
		speed_card,
		14.0,
		Color("#19222D")
	)

	var final_speed: float = 1.0

	if reaction_time > 0.0:

		final_speed = 1.0 / reaction_time

	draw_icon(
		ICON_LIGHTNING,
		Vector2(
			speed_card.get_center().x - 25.0,
			stats_y + 21.0
		),
		16.0
	)

	draw_centered(
		"SPEED",
		Vector2(
			speed_card.get_center().x + 8.0,
			stats_y + 24.0
		),
		9,
		Color("#788190")
	)

	draw_centered(
		str(snappedf(final_speed, 0.1)) + "x",
		Vector2(
			speed_card.get_center().x,
			stats_y + 49.0
		),
		22,
		Color("#19E66F")
	)

	# =====================================================
	# CHALLENGE RESULT
	# =====================================================

	var challenge_y: float = stats_y + 90.0

	if challenge_active:

		if challenge_completed:

			draw_icon(
				ICON_FIRE,
				Vector2(
					w / 2.0 - 65.0,
					challenge_y - 5.0
				),
				18.0
			)

			draw_centered(
				"CHALLENGE BEAT!",
				Vector2(
					w / 2.0 + 10.0,
					challenge_y
				),
				16,
				Color("#19E66F")
			)

			draw_centered(
				"You beat " + str(challenge_score) + "!",
				Vector2(
					w / 2.0,
					challenge_y + 22.0
				),
				10,
				Color("#FFD447")
			)

		else:

			draw_centered(
				"BEAT " + str(challenge_score),
				Vector2(
					w / 2.0,
					challenge_y
				),
				16,
				Color("#FFD447")
			)

			draw_centered(
				"Try again!",
				Vector2(
					w / 2.0,
					challenge_y + 22.0
				),
				10,
				Color("#788190")
			)

	else:

		draw_centered(
			"CAN YOU BEAT " + str(score) + "?",
			Vector2(
				w / 2.0,
				challenge_y
			),
			14,
			Color.WHITE
		)

	# =====================================================
	# BUTTON LAYOUT
	# =====================================================

	var button_x: float = card_x + 20.0
	var button_w: float = card_w - 40.0

	# =====================================================
	# BEAT MY SCORE
	# =====================================================

	share_score_rect = Rect2(
		button_x,
		card_y + card_h - 205.0,
		button_w,
		45.0
	)

	draw_button(
		share_score_rect,
		"BEAT MY SCORE",
		Color("#FFD447"),
		"share",
		ICON_SHARE
	)

	# =====================================================
	# REVIVE
	# =====================================================

	if revive_available and not revive_used:

		revive_button_rect = Rect2(
			button_x,
			card_y + card_h - 150.0,
			button_w,
			42.0
		)

		draw_button(
			revive_button_rect,
			"CONTINUE",
			Color("#19E66F"),
			"revive",
			ICON_HEART
		)

	else:

		revive_button_rect = Rect2()

	# =====================================================
	# PLAY AGAIN
	# =====================================================

	play_again_rect = Rect2(
		button_x,
		card_y + card_h - 100.0,
		(button_w - 10.0) / 2.0,
		42.0
	)

	draw_button(
		play_again_rect,
		"AGAIN",
		Color("#19E66F"),
		"play",
		ICON_PLAY
	)

	# =====================================================
	# LEADERBOARD
	# =====================================================

	leaderboard_button_rect = Rect2(
		button_x + (button_w + 10.0) / 2.0,
		card_y + card_h - 100.0,
		(button_w - 10.0) / 2.0,
		42.0
	)

	draw_button(
		leaderboard_button_rect,
		"RANK",
		Color("#202A38"),
		"leaderboard",
		ICON_TROPHY
	)

	# =====================================================
	# FOOTER
	# =====================================================

	draw_centered(
		"DON'T TAP RED  •  ONE MORE TRY?",
		Vector2(
			w / 2.0,
			card_y + card_h - 25.0
		),
		9,
		Color("#596372")
	)


# =========================================================
# DRAW REVIVE PAGE
# =========================================================

func draw_revive_page() -> void:

	var w: float = screen_size.x
	var h: float = screen_size.y

	# =====================================================
	# DARK OVERLAY
	# =====================================================

	draw_rect(
		Rect2(
			Vector2.ZERO,
			screen_size
		),
		Color(0.02, 0.03, 0.05, 0.88)
	)

	# =====================================================
	# POPUP
	# =====================================================

	var popup_w: float = w - 40.0
	var popup_h: float = 330.0

	revive_page_rect = Rect2(
		20.0,
		(h - popup_h) / 2.0,
		popup_w,
		popup_h
	)

	# =====================================================
	# SHADOW
	# =====================================================

	draw_rounded_rect(
		Rect2(
			revive_page_rect.position + Vector2(0, 7),
			revive_page_rect.size
		),
		CARD_RADIUS,
		Color(0, 0, 0, 0.4)
	)

	# =====================================================
	# MAIN POPUP
	# =====================================================

	draw_rounded_rect(
		revive_page_rect,
		CARD_RADIUS,
		Color("#111923")
	)

	# =====================================================
	# TOP ACCENT
	# =====================================================

	draw_rounded_rect(
		Rect2(
			revive_page_rect.position.x,
			revive_page_rect.position.y,
			revive_page_rect.size.x,
			5
		),
		3,
		Color("#FFD447")
	)

	# =====================================================
	# TITLE
	# =====================================================

	draw_centered(
		"REVIVE!",
		Vector2(
			w / 2.0,
			revive_page_rect.position.y + 62
		),
		32,
		Color("#FFD447")
	)

	# =====================================================
	# HEART
	# =====================================================

	draw_icon(
		ICON_HEART,
		Vector2(
			w / 2.0,
			revive_page_rect.position.y + 112
		),
		38.0
	)

	# =====================================================
	# MESSAGE
	# =====================================================

	draw_centered(
		"YOU EARNED A SECOND CHANCE",
		Vector2(
			w / 2.0,
			revive_page_rect.position.y + 145
		),
		14,
		Color.WHITE
	)

	draw_centered(
		"Your score will continue.",
		Vector2(
			w / 2.0,
			revive_page_rect.position.y + 168
		),
		12,
		Color("#788190")
	)

	# =====================================================
	# CONTINUE
	# =====================================================

	revive_continue_rect = Rect2(
		revive_page_rect.position.x + 20,
		revive_page_rect.position.y + 190,
		revive_page_rect.size.x - 40,
		55
	)

	var revive_text := "CONTINUE"
	var revive_icon: Texture2D = ICON_HEART

	if revive_loading:
		revive_text = "LOADING AD..."
		revive_icon = null

	draw_button(
		revive_continue_rect,
		revive_text,
		Color("#FFD447"),
		"revive_continue",
		revive_icon
	)

	# =====================================================
	# PLAY AGAIN
	# =====================================================

	revive_play_again_rect = Rect2(
		revive_page_rect.position.x + 20,
		revive_page_rect.position.y + 260,
		revive_page_rect.size.x - 40,
		48
	)

	draw_button(
		revive_play_again_rect,
		"AGAIN",
		Color("#202A38"),
		"revive_play_again",
		ICON_PLAY
	)

# =========================================================
# BUTTON
# =========================================================

func draw_button(
	rect: Rect2,
	text: String,
	color: Color,
	button_id: String = "",
	icon: Texture2D = null,
	custom_text_color: Color = Color(0, 0, 0, 0)
) -> void:

	var is_pressed: bool = (
		button_id != "" and
		pressed_button == button_id and
		button_press_timer > 0.0
	)

	# -----------------------------------------------------
	# EASED PRESS PROGRESS
	# -----------------------------------------------------
	#
	# button_press_timer counts down linearly from 0.12 -> 0.
	# Easing it (cubic ease-out) makes the press read as a
	# quick, snappy "give" instead of a linear slide.

	var press_t: float = 0.0

	if is_pressed:

		var raw_t: float = clamp(
			1.0 - (button_press_timer / 0.12),
			0.0,
			1.0
		)

		press_t = 1.0 - pow(1.0 - raw_t, 3.0)

	# -----------------------------------------------------
	# PRESS EFFECT
	# -----------------------------------------------------

	var draw_rect := rect
	var draw_color := color

	if is_pressed:

		draw_rect.position.y += 4.0 * press_t
		draw_color = color.darkened(0.20 * press_t)

	# -----------------------------------------------------
	# CORNER RADIUS
	# -----------------------------------------------------
	#
	# Tabs and small chips get a slightly tighter radius
	# than full-width action buttons.

	var radius: float = BUTTON_RADIUS

	if draw_rect.size.y <= 40:
		radius = TAB_RADIUS

	# -----------------------------------------------------
	# SHADOW
	# -----------------------------------------------------

	var shadow_offset: float = lerp(4.0, 1.0, press_t)

	draw_rounded_rect(
		Rect2(
			draw_rect.position + Vector2(0, shadow_offset),
			draw_rect.size
		),
		radius,
		Color(0, 0, 0, 0.35)
	)

	# -----------------------------------------------------
	# BUTTON
	# -----------------------------------------------------

	draw_rounded_rect(
		draw_rect,
		radius,
		draw_color
	)

	# -----------------------------------------------------
	# TEXT COLOR
	# -----------------------------------------------------

	var text_color := Color("#07100B")

	if color == Color("#202A38"):
		text_color = Color.WHITE

	if custom_text_color.a > 0.0:
		text_color = custom_text_color

	if is_pressed:
		text_color = text_color.darkened(0.10 * press_t)

	# -----------------------------------------------------
	# TEXT SIZE
	# -----------------------------------------------------

	var font_size: int = 16

	# -----------------------------------------------------
	# PERFECT VERTICAL CENTER
	# -----------------------------------------------------

	var text_y: float = (
		draw_rect.position.y +
		(draw_rect.size.y / 2.0) +
		(font_size / 2.0) - 2.0
	)

	if icon != null:

		draw_icon_text(
			icon,
			text,
			Vector2(
				draw_rect.position.x + draw_rect.size.x / 2.0,
				draw_rect.position.y + draw_rect.size.y / 2.0
			),
			26.0,
			font_size,
			text_color
		)

	else:

		draw_centered(
			text,
			Vector2(
				draw_rect.position.x + draw_rect.size.x / 2.0,
				text_y
			),
			font_size,
			text_color
		)

# =========================================================
# FOUR CORNER MENU BUTTON
# =========================================================

func draw_corner_menu_button(
	rect: Rect2,
	icon: Texture2D,
	label: String,
	color: Color,
	button_id: String
) -> void:

	var is_pressed: bool = (
		pressed_button == button_id and
		button_press_timer > 0.0
	)

	var draw_rect := rect
	var draw_color := color

	# =====================================================
	# PRESS ANIMATION
	# =====================================================

	if is_pressed:

		draw_rect.position.y += 4.0
		draw_color = color.darkened(0.20)

	# =====================================================
	# SHADOW
	# =====================================================

	draw_rounded_rect(
		Rect2(
			draw_rect.position + Vector2(0, 5),
			draw_rect.size
		),
		18.0,
		Color(0, 0, 0, 0.40)
	)

	# =====================================================
	# BUTTON
	# =====================================================

	draw_rounded_rect(
		draw_rect,
		18.0,
		draw_color
	)

	# =====================================================
	# ICON
	# =====================================================

	var icon_color := Color.WHITE

	if color == Color("#19E66F"):
		icon_color = Color("#06100A")

	draw_icon(
		icon,
		Vector2(
			draw_rect.position.x + draw_rect.size.x / 2.0,
			draw_rect.position.y + 23.0
		),
		21.0
	)

	# =====================================================
	# LABEL
	# =====================================================

	var label_color := Color.WHITE

	if color == Color("#19E66F"):
		label_color = Color("#06100A")

	draw_centered(
		label,
		Vector2(
			draw_rect.position.x + draw_rect.size.x / 2.0,
			draw_rect.position.y + 51
		),
		10,
		label_color
	)

# =========================================================
# FINISH LOADING SCREEN
# =========================================================

func finish_loading_screen() -> void:

	if not show_loading_screen:
		return

	print("================================")
	print("✅ LOADING COMPLETE")
	print("================================")

	show_loading_screen = false

	loading_progress = 1.0

	# Go to home screen
	show_menu = true
	playing = false
	show_result = false
	show_revive_page = false
	show_leaderboard = false
	show_profile = false
	show_settings = false

	# Reset loading animation
	loading_time = 0.0
	loading_spinner_angle = 0.0

	# Existing transition system
	start_screen_transition()

	queue_redraw()

# =========================================================
# ANIMATED LOADING SCREEN
# =========================================================

func draw_loading_screen() -> void:

	var w: float = screen_size.x
	var h: float = screen_size.y

	var center_x: float = w / 2.0


	# =====================================================
	# BACKGROUND
	# =====================================================

	draw_rect(
		Rect2(
			Vector2.ZERO,
			screen_size
		),
		Color("#020304")
	)


	# =====================================================
	# GREEN / RED AMBIENT GLOW
	# =====================================================

	var pulse: float = (
		sin(loading_pulse) + 1.0
	) / 2.0


	# GREEN SIDE GLOW

	for i in range(8):

		var alpha: float = 0.025 * (8 - i)

		draw_circle(
			Vector2(
				-20.0 + i * 15.0,
				h * 0.48
			),
			120.0 + i * 35.0,
			Color(
				0.0,
				1.0,
				0.2,
				alpha
			)
		)


	# RED SIDE GLOW

	for i in range(8):

		var alpha: float = 0.025 * (8 - i)

		draw_circle(
			Vector2(
				w + 20.0 - i * 15.0,
				h * 0.48
			),
			120.0 + i * 35.0,
			Color(
				1.0,
				0.0,
				0.05,
				alpha
			)
		)


	# =====================================================
	# PARTICLES
	# =====================================================

	for i in range(34):

		var seed_value: float = float(i)

		var side: float

		if i % 2 == 0:
			side = -1.0
		else:
			side = 1.0


		var base_x: float

		if side < 0.0:
			base_x = w * 0.18
		else:
			base_x = w * 0.82


		var wave: float = sin(
			loading_particle_time * 1.8 +
			seed_value * 1.7
		)


		var wave_2: float = cos(
			loading_particle_time * 1.1 +
			seed_value
		)


		var x: float = (
			base_x +
			wave * 55.0 * side +
			seed_value * 2.0 * side
		)


		var y: float = (
			h * 0.15 +
			fmod(
				seed_value * 47.0 +
				loading_particle_time * (
					30.0 + seed_value
				),
				h * 0.70
			)
		)


		var particle_size: float = (
			1.0 +
			fmod(seed_value, 3.0)
		)


		var particle_alpha: float = (
			0.25 +
			0.35 * (
				(wave_2 + 1.0) / 2.0
			)
		)


		var particle_color: Color

		if side < 0.0:

			particle_color = Color(
				0.1,
				1.0,
				0.25,
				particle_alpha
			)

		else:

			particle_color = Color(
				1.0,
				0.05,
				0.08,
				particle_alpha
			)


		draw_circle(
			Vector2(x, y),
			particle_size,
			particle_color
		)


	# =====================================================
	# TITLE
	# =====================================================

	var title_y: float = h * 0.29


	draw_centered(
		"DON'T",
		Vector2(
			center_x,
			title_y
		),
		42,
		Color.WHITE
	)


	draw_centered(
		"TAP",
		Vector2(
			center_x,
			title_y + 48.0
		),
		42,
		Color.WHITE
	)


	draw_centered(
		"RED",
		Vector2(
			center_x,
			title_y + 100.0
		),
		46,
		Color("#FF151F")
	)


	# =====================================================
	# MAIN RING
	# =====================================================

	var ring_center := Vector2(
		center_x,
		h * 0.56
	)

	var ring_radius: float = min(
		w * 0.18,
		82.0
	)


	# Outer black glow

	draw_circle(
		ring_center,
		ring_radius + 12.0,
		Color(
			0.0,
			0.0,
			0.0,
			0.75
		)
	)


	# Green glow

	for i in range(5):

		draw_arc(
			ring_center,
			ring_radius + 4.0 + i * 3.0,
			PI,
			TAU,
			64,
			Color(
				0.1,
				1.0,
				0.25,
				0.04
			),
			4.0
		)


	# Red glow

	for i in range(5):

		draw_arc(
			ring_center,
			ring_radius + 4.0 + i * 3.0,
			0.0,
			PI,
			64,
			Color(
				1.0,
				0.05,
				0.08,
				0.04
			),
			4.0
		)


	# =====================================================
	# GREEN HALF
	# =====================================================

	draw_arc(
		ring_center,
		ring_radius,
		PI,
		TAU,
		80,
		Color("#19FF45"),
		7.0
	)


	# =====================================================
	# RED HALF
	# =====================================================

	draw_arc(
		ring_center,
		ring_radius,
		0.0,
		PI,
		80,
		Color("#FF2028"),
		7.0
	)


	# =====================================================
	# INNER BLACK CIRCLE
	# =====================================================

	draw_circle(
		ring_center,
		ring_radius * 0.76,
		Color("#050607")
	)


	# =====================================================
	# CENTER GREEN BUTTON
	# =====================================================

	var center_pulse: float = (
		sin(loading_pulse * 1.3) + 1.0
	) / 2.0


	var center_radius: float = (
		ring_radius * 0.25 +
		center_pulse * 3.0
	)


	# Green glow

	draw_circle(
		ring_center,
		center_radius + 10.0,
		Color(
			0.15,
			1.0,
			0.2,
			0.08
		)
	)


	draw_circle(
		ring_center,
		center_radius,
		Color("#48FF19")
	)


	draw_circle(
		ring_center,
		center_radius * 0.82,
		Color("#64FF25")
	)


	# =====================================================
	# TAP GREEN
	# =====================================================

	draw_centered(
		"TAP GREEN",
		Vector2(
			center_x,
			ring_center.y +
			ring_radius +
			42.0
		),
		23,
		Color("#46FF25")
	)


	# =====================================================
	# AVOID RED
	# =====================================================

	draw_centered(
		"AVOID RED",
		Vector2(
			center_x,
			ring_center.y +
			ring_radius +
			72.0
		),
		23,
		Color("#FF2028")
	)


	# =====================================================
	# LOADING SPINNER
	# =====================================================

	var spinner_center := Vector2(
		center_x,
		h * 0.84
	)

	var spinner_radius: float = 22.0


	# Outer spinner track

	draw_arc(
		spinner_center,
		spinner_radius,
		0.0,
		TAU,
		64,
		Color("#30343A"),
		5.0
	)


	# Rotating green segment

	var spinner_start: float = loading_spinner_angle

	var spinner_end: float = (
		loading_spinner_angle +
		PI * 0.65
	)


	draw_arc(
		spinner_center,
		spinner_radius,
		spinner_start,
		spinner_end,
		32,
		Color("#4DFF31"),
		5.0
	)


	# =====================================================
	# LOADING TEXT
	# =====================================================

	var dots_count: int = (
		int(loading_time * 3.0) % 4
	)

	var dots: String = ""

	for i in range(dots_count):
		dots += "."


	draw_centered(
		"LOADING" + dots,
		Vector2(
			center_x,
			spinner_center.y + 58.0
		),
		14,
		Color.WHITE
	)


	# =====================================================
	# PROGRESS
	# =====================================================

	var progress_width: float = min(
		w - 100.0,
		260.0
	)

	var progress_height: float = 3.0

	var progress_x: float = (
		center_x -
		progress_width / 2.0
	)

	var progress_y: float = (
		spinner_center.y +
		82.0
	)


	# Track

	draw_style_box(
		make_rounded_box(
			Color("#24282D"),
			2.0
		),
		Rect2(
			progress_x,
			progress_y,
			progress_width,
			progress_height
		)
	)


	# Progress

	var current_progress_width: float = (
		progress_width *
		loading_progress
	)


	if current_progress_width > 0.0:

		draw_style_box(
			make_rounded_box(
				Color("#19E66F"),
				2.0
			),
			Rect2(
				progress_x,
				progress_y,
				current_progress_width,
				progress_height
			)
		)

# =========================================================
# TEXT
# =========================================================

func draw_centered(
	text: String,
	position: Vector2,
	font_size: int,
	color: Color
) -> void:

	var font := ThemeDB.fallback_font

	var text_width: float = font.get_string_size(
		text,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		font_size
	).x

	draw_string(
		font,
		Vector2(
			position.x - text_width / 2,
			position.y
		),
		text,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		font_size,
		color
	)

func draw_icon(
	icon: Texture2D,
	position: Vector2,
	size: float
) -> void:

	if icon == null:
		return

	draw_texture_rect(
		icon,
		Rect2(
			position.x - size / 2.0,
			position.y - size / 2.0,
			size,
			size
		),
		false
	)

func draw_icon_text(
	icon: Texture2D,
	text: String,
	center: Vector2,
	icon_size: float,
	font_size: int,
	text_color: Color
) -> void:

	if icon == null:
		draw_centered(
			text,
			center,
			font_size,
			text_color
		)
		return

	var font := ThemeDB.fallback_font

	var text_width := font.get_string_size(
		text,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		font_size
	).x

	var gap := 8.0

	var total_width := (
		icon_size +
		gap +
		text_width
	)

	var start_x := center.x - total_width / 2.0

	draw_texture_rect(
		icon,
		Rect2(
			start_x,
			center.y - icon_size / 2.0,
			icon_size,
			icon_size
		),
		false
	)

	draw_string(
		font,
		Vector2(
			start_x +
			icon_size +
			gap,
			center.y +
			font_size / 2.0 - 2.0
		),
		text,
		HORIZONTAL_ALIGNMENT_LEFT,
		-1,
		font_size,
		text_color
	)

# =========================================================
# INPUT
# =========================================================

func _input(event: InputEvent) -> void:

	# =====================================================
	# SCREEN TOUCH
	# =====================================================

	if event is InputEventScreenTouch:

		var now := Time.get_ticks_msec()

		if event.pressed:

			if now - last_touch_time < 80:
				return

			last_touch_time = now

			# ---------------------------------------------
			# LEADERBOARD DRAG START
			# ---------------------------------------------

			if show_leaderboard:

				var list_top := safe_top + 155.0
				var list_bottom := (
					screen_size.y -
					safe_bottom -
					180.0
				)

				if (
					event.position.y >= list_top
					and
					event.position.y <= list_bottom
				):

					leaderboard_dragging = true
					leaderboard_last_y = event.position.y

			handle_tap(event.position)

		else:

			leaderboard_dragging = false

		return


	# =====================================================
	# SCREEN DRAG
	# =====================================================

	if event is InputEventScreenDrag:

		if show_leaderboard and leaderboard_dragging:

			var delta_y: float = (
				float(event.position.y) -
				float(leaderboard_last_y)
			)

			leaderboard_scroll -= delta_y

			leaderboard_last_y = float(event.position.y)

			queue_redraw()

		return


	# =====================================================
	# DESKTOP MOUSE
	# =====================================================

	if event is InputEventMouseButton:

		if OS.has_feature("mobile"):
			return

		if event.button_index != MOUSE_BUTTON_LEFT:
			return

		if not event.pressed:
			return

		handle_tap(event.position)

		return


	# =====================================================
	# DESKTOP DRAG
	# =====================================================

	if event is InputEventMouseMotion:

		if OS.has_feature("mobile"):
			return

		if show_leaderboard and leaderboard_dragging:

			var delta_y: float = (
				float(event.position.y) -
				float(leaderboard_last_y)
			)

			leaderboard_scroll -= delta_y

			leaderboard_last_y = float(event.position.y)

			queue_redraw()

		return

# =========================================================
# HANDLE TAP
# =========================================================

func handle_tap(position: Vector2) -> void:

	# =====================================================
	# HOME MENU
	# =====================================================

	if show_menu and not playing and not show_result:

			print("================================")
			print("🏠 HOME MENU TAP")
			print("POSITION:", position)
			print("DAILY:", daily_challenge_rect)
			print("RANK:", leaderboard_button_rect)
			print("PLAY:", play_button_rect)
			print("================================")

			# -------------------------------------------------
			# DAILY CHALLENGE
			# -------------------------------------------------

			if (
				not daily_completed
				and daily_challenge_rect.has_point(position)
			):

				print("🔥 HOME → DAILY CHALLENGE")

				start_daily_challenge()

				return

			# -------------------------------------------------
			# RANK
			# -------------------------------------------------

			if leaderboard_button_rect.has_point(position):

				print("🏆 HOME → RANK")

				button_pressed(
					"rank",
					"leaderboard"
				)

				return

			# -------------------------------------------------
			# PLAY
			# -------------------------------------------------

			if play_button_rect.has_point(position):

				print("▶ HOME → PLAY")

				button_pressed(
					"play",
					"start"
				)

				return

			# -------------------------------------------------
			# SETTINGS
			# -------------------------------------------------

			if settings_rect.has_point(position):

				print("⚙ HOME → SETTINGS")

				button_pressed(
					"settings",
					"settings"
				)

				return

			# -------------------------------------------------
			# PROFILE
			# -------------------------------------------------

			if global_profile_rect.has_point(position):

				print("👤 HOME → PROFILE")

				button_pressed(
					"profile",
					"profile"
				)

				return

			print("⚪ HOME TAP NOT ON BUTTON")

			return

	# =====================================================
	# GAME OVER POPUP INPUT
	# =====================================================

	if show_result:

		print("================================")
		print("GAME OVER TAP")
		print("POSITION:", position)
		print("CLOSE:", game_over_close_rect)
		print("SHARE:", share_score_rect)
		print("REVIVE:", revive_button_rect)
		print("AGAIN:", play_again_rect)
		print("RANK:", leaderboard_button_rect)
		print("================================")


		# -------------------------------------------------
		# CLOSE X
		# -------------------------------------------------

		if game_over_close_rect.has_point(position):

			print("❌ CLOSE GAME OVER")

			show_result = false
			show_revive_page = false
			playing = false
			show_menu = true

			queue_redraw()

			return


		# -------------------------------------------------
		# BEAT MY SCORE
		# -------------------------------------------------

		if share_score_rect.has_point(position):

			print("🔥 BEAT MY SCORE")

			button_pressed(
				"share",
				"share"
			)

			return


		# -------------------------------------------------
		# CONTINUE / REVIVE
		# -------------------------------------------------

		if revive_button_rect.has_point(position):

			print("❤️ CONTINUE / REVIVE")

			button_pressed(
				"revive",
				"revive"
			)

			return


		# -------------------------------------------------
		# AGAIN
		# -------------------------------------------------

		if play_again_rect.has_point(position):

			print("🎮 AGAIN")

			button_pressed(
				"play",
				"play"
			)

			return


		# -------------------------------------------------
		# RANK
		# -------------------------------------------------

		if leaderboard_button_rect.has_point(position):

			print("🏆 RANK")

			button_pressed(
				"leaderboard",
				"leaderboard"
			)

			return


		# -------------------------------------------------
		# DON'T ALLOW GAME TARGET INPUT
		# -------------------------------------------------

		return

	# =====================================================
	# UI ACTION IS ALREADY WAITING
	# =====================================================

	if ui_action_pending:

		print("⏳ UI ACTION PENDING - IGNORING TOUCH")

		return

	# =====================================================
	# REVIVE COUNTDOWN — IGNORE INPUT
	# =====================================================

	if revive_countdown_active:
		return

	var w: float = screen_size.x
	var h: float = screen_size.y

	# =====================================================
	# PROFILE SCREEN INPUT
	# =====================================================

	if show_profile:

		print("👤 PROFILE SCREEN TAP:", position)
		print("BACK RECT:", leaderboard_back_rect)

		# -------------------------------------------------
		# SETTINGS
		# -------------------------------------------------

		if settings_rect.has_point(position):

			print("⚙ PROFILE → SETTINGS")

			button_pressed(
				"settings",
				"settings"
			)

			return

		# -------------------------------------------------
		# PROFILE ICON
		# -------------------------------------------------

		if global_profile_rect.has_point(position):

			print("👤 PROFILE ICON PRESSED")

			return

		# -------------------------------------------------
		# BACK
		# -------------------------------------------------

		if leaderboard_back_rect.has_point(position):

			print("← PROFILE BACK")

			show_profile = false
			show_menu = true
			playing = false

			start_screen_transition()
			queue_redraw()

			return

		# Don't allow anything else
		return

	# =====================================================
	# SETTINGS SCREEN
	# =====================================================

	if show_settings:

		print("⚙ SETTINGS TAP:", position)
		print("LOGOUT RECT:", settings_logout_rect)
		print("BACK RECT:", settings_back_rect)

		# -------------------------------------------------
		# SOUND
		# -------------------------------------------------

		if sound_setting_rect.has_point(position):

			sound_enabled = not sound_enabled

			print(
				"🔊 SOUND:",
				sound_enabled
			)

			save_game_settings()
			queue_redraw()

			return

		# -------------------------------------------------
		# VIBRATION
		# -------------------------------------------------

		if vibration_setting_rect.has_point(position):

			vibration_enabled = not vibration_enabled

			print(
				"📳 VIBRATION:",
				vibration_enabled
			)

			if vibration_enabled and OS.has_feature("mobile"):

				Input.vibrate_handheld(20)

			save_game_settings()
			queue_redraw()

			return

		# -------------------------------------------------
		# DELETE ACCOUNT
		# -------------------------------------------------

		if settings_delete_account_rect.has_point(position):

			print("================================")
			print("🗑️ DELETE ACCOUNT PRESSED")
			print("================================")

			show_delete_account_confirmation()

			return

		# -------------------------------------------------
		# LOG OUT
		# -------------------------------------------------

		if settings_logout_rect.has_point(position):

			print("================================")
			print("🚪 SETTINGS LOGOUT PRESSED")
			print("================================")

			SupabaseAuth.logout()

			show_settings = false
			show_menu = false
			show_profile = false
			playing = false

			queue_redraw()

			await get_tree().create_timer(0.15).timeout

			get_tree().change_scene_to_file(
				"res://login.tscn"
			)

			return

		# -------------------------------------------------
		# BACK
		# -------------------------------------------------

		if settings_back_rect.has_point(position):

			print("← SETTINGS BACK")

			show_settings = false
			show_menu = true
			playing = false

			start_screen_transition()
			queue_redraw()

			return

		# Don't allow anything else
		return

	# =====================================================
	# GLOBAL SETTINGS / PROFILE
	# =====================================================

	if settings_rect.has_point(position):

		print("⚙ SETTINGS PRESSED")

		button_pressed(
			"settings",
			"settings"
		)

		return


	if global_profile_rect.has_point(position):

		print("👤 PROFILE ICON PRESSED")

		button_pressed(
			"profile",
			"profile"
		)

		return


	# =====================================================
	# NAME ENTRY
	# =====================================================

	if name_input_visible:

		var name_rect := Rect2(
			25,
			330,
			w - 50,
			50
		)

		if name_rect.has_point(position):

			if name_input != null:
				name_input.grab_focus()

			return


		var continue_rect := Rect2(
			25,
			400,
			w - 50,
			55
		)

		if continue_rect.has_point(position):

			button_pressed(

				"continue",
				"continue"
			)

			return

		return

	# =====================================================
	# LEADERBOARD SCREEN
	# =====================================================

	if show_leaderboard:

		print("🏆 LEADERBOARD INPUT:", position)

		# ---------------------------------------------
		# GLOBAL TAB
		# ---------------------------------------------

		if global_tab_rect.has_point(position):

			print("🌍 GLOBAL TAB PRESSED")

			leaderboard_daily_mode = false
			leaderboard_scroll = 0.0

			load_leaderboard()

			queue_redraw()

			return


		# ---------------------------------------------
		# DAILY TAB
		# ---------------------------------------------

		if daily_tab_rect.has_point(position):

			print("🔥 DAILY TAB PRESSED")

			leaderboard_daily_mode = true
			leaderboard_scroll = 0.0

			load_daily_leaderboard()

			queue_redraw()

			return


		# ---------------------------------------------
		# BACK
		# ---------------------------------------------

		if leaderboard_back_rect.has_point(position):

			print("← LEADERBOARD BACK PRESSED")

			button_pressed(
				"back",
				"back"
			)

			return


		# Nothing else on leaderboard
		return


	# =====================================================
	# PROFILE
	# =====================================================

	if profile_rect.has_point(position):

		print("👤 PROFILE PRESSED")

		if SupabaseAuth.user_id != "":
			player_id = SupabaseAuth.user_id

		show_profile = true
		show_menu = false
		playing = false

		if SupabaseAuth.user_id != "":
			SupabaseAuth.load_stats()

		load_my_score()

		start_screen_transition()
		queue_redraw()

		return

	# =========================================================
	# REVIVE PAGE TOUCH
	# =========================================================

	if show_revive_page:

		# -----------------------------------------------------
		# CONTINUE
		# -----------------------------------------------------

		if revive_continue_rect.has_point(position):

			print("================================")
			print("❤️ REVIVE CONTINUE PRESSED")
			print("================================")

			button_pressed(
				"revive_continue",
				"revive_continue"
			)

			return

		# -----------------------------------------------------
		# PLAY AGAIN
		# -----------------------------------------------------

		if revive_play_again_rect.has_point(position):

			print("▶ REVIVE PAGE → PLAY AGAIN")

			button_pressed(
				"revive_play_again",
				"revive_play_again"
			)

			return

		return

	# =====================================================
	# SAFETY — UI SCREENS NEVER REACH GAME TARGET
	# =====================================================

	if show_menu:
		return

	if show_leaderboard:
		return

	if show_profile:
		return

	if show_result:
		return


	# =====================================================
	# TARGET
	# =====================================================

	var center := Vector2(
		w / 2.0,
		h / 2.0 - 30.0
	)

	var radius: float = (
		target_radius *
		scale_factor *
		target_scale
	)

	if target_pop > 0.0:

		radius += 18.0 * target_pop


	# =====================================================
	# MOBILE TOUCH AREA
	# =====================================================

	var touch_radius: float = radius

	if OS.has_feature("mobile"):

		touch_radius += 20.0 * scale_factor


	var distance: float = position.distance_to(center)


	print(
		"TARGET TAP | ",
		"position=", position,
		" center=", center,
		" distance=", distance,
		" touch_radius=", touch_radius,
		" green=", current_is_green,
		" timer=", timer
	)


	# =====================================================
	# OUTSIDE TARGET
	# =====================================================

	if distance > touch_radius:

		print("⚪ OUTSIDE TARGET")

		return


	# =====================================================
	# GREEN
	# =====================================================

	if current_is_green:

		print("🟢 GREEN TAP → SUCCESS")

		success()

		return


	# =====================================================
	# RED
	# =====================================================

	print("🔴 RED TAP → GAME OVER")

	game_over()

	return

# =========================================================
# START GAME AFTER REVIVE
# =========================================================

func start_revive_after_reward() -> void:

	if revive_used:

		print("❌ REVIVE ALREADY USED")
		return

	if not revive_reward_earned:

		print("❌ REVIVE REWARD NOT EARNED")
		return

	complete_revive()

func _open_challenge(score: int) -> void:

	var challenge_url := \
		"https://donttapred-web.vercel.app/challenge?score=" \
		+ str(score)

	print("================================")
	print("🔥 BEAT MY SCORE")
	print("SCORE:", score)
	print("🔗 CHALLENGE:", challenge_url)
	print("================================")

	OS.shell_open(challenge_url)

# =========================================================
# SETTINGS SCREEN
# =========================================================

func draw_settings_screen() -> void:

	var w: float = screen_size.x
	var h: float = screen_size.y

	# =====================================================
	# BACKGROUND
	# =====================================================

	draw_rect(
		Rect2(
			Vector2.ZERO,
			screen_size
		),
		Color("#070A0F")
	)

	# =====================================================
	# GLOBAL NAVIGATION
	# =====================================================

	draw_global_navigation()

	# =====================================================
	# TITLE
	# =====================================================

	draw_centered(
		"SETTINGS",
		Vector2(
			w / 2.0,
			safe_top + 78
		),
		28,
		Color.WHITE
	)

	draw_centered(
		"GAME OPTIONS",
		Vector2(
			w / 2.0,
			safe_top + 101
		),
		9,
		Color("#697382")
	)

	# =====================================================
	# SETTINGS CARD
	# =====================================================

	var card := Rect2(
		20,
		safe_top + 135,
		w - 40,
		330
	)

	draw_rounded_rect(
		card,
		18.0,
		Color("#111923")
	)

	# =====================================================
	# SOUND EFFECTS
	# =====================================================

	sound_setting_rect = Rect2(
		card.position.x + 15,
		card.position.y + 15,
		card.size.x - 30,
		58
	)

	draw_setting_row(
		sound_setting_rect,
		ICON_SOUND,
		"SOUND EFFECTS",
		sound_enabled
	)

	# =====================================================
	# VIBRATION
	# =====================================================

	vibration_setting_rect = Rect2(
		card.position.x + 15,
		card.position.y + 82,
		card.size.x - 30,
		58
	)

	draw_setting_row(
		vibration_setting_rect,
		ICON_VIBRATION,
		"VIBRATION",
		vibration_enabled
	)

	# =====================================================
	# ACCOUNT
	# =====================================================

	var account_rect := Rect2(
		card.position.x + 15,
		card.position.y + 149,
		card.size.x - 30,
		45
	)

	draw_rounded_rect(
		account_rect,
		11.0,
		Color("#19222D")
	)

	draw_centered(
		"ACCOUNT",
		Vector2(
			account_rect.position.x + 65,
			account_rect.position.y + 29
		),
		11,
		Color("#788190")
	)

	var account_text := "SIGNED IN"

	if SupabaseAuth.user_id == "":
		account_text = "GUEST"

	draw_centered(
		account_text,
		Vector2(
			account_rect.end.x - 65,
			account_rect.position.y + 29
		),
		10,
		Color("#19E66F")
	)

	# =====================================================
	# DELETE ACCOUNT
	# =====================================================

	settings_delete_account_rect = Rect2(
		card.position.x + 15,
		card.position.y + 205,
		card.size.x - 30,
		45
	)

	draw_button(
		settings_delete_account_rect,
		"DELETE ACCOUNT",
		Color("#19222D"),
		"delete_account",
		null,
		Color("#FF3152")
	)

	# =====================================================
	# LOG OUT
	# =====================================================

	settings_logout_rect = Rect2(
		card.position.x + 15,
		card.position.y + 260,
		card.size.x - 30,
		45
	)

	draw_button(
		settings_logout_rect,
		"LOG OUT",
		Color("#19222D"),
		"logout",
		null,
		Color("#FF3152")
	)

	# =====================================================
	# APP INFORMATION
	# =====================================================

	draw_centered(
		"DON'T TAP RED",
		Vector2(
			w / 2.0,
			safe_top + 490
		),
		13,
		Color("#697382")
	)

	draw_centered(
		"VERSION 1.0",
		Vector2(
			w / 2.0,
			safe_top + 510
		),
		9,
		Color("#3F4854")
	)

	# =====================================================
	# BACK BUTTON
	# =====================================================

	settings_back_rect = Rect2(
		40,
		h - safe_bottom - 65.0,
		w - 80,
		50
	)

	draw_button(
		settings_back_rect,
		"← BACK",
		Color("#202A38"),
		"settings_back"
	)

# =========================================================
# SETTINGS ROW
# =========================================================

func draw_setting_row(
	rect: Rect2,
	icon: Texture2D,
	title: String,
	enabled: bool
) -> void:

	draw_rounded_rect(
		rect,
		12.0,
		Color("#19222D")
	)

	# =====================================================
	# ICON
	# =====================================================

	if icon != null:
		var icon_rect := Rect2(
			rect.position.x + 18,
			rect.position.y + 18,
			36,
			36
		)

		draw_texture_rect(
			icon,
			icon_rect,
			false
		)

	# =====================================================
	# TITLE
	# =====================================================

	draw_centered(
		title,
		Vector2(
			rect.position.x + 120,
			rect.position.y + 36
		),
		12,
		Color.WHITE
	)

	# =====================================================
	# TOGGLE
	# =====================================================

	var toggle_w: float = 48.0
	var toggle_h: float = 26.0

	var toggle_rect := Rect2(
		rect.end.x - toggle_w - 10,
		rect.position.y + 16,
		toggle_w,
		toggle_h
	)

	var toggle_color := Color("#303B48")

	if enabled:
		toggle_color = Color("#19E66F")

	draw_rounded_rect(
		toggle_rect,
		toggle_h / 2.0,
		toggle_color
	)

	# =====================================================
	# TOGGLE KNOB
	# =====================================================

	var knob_x: float

	if enabled:

		knob_x = toggle_rect.end.x - 13

	else:

		knob_x = toggle_rect.position.x + 13

	draw_circle(
		Vector2(
			knob_x,
			toggle_rect.get_center().y
		),
		9.0,
		Color.WHITE
	)
# =========================================================
# BUTTON STYLE HELPER
# =========================================================

func _create_button_style(color: Color, _rect: Rect2 = Rect2()) -> StyleBoxFlat:

	var style := StyleBoxFlat.new()

	style.bg_color = color

	style.corner_radius_top_left = 12
	style.corner_radius_top_right = 12
	style.corner_radius_bottom_left = 12
	style.corner_radius_bottom_right = 12

	style.border_width_left = 1
	style.border_width_top = 1
	style.border_width_right = 1
	style.border_width_bottom = 1

	style.border_color = color.lightened(0.15)

	style.content_margin_left = 10
	style.content_margin_right = 10
	style.content_margin_top = 10
	style.content_margin_bottom = 10

	return style

# =========================================================
# START GAME
# =========================================================

func start_game() -> void:

	# Reset one-shot game-over protection for this new game.
	game_over_processed = false

	# =====================================================
	# PROFILE STATS MUST BE LOADED FIRST
	# =====================================================

	if SupabaseAuth.user_id != "" and not cloud_stats_loaded:

		print("⏳ CLOUD STATS NOT READY")
		print("☁️ LOADING CLOUD STATS")

		SupabaseAuth.load_stats()

		return

	games_played += 1

	save_profile_stats()

	randomize()

	daily_active = false
	last_game_was_daily = false

	challenge_active = false
	challenge_completed = false
	challenge_score = 0

	score = 0
	combo = 0
	max_combo = 0

	revive_available = true
	revive_used = false
	revive_reward_earned = false

	playing = true
	show_menu = false
	show_result = false
	new_best = false
	fake_out = false

	reaction_time = 1.0
	timer = 1.0

	target_scale = 1.0

	change_color()

	if rewarded_ad == null or not rewarded_loaded:
		load_rewarded_ad()

	start_screen_transition()

	queue_redraw()

# =========================================================
# REVIVE - SHOW REWARDED AD
# =========================================================

func revive_game() -> void:

	if revive_used:
		print("❌ REVIVE ALREADY USED")
		return

	print("❤️ REVIVE PRESSED")

	if rewarded_ad == null or not rewarded_loaded:

		print("⚠️ REWARDED AD NOT READY")

		revive_loading = true

		load_rewarded_ad()

		queue_redraw()

		return

	print("📺 SHOWING REWARDED AD")

	revive_loading = false
	revive_reward_earned = false

	rewarded_ad.show(
		revive_reward_listener
	)

# =========================================================
# COMPLETE REVIVE
# =========================================================

func complete_revive() -> void:

	if revive_used:

		print("❌ REVIVE ALREADY USED")
		return

	print("================================")
	print("🎁 REWARD CONFIRMED")
	print("❤️ REVIVING GAME")
	print("SCORE PRESERVED:", score)
	print("================================")

	revive_reward_earned = true

	# =====================================================
	# CONSUME REVIVE
	# =====================================================

	revive_used = true
	revive_available = false

	# =====================================================
	# CLOSE ALL UI SCREENS
	# =====================================================

	show_result = false
	show_revive_page = false
	show_menu = false
	show_leaderboard = false
	show_profile = false
	show_settings = false

	# =====================================================
	# RESET COMBO
	# =====================================================

	combo = 0

	# =====================================================
	# START FRESH GREEN TARGET
	# =====================================================

	current_is_green = true
	fake_out = false

	timer = reaction_time
	target_scale = 1.0
	target_pop = 0.0
	scale_factor = 1.0

	# =====================================================
	# REVIVE COUNTDOWN — DON'T RESUME INPUT YET
	# =====================================================

	playing = false

	revive_countdown_active = true
	revive_countdown_value = 3
	revive_countdown_timer = REVIVE_COUNTDOWN_STEP

	# =====================================================
	# CLEAR GAME OVER EFFECT
	# =====================================================

	flash_color = Color("#FFD447")
	flash_alpha = 0.15

	shake_strength = 0.0
	game_over_effect = 0.0

	# =====================================================
	# IMPORTANT
	# =====================================================

	revive_reward_earned = false

	# A revived run may legitimately end again.
	game_over_processed = false

	# DO NOT call start_screen_transition() here.
	# We are already continuing the current game.

	queue_redraw()

# =====================================================
# DELETE ACCOUNT CONFIRMATION
# =====================================================

func show_delete_account_confirmation() -> void:

	print("🗑️ SHOW DELETE ACCOUNT CONFIRMATION")

	if delete_account_dialog == null:

		delete_account_dialog = ConfirmationDialog.new()

		delete_account_dialog.title = "Delete Account"

		delete_account_dialog.dialog_text = (
			"This will permanently delete your account "
			+ "and associated game data.\n\n"
			+ "This action cannot be undone."
		)

		delete_account_dialog.ok_button_text = "DELETE"
		delete_account_dialog.cancel_button_text = "CANCEL"

		add_child(delete_account_dialog)

		delete_account_dialog.confirmed.connect(
			_on_delete_account_confirmed
		)

	delete_account_dialog.popup_centered(
		Vector2(420, 240)
	)

# =====================================================
# DELETE ACCOUNT CONFIRMED
# =====================================================

func _on_delete_account_confirmed() -> void:

	print("================================")
	print("🗑️ DELETE ACCOUNT CONFIRMED")
	print("================================")

	if SupabaseAuth.user_id.is_empty():

		print("❌ DELETE ACCOUNT: USER NOT SIGNED IN")

		return

	account_delete_in_progress = true

	print(
		"👤 DELETING USER:",
		SupabaseAuth.user_id
	)

	SupabaseAuth.delete_account()

# =====================================================
# ACCOUNT DELETED SUCCESSFULLY
# =====================================================

func _on_account_deleted() -> void:

	if not account_delete_in_progress:
		return

	print("================================")
	print("✅ ACCOUNT DELETED SUCCESSFULLY")
	print("================================")

	account_delete_in_progress = false

	show_settings = false
	show_menu = false
	show_profile = false
	show_leaderboard = false
	playing = false
	show_result = false
	show_revive_page = false

	queue_redraw()

	await get_tree().create_timer(0.2).timeout

	get_tree().change_scene_to_file(
		"res://login.tscn"
	)

# =========================================================
# START DAILY CHALLENGE
# =========================================================

func start_daily_challenge() -> void:

	if daily_completed:

		print("❌ DAILY CHALLENGE IS LOCKED")
		return

	print("================================")
	print("🔥 STARTING DAILY CHALLENGE")
	print("📅 DATE:", get_today_date())
	print("================================")

	# Reset one-shot game-over protection for this new daily game.
	game_over_processed = false

	# =====================================================
	# IMPORTANT — THIS IS A DAILY GAME
	# =====================================================

	daily_active = true
	last_game_was_daily = true

	# Daily is NOT a friend challenge
	challenge_active = false
	challenge_completed = false
	challenge_score = 0

	# =====================================================
	# CLOSE ALL SCREENS
	# =====================================================

	show_menu = false
	show_result = false
	show_revive_page = false
	show_leaderboard = false
	show_profile = false
	show_settings = false

	# =====================================================
	# START GAME
	# =====================================================

	playing = true

	score = 0
	combo = 0
	max_combo = 0

	reaction_time = 1.0

	current_is_green = true
	fake_out = false

	target_scale = 1.0
	target_pop = 0.0

	timer = reaction_time

	change_color()

	queue_redraw()

# =========================================================
# COMPLETE DAILY CHALLENGE
# =========================================================

func complete_daily_challenge() -> void:

	daily_completed = true

	daily_completed_date = get_today_date()

	daily_date = daily_completed_date

	save_daily_state()

	print("================================")
	print("🔥 DAILY CHALLENGE COMPLETED")
	print("📅 DATE:", daily_completed_date)
	print("🏆 SCORE:", daily_best)
	print("================================")

	queue_redraw()

# =========================================================
# DAILY STATE
# =========================================================

func save_daily_state() -> void:

	var config := ConfigFile.new()

	config.set_value(
		"daily",
		"completed_date",
		daily_completed_date
	)

	config.set_value(
		"daily",
		"best",
		daily_best
	)

	config.save(DAILY_SAVE_PATH)


func load_daily_state() -> void:

	var config := ConfigFile.new()

	if config.load(DAILY_SAVE_PATH) == OK:

		daily_completed_date = str(
			config.get_value(
				"daily",
				"completed_date",
				""
			)
		)

		daily_best = int(
			config.get_value(
				"daily",
				"best",
				0
			)
		)

	else:

		daily_completed_date = ""
		daily_best = 0

	check_daily_challenge()


func get_today_date() -> String:

	return Time.get_date_string_from_system()

# =========================================================
# DAILY CHALLENGE — 7 DAY COOLDOWN
# =========================================================

func check_daily_challenge() -> void:

	var today: String = get_today_date()

	# No previous completion
	if daily_completed_date == "":

		daily_completed = false
		daily_date = today

		print("🔥 DAILY AVAILABLE")

		return


	var completed_time: int = Time.get_unix_time_from_datetime_string(
		daily_completed_date + "T00:00:00"
	)

	var today_time: int = Time.get_unix_time_from_datetime_string(
		today + "T00:00:00"
	)

	var days_passed: int = int(
		(today_time - completed_time) / 86400
	)


	# =====================================================
	# LESS THAN 7 DAYS
	# =====================================================

	if days_passed < DAILY_COOLDOWN_DAYS:

		daily_completed = true

		print("🔥 DAILY CHALLENGE LOCKED")
		print("📅 COMPLETED:", daily_completed_date)
		print("📅 DAYS PASSED:", days_passed)
		print("⏳ DAYS LEFT:", DAILY_COOLDOWN_DAYS - days_passed)

	else:

		# =================================================
		# 7 DAYS PASSED
		# =================================================

		daily_completed = false
		daily_date = today

		print("🔥 DAILY CHALLENGE AVAILABLE AGAIN")

func _on_stats_loaded_from_supabase(
	cloud_games_played: int,
	cloud_max_combo: int,
	cloud_daily_best: int,
	cloud_achievements: Array
) -> void:

	print("================================")
	print("☁️ SUPABASE PROFILE STATS RECEIVED")
	print("CLOUD GAMES:", cloud_games_played)
	print("CLOUD MAX COMBO:", cloud_max_combo)
	print("CLOUD DAILY BEST:", cloud_daily_best)
	print("CLOUD ACHIEVEMENTS:", cloud_achievements)
	print("================================")

	# =====================================================
	# MERGE CLOUD + LOCAL STATS
	# =====================================================

	var local_games_played: int = games_played
	var local_max_combo: int = all_time_max_combo
	var local_daily_best: int = daily_my_best

	# -----------------------------------------------------
	# GAMES PLAYED
	# -----------------------------------------------------

	games_played = max(
		local_games_played,
		cloud_games_played
	)

	# -----------------------------------------------------
	# MAX COMBO
	# -----------------------------------------------------

	all_time_max_combo = max(
		local_max_combo,
		cloud_max_combo
	)

	# -----------------------------------------------------
	# DAILY BEST
	# -----------------------------------------------------

	daily_my_best = max(
		local_daily_best,
		cloud_daily_best
	)

	# -----------------------------------------------------
	# ACHIEVEMENTS
	# -----------------------------------------------------

	for achievement in cloud_achievements:

		if not achievements_unlocked.has(achievement):

			achievements_unlocked.append(achievement)

	# =====================================================
	# CLOUD STATS ARE NOW LOADED
	# =====================================================

	cloud_stats_loaded = true

	print("================================")
	print("☁️ MERGED PROFILE STATS")
	print("GAMES:", games_played)
	print("MAX COMBO:", all_time_max_combo)
	print("DAILY BEST:", daily_my_best)
	print("ACHIEVEMENTS:", achievements_unlocked)
	print("================================")

	# =====================================================
	# LOCAL CACHE
	# =====================================================

	save_profile_stats_local_only()

	# =====================================================
	# PUSH HIGHER LOCAL VALUES TO CLOUD
	# =====================================================

	if (
		all_time_max_combo > cloud_max_combo
		or daily_my_best > cloud_daily_best
		or games_played > cloud_games_played
		or achievements_unlocked.size() > cloud_achievements.size()
	):

		print("☁️ LOCAL DATA IS HIGHER — UPLOADING MERGED STATS")

		save_profile_stats()

	# =====================================================
	# REFRESH PROFILE UI
	# =====================================================
	load_my_score()
	queue_redraw()

func save_profile_stats_local_only() -> void:

	if profile_stats_file.is_empty():
		return

	var config := ConfigFile.new()

	config.set_value(
		"profile",
		"games_played",
		games_played
	)

	config.set_value(
		"profile",
		"max_combo",
		all_time_max_combo
	)

	config.set_value(
		"profile",
		"daily_best",
		daily_my_best
	)

	config.set_value(
		"profile",
		"achievements",
		achievements_unlocked
	)

	config.save(profile_stats_file)

# =========================================================
# SUCCESS
# =========================================================

func success() -> void:

	score += 1
	combo += 1

	play_tap_sound()

	# =====================================================
	# DAILY BEST
	# =====================================================
	if daily_active:
		if score > daily_best:
			daily_best = score

	# =====================================================
	# MILESTONES
	# =====================================================

	if combo == 10:

		milestone_text = "10 COMBO!"
		milestone_timer = 1.0

	elif combo == 20:

		milestone_text = "20 COMBO!"
		milestone_timer = 1.2

	elif combo == 50:

		milestone_text = "50 COMBO!"
		milestone_timer = 1.5

	elif score == 25:

		milestone_text = "FAST!"
		milestone_timer = 1.0

	elif score == 50:

		milestone_text = "INSANE!"
		milestone_timer = 1.2

	elif score == 100:

		milestone_text = "UNSTOPPABLE!"
		milestone_timer = 1.5

	if combo > max_combo:

		max_combo = combo

	if max_combo > all_time_max_combo:

		all_time_max_combo = max_combo

	# Always check achievements
	check_achievements()

	# Save updated cloud profile stats
	save_profile_stats()

	# Difficulty

	if score < 10:

		reaction_time = 1.0

	elif score < 20:

		reaction_time = 0.85

	elif score < 30:

		reaction_time = 0.70

	elif score < 50:

		reaction_time = 0.55

	elif score < 75:

		reaction_time = 0.42

	elif score < 100:

		reaction_time = 0.32

	elif score < 150:

		reaction_time = 0.25

	else:

		reaction_time = 0.20

	# Hit effect

	target_scale = 1.10

	if combo >= 10:

		shake_strength = min(
			3.0 + combo * 0.15,
			12.0
		)

	else:

		shake_strength = 2.0

	flash_color = Color("#19E66F")
	flash_alpha = 0.10

	spawn_particles(
		Vector2(
			screen_size.x / 2,
			screen_size.y / 2 - 30
		),
		Color("#19E66F")
	)

	# Vibration

	if OS.has_feature("mobile") and vibration_enabled:

		Input.vibrate_handheld(15)

	# Fake out

	if score >= 20 and score % 17 == 0:

		fake_out = true
		fake_timer = 0.22

		current_is_green = false

		timer = fake_timer

		queue_redraw()

		return

	tap_effect = 1.0
	target_pop = 1.0

	if combo >= 2:
		combo_effect = 1.0

	change_color()


# =========================================================
# CHANGE COLOR
# =========================================================

func change_color() -> void:

	var green_chance: float = 0.68


	if score >= 25:

		green_chance = 0.63


	if score >= 50:

		green_chance = 0.58


	if score >= 100:

		green_chance = 0.52


	current_is_green = randf() < green_chance


	# -----------------------------------------------------
	# IMPORTANT
	# -----------------------------------------------------

	# Every new target gets a fresh timer.

	timer = reaction_time


	print(
		"=============================="
	)

	print(
		"NEW TARGET"
	)

	print(
		"GREEN:",
		current_is_green
	)

	print(
		"REACTION:",
		reaction_time
	)

	print(
		"TIMER:",
		timer
	)

	print(
		"=============================="
	)


	queue_redraw()

# =========================================================
# LOAD SETTINGS
# =========================================================

func load_game_settings() -> void:

	var config := ConfigFile.new()

	if config.load(SETTINGS_FILE) == OK:

		sound_enabled = bool(
			config.get_value(
				"settings",
				"sound_enabled",
				true
			)
		)

		vibration_enabled = bool(
			config.get_value(
				"settings",
				"vibration_enabled",
				true
			)
		)

	print("================================")
	print("⚙ GAME SETTINGS LOADED")
	print("SOUND:", sound_enabled)
	print("VIBRATION:", vibration_enabled)
	print("================================")

# =========================================================
# SAVE SETTINGS
# =========================================================

func save_game_settings() -> void:

	var config := ConfigFile.new()

	config.set_value(
		"settings",
		"sound_enabled",
		sound_enabled
	)

	config.set_value(
		"settings",
		"vibration_enabled",
		vibration_enabled
	)

	var error := config.save(SETTINGS_FILE)

	print(
		"⚙ SETTINGS SAVED:",
		error
	)

# =========================================================
# GAME OVER
# =========================================================

func game_over() -> void:

	# Guard against duplicate signals/taps causing multiple submissions.
	if game_over_processed:
		print("⚠️ GAME OVER ALREADY PROCESSED")
		return

	game_over_processed = true

	var was_daily_game: bool = daily_active

	playing = false

	# =====================================================
	# DAILY / NORMAL SCORE SUBMISSION
	# =====================================================

	if daily_active:

		print("🔥 DAILY CHALLENGE GAME OVER")
		print("DAILY SCORE:", score)

		if score > daily_best:

			daily_best = score
			daily_completed = true
			
			daily_my_best = daily_best
			save_profile_stats()

			print("🏆 NEW DAILY BEST:", daily_best)

		submit_daily_score()
		complete_daily_challenge()

		# End this particular Daily attempt.
		# last_game_was_daily remains true,
		# so PLAY AGAIN starts another Daily Challenge.
		daily_active = false

	else:

		print("🎮 NORMAL GAME OVER")
		print("NORMAL SCORE:", score)

	# =====================================================
	# LEADERBOARD SCORE SUBMISSION
	# =====================================================

	# Every normal game should submit the score.
	# Challenge games also submit the score.

	if score > 0 and not was_daily_game:

		print("================================")
		print("🏆 SUBMITTING GLOBAL LEADERBOARD SCORE")
		print("PLAYER NAME:", player_name)
		print("PLAYER ID:", player_id)
		print("SCORE:", score)
		print("MAX COMBO:", max_combo)
		print("CHALLENGE:", challenge_active)
		print("================================")

		submit_score()

	elif was_daily_game:

		print("ℹ️ DAILY SCORE NOT SUBMITTED TO GLOBAL LEADERBOARD")


	# =====================================================
	# CHALLENGE RESULT
	# =====================================================

	if challenge_active:

		if score > challenge_score:

			challenge_completed = true

			print("🔥 CHALLENGE BEAT!")
			print("TARGET:", challenge_score)
			print("SCORE:", score)

		else:

			challenge_completed = false

			print("❌ CHALLENGE NOT BEAT")
			print("TARGET:", challenge_score)
			print("SCORE:", score)

	# =====================================================
	# FRIEND CHALLENGE RESULT
	# =====================================================

	if challenge_active:

		if score > challenge_score:

			challenge_completed = true

			milestone_text = "YOU BEAT THE CHALLENGE!"

		else:

			challenge_completed = false

			milestone_text = (
				"TRY AGAIN — BEAT " +
				str(challenge_score)
			)

		milestone_timer = 2.0


	# =====================================================
	# GAME OVER EFFECTS
	# =====================================================

	play_game_over_sound()

	new_best = false

	if score > best_score:

		best_score = score

		new_best = true
		best_effect = 1.0

		save_best_score()

		# Check score achievements
		check_achievements()

		# Save cloud profile
		save_profile_stats()

	current_is_green = false

	target_scale = 1.0

	shake_strength = 10.0

	game_over_effect = 1.0

	flash_color = Color("#FF3152")

	flash_alpha = 0.22

	spawn_particles(
		Vector2(
			screen_size.x / 2,
			screen_size.y / 2 - 30
		),
		Color("#FF3152")
	)

	if OS.has_feature("mobile") and vibration_enabled:

		print("📳 GAME OVER HAPTIC")

		Input.vibrate_handheld(
			100,
			0.8
		)


	share_message = (
		"I scored " +
		str(score) +
		" in DON'T TAP RED. " +
		"Can you beat me?"
	)

	show_menu = true
	show_result = true

	result_timer = 999999.0

	print("========== GAME OVER STATE ==========")

	print("show_menu:", show_menu)

	print("show_result:", show_result)

	print("playing:", playing)

	print("====================================")

	start_screen_transition()

	queue_redraw()

func setup_daily_seed() -> void:

	daily_date_key = Time.get_date_string_from_system()

	var hash_value := daily_date_key.hash()

	daily_seed = abs(hash_value)

	daily_random.seed = daily_seed

	print("================================")
	print("🔥 DAILY CHALLENGE")
	print("DATE:", daily_date_key)
	print("SEED:", daily_seed)
	print("================================")

func play_tap_sound() -> void:

	if not sound_enabled:

		return

	if not has_node("TapSound"):

		print("❌ TapSound node missing")

		return

	var sound := get_node("TapSound")

	if not sound is AudioStreamPlayer:

		print("❌ TapSound is not AudioStreamPlayer")

		return

	if sound.stream == null:

		print("❌ TapSound has no audio stream")

		return

	sound.play()


func play_game_over_sound() -> void:

	if not sound_enabled:

		return

	if not has_node("GameOverSound"):

		print("❌ GameOverSound node missing")

		return

	var sound := get_node("GameOverSound")

	if not sound is AudioStreamPlayer:

		print("❌ GameOverSound is not AudioStreamPlayer")

		return

	if sound.stream == null:

		print("❌ GameOverSound has no audio stream")

		return

	sound.play()

# =========================================================
# NAME ENTRY
# =========================================================

func show_name_entry() -> void:

	name_input_visible = true

	name_input = LineEdit.new()

	name_input.placeholder_text = "ENTER YOUR NAME"

	name_input.text = ""

	name_input.max_length = 16

	name_input.alignment = HORIZONTAL_ALIGNMENT_CENTER

	name_input.editable = true

	name_input.focus_mode = Control.FOCUS_ALL

	name_input.mouse_filter = Control.MOUSE_FILTER_STOP

	name_input.position = Vector2(
		25,
		330
	)

	name_input.size = Vector2(
		screen_size.x - 50,
		50
	)

	add_child(name_input)

	# Press Enter / Return to continue
	name_input.text_submitted.connect(_on_name_submitted)

	# Make sure the field gets keyboard focus
	# Don't automatically open the iPhone keyboard
	name_input.release_focus()

	queue_redraw()

func _on_name_submitted(text: String) -> void:

	confirm_player_name()

func confirm_player_name() -> void:

	if name_input == null:
		return

	var entered_name := name_input.text.strip_edges()

	if entered_name.is_empty():

		entered_name = "PLAYER"

	player_name = entered_name

	var config := ConfigFile.new()

	config.set_value(
		"player",
		"name",
		player_name
	)

	config.save(player_settings_file)

	# =====================================================
	# SAVE PROFILE TO SUPABASE
	# =====================================================

	if SupabaseAuth.user_id != "":

		print("👤 SAVING PROFILE TO SUPABASE")

		SupabaseAuth.save_profile(
			player_name
		)

	else:

		print("⚠️ NO SUPABASE USER ID - PROFILE NOT SAVED")

	name_input.queue_free()
	name_input = null
	name_input_visible = false
	show_menu = true
	start_screen_transition()

	queue_redraw()


# =========================================================
# PARTICLES
# =========================================================

func spawn_particles(
	position: Vector2,
	color: Color
) -> void:

	for i in range(18):

		var particle := {
			"position": position,
			"velocity": Vector2(
				randf_range(-120.0, 120.0),
				randf_range(-120.0, 120.0)
			),
			"life": randf_range(0.3, 0.65),
			"max_life": 0.65,
			"color": color,
			"size": randf_range(2.0, 5.0)
		}

		particles.append(particle)


func update_particles(delta: float) -> void:

	for i in range(particles.size() - 1, -1, -1):

		var p = particles[i]

		p["position"] += p["velocity"] * delta

		p["velocity"] *= 0.94

		p["life"] -= delta

		if p["life"] <= 0.0:

			particles.remove_at(i)

		else:

			particles[i] = p

	queue_redraw()


func _notification(what: int) -> void:

	if what == NOTIFICATION_DRAW:

		for p in particles:

			var alpha: float = p["life"] / p["max_life"]

			var particle_color: Color = p["color"]

			particle_color.a = alpha

			draw_circle(
				p["position"],
				p["size"],
				particle_color
			)

func setup_account_storage() -> void:

    if SupabaseAuth.user_id.is_empty():

        print("⚠️ ACCOUNT STORAGE: USER ID MISSING")
        return

    best_file = (
        "user://best_score_" +
        SupabaseAuth.user_id +
        ".cfg"
    )

    profile_stats_file = (
        "user://profile_stats_" +
        SupabaseAuth.user_id +
        ".cfg"
    )

    player_settings_file = (
        "user://player_settings_" +
        SupabaseAuth.user_id +
        ".cfg"
    )

    print("================================")
    print("💾 ACCOUNT STORAGE INITIALIZED")
    print("USER ID:", SupabaseAuth.user_id)
    print("BEST FILE:", best_file)
    print("PROFILE FILE:", profile_stats_file)
    print("SETTINGS FILE:", player_settings_file)
    print("================================")

# =========================================================
# STORAGE
# =========================================================

func save_best_score() -> void:

	var config := ConfigFile.new()

	config.set_value(
		"score",
		"best",
		best_score
	)

	config.save(best_file)


func load_best_score() -> void:

	if best_file.is_empty():
		return

	var config := ConfigFile.new()

	if config.load(best_file) == OK:

		best_score = config.get_value(
			"score",
			"best",
			0
		)

# =========================================================
# ACHIEVEMENTS
# =========================================================

func check_achievements() -> void:

	var unlocked := false

	if best_score >= 10:
		unlocked = unlock_achievement("SCORE_10") or unlocked

	if best_score >= 25:
		unlocked = unlock_achievement("SCORE_25") or unlocked

	if best_score >= 50:
		unlocked = unlock_achievement("SCORE_50") or unlocked

	if best_score >= 100:
		unlocked = unlock_achievement("SCORE_100") or unlocked

	if all_time_max_combo >= 10:
		unlocked = unlock_achievement("COMBO_10") or unlocked

	if all_time_max_combo >= 25:
		unlocked = unlock_achievement("COMBO_25") or unlocked

	if all_time_max_combo >= 50:
		unlocked = unlock_achievement("COMBO_50") or unlocked

	if unlocked:
		save_profile_stats()

func unlock_achievement(id: String) -> bool:

	if achievements_unlocked.has(id):
		return false

	achievements_unlocked.append(id)

	print("🏆 ACHIEVEMENT UNLOCKED:", id)

	return true

func save_profile_stats() -> void:

	# =====================================================
	# LOCAL CACHE
	# =====================================================

	save_profile_stats_local_only()

	# =====================================================
	# CLOUD
	# =====================================================

	if SupabaseAuth.user_id == "":

		print("⚠️ CLOUD SAVE SKIPPED - USER NOT AUTHENTICATED")

		return

	if not cloud_stats_loaded:

		print("⚠️ CLOUD SAVE SKIPPED - STATS NOT LOADED YET")

		return

	print("================================")
	print("☁️ SAVING PROFILE STATS")
	print("USER:", SupabaseAuth.user_id)
	print("GAMES:", games_played)
	print("MAX COMBO:", all_time_max_combo)
	print("DAILY BEST:", daily_my_best)
	print("ACHIEVEMENTS:", achievements_unlocked)
	print("================================")

	SupabaseAuth.save_stats(
		games_played,
		all_time_max_combo,
		daily_my_best,
		achievements_unlocked
	)

func load_profile_stats() -> void:

	var config := ConfigFile.new()

	if profile_stats_file.is_empty():
		return

	if config.load(profile_stats_file) != OK:
		return

	games_played = int(
		config.get_value(
			"profile",
			"games_played",
			0
		)
	)

	all_time_max_combo = int(
		config.get_value(
			"profile",
			"max_combo",
			0
		)
	)

	daily_my_best = int(
		config.get_value(
			"profile",
			"daily_best",
			0
		)
	)

	achievements_unlocked = config.get_value(
		"profile",
		"achievements",
		[]
	)

	print("📊 PROFILE STATS LOADED")
	print("GAMES:", games_played)
	print("MAX COMBO:", all_time_max_combo)
	print("DAILY BEST:", daily_my_best)
	print("ACHIEVEMENTS:", achievements_unlocked)

# =========================================================
# CREATE SHARE CARD
# =========================================================

func create_share_card() -> void:

	var viewport := SubViewport.new()

	viewport.size = Vector2i(1080, 1350)
	viewport.transparent_bg = false
	viewport.render_target_update_mode = SubViewport.UPDATE_ONCE

	add_child(viewport)

	var card := Node2D.new()

	viewport.add_child(card)

	# =====================================================
	# BACKGROUND
	# =====================================================

	var background := ColorRect.new()

	background.color = Color("#06090E")
	background.position = Vector2.ZERO
	background.size = Vector2(1080, 1350)

	card.add_child(background)


	# =====================================================
	# TOP ACCENT
	# =====================================================

	var accent := ColorRect.new()

	accent.color = Color("#19E66F")
	accent.position = Vector2(0, 0)
	accent.size = Vector2(1080, 18)

	card.add_child(accent)


	# =====================================================
	# GAME TITLE
	# =====================================================

	var title := Label.new()

	title.text = "DON'T TAP RED"
	title.position = Vector2(0, 105)
	title.size = Vector2(1080, 90)

	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	title.add_theme_font_size_override(
		"font_size",
		64
	)

	title.add_theme_color_override(
		"font_color",
		Color.WHITE
	)

	card.add_child(title)


	# =====================================================
	# SMALL TEXT
	# =====================================================

	var subtitle := Label.new()

	subtitle.text = "THE ONLY RULE: DON'T TAP RED"
	subtitle.position = Vector2(0, 190)
	subtitle.size = Vector2(1080, 50)

	subtitle.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	subtitle.add_theme_font_size_override(
		"font_size",
		25
	)

	subtitle.add_theme_color_override(
		"font_color",
		Color("#778190")
	)

	card.add_child(subtitle)


	# =====================================================
	# SCORE CIRCLE
	# =====================================================

	var circle := ColorRect.new()

	circle.color = Color("#101923")
	circle.position = Vector2(240, 290)
	circle.size = Vector2(600, 430)

	card.add_child(circle)


	# Green accent line

	var circle_accent := ColorRect.new()

	circle_accent.color = Color("#19E66F")
	circle_accent.position = Vector2(240, 290)
	circle_accent.size = Vector2(600, 10)

	card.add_child(circle_accent)


	# =====================================================
	# SCORE LABEL
	# =====================================================

	var score_label := Label.new()

	score_label.text = str(score)

	score_label.position = Vector2(0, 350)
	score_label.size = Vector2(1080, 190)

	score_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	score_label.add_theme_font_size_override(
		"font_size",
		170
	)

	score_label.add_theme_color_override(
		"font_color",
		Color.WHITE
	)

	card.add_child(score_label)


	# =====================================================
	# MY SCORE
	# =====================================================

	var score_text := Label.new()

	score_text.text = "MY SCORE"

	score_text.position = Vector2(0, 525)
	score_text.size = Vector2(1080, 60)

	score_text.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	score_text.add_theme_font_size_override(
		"font_size",
		30
	)

	score_text.add_theme_color_override(
		"font_color",
		Color("#19E66F")
	)

	card.add_child(score_text)


	# =====================================================
	# COMBO
	# =====================================================

	var combo_label := Label.new()

	combo_label.text = str(max_combo) + " MAX COMBO"

	combo_label.position = Vector2(0, 650)
	combo_label.size = Vector2(1080, 70)

	combo_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	combo_label.add_theme_font_size_override(
		"font_size",
		38
	)

	combo_label.add_theme_color_override(
		"font_color",
		Color("#FFD447")
	)

	card.add_child(combo_label)


	# =====================================================
	# DIVIDER
	# =====================================================

	var divider := ColorRect.new()

	divider.color = Color("#27313D")
	divider.position = Vector2(120, 790)
	divider.size = Vector2(840, 3)

	card.add_child(divider)


	# =====================================================
	# CHALLENGE
	# =====================================================

	var challenge := Label.new()

	challenge.text = "CAN YOU BEAT ME?"

	challenge.position = Vector2(0, 850)
	challenge.size = Vector2(1080, 90)

	challenge.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	challenge.add_theme_font_size_override(
		"font_size",
		52
	)

	challenge.add_theme_color_override(
		"font_color",
		Color.WHITE
	)

	card.add_child(challenge)


	# =====================================================
	# SUB CHALLENGE
	# =====================================================

	var challenge_sub := Label.new()

	challenge_sub.text = "I DARE YOU."

	challenge_sub.position = Vector2(0, 930)
	challenge_sub.size = Vector2(1080, 60)

	challenge_sub.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	challenge_sub.add_theme_font_size_override(
		"font_size",
		28
	)

	challenge_sub.add_theme_color_override(
		"font_color",
		Color("#FF3152")
	)

	card.add_child(challenge_sub)


	# =====================================================
	# PLAY BUTTON LOOK
	# =====================================================

	var play_button := ColorRect.new()

	play_button.color = Color("#19E66F")
	play_button.position = Vector2(180, 1040)
	play_button.size = Vector2(720, 95)

	card.add_child(play_button)


	var play_text := Label.new()

	play_text.text = "BEAT MY SCORE  →"

	play_text.position = Vector2(180, 1060)
	play_text.size = Vector2(720, 60)

	play_text.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	play_text.add_theme_font_size_override(
		"font_size",
		34
	)

	play_text.add_theme_color_override(
		"font_color",
		Color("#06100A")
	)

	card.add_child(play_text)


	# =====================================================
	# FOOTER
	# =====================================================

	var footer := Label.new()

	footer.text = "DON'T TAP RED  •  CHALLENGE YOUR FRIENDS"

	footer.position = Vector2(0, 1200)
	footer.size = Vector2(1080, 60)

	footer.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	footer.add_theme_font_size_override(
		"font_size",
		22
	)

	footer.add_theme_color_override(
		"font_color",
		Color("#697483")
	)

	card.add_child(footer)


	# =====================================================
	# SAVE
	# =====================================================

	await get_tree().process_frame
	await get_tree().process_frame

	var card_image := viewport.get_texture().get_image()

	var path := "user://dont_tap_red_challenge.png"

	card_image.save_png(path)


	# =====================================================
	# COPY CHALLENGE
	# =====================================================

	share_message = (
		"I scored " +
		str(score) +
		" in DON'T TAP RED 🔥 " +
		"Can you beat " +
		str(score) +
		"?"
	)

	DisplayServer.clipboard_set(share_message)


	# =====================================================
	# OPEN IMAGE ON MAC
	# =====================================================

	var real_path := ProjectSettings.globalize_path(path)

	if OS.get_name() == "macOS":

		OS.shell_open(
			"file://" + real_path
		)

	elif OS.get_name() == "Windows":

		OS.shell_open(
			"file://" + real_path
		)

	elif OS.get_name() == "Linux":

		OS.shell_open(
			"file://" + real_path
		)


	viewport.queue_free()


# =========================================================
# SUPABASE LEADERBOARD
# =========================================================

func submit_score() -> void:

	if score <= 0:
		return

	if score_submission_running:
		print("⚠️ GLOBAL SCORE SUBMISSION ALREADY RUNNING")
		return

	# Never trust a cached/local player_id for a cloud write.
	# Always bind the submission to the currently authenticated user.
	if SupabaseAuth.user_id.is_empty() or SupabaseAuth.access_token.is_empty():
		print("❌ GLOBAL SCORE SUBMIT BLOCKED - USER NOT AUTHENTICATED")
		return

	player_id = SupabaseAuth.user_id
	score_submission_running = true

	print("SUBMITTING SCORE: ", score)
	print("PLAYER: ", player_name)
	print("PLAYER ID: ", player_id)

	var url := SUPABASE_URL + "/rest/v1/rpc/submit_leaderboard_score"

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Authorization: Bearer " + SupabaseAuth.access_token,
		"Content-Type: application/json"
	])

	var data := {
		"p_player_id": player_id,
		"p_player_name": player_name,
		"p_score": score,
		"p_max_combo": max_combo
	}

	var body := JSON.stringify(data)

	submit_http.request(
		url,
		headers,
		HTTPClient.METHOD_POST,
		body
	)

# =========================================================
# SUBMIT DAILY SCORE
# =========================================================

func submit_daily_score() -> void:

	if score <= 0:
		return

	if daily_score_submission_running:
		print("⚠️ DAILY SCORE SUBMISSION ALREADY RUNNING")
		return

	# Bind the daily submission to the currently authenticated user.
	if SupabaseAuth.user_id.is_empty() or SupabaseAuth.access_token.is_empty():
		print("❌ DAILY SCORE SUBMIT BLOCKED - USER NOT AUTHENTICATED")
		return

	player_id = SupabaseAuth.user_id
	daily_score_submission_running = true

	var today := Time.get_date_string_from_system()

	print("================================")
	print("🔥 SUBMIT DAILY SCORE")
	print("PLAYER:", player_name)
	print("SCORE:", score)
	print("COMBO:", max_combo)
	print("DATE:", today)
	print("================================")

	var url := (
		SUPABASE_URL +
		"/rest/v1/rpc/submit_daily_leaderboard_score"
	)

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Authorization: Bearer " + SupabaseAuth.access_token,
		"Content-Type: application/json"
	])

	var data := {
		"p_player_id": player_id,
		"p_player_name": player_name,
		"p_score": score,
		"p_max_combo": max_combo,
		"p_challenge_date": today
	}

	var body := JSON.stringify(data)

	var error := daily_submit_http.request(
		url,
		headers,
		HTTPClient.METHOD_POST,
		body
	)

	print("DAILY REQUEST RESULT:", error)
	if error != OK:
		daily_score_submission_running = false

func _on_daily_submit_completed(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:

	daily_score_submission_running = false

	print("================================")
	print("🔥 DAILY SUBMIT RESPONSE")
	print("RESULT:", result)
	print("HTTP:", response_code)
	print("BODY:", body.get_string_from_utf8())
	print("================================")

	if response_code < 200 or response_code >= 300:

		print(
			"❌ DAILY SUBMIT ERROR:",
			body.get_string_from_utf8()
		)

		return

	print("✅ DAILY SCORE SAVED")

	# Refresh daily leaderboard
	load_daily_leaderboard()

func _on_submit_score_completed(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:

	score_submission_running = false

	print("SUBMIT RESPONSE: ", response_code)

	if response_code < 200 or response_code >= 300:

		print(
			"SUBMIT ERROR: ",
			body.get_string_from_utf8()
		)

		return

	print("SCORE SUBMITTED SUCCESSFULLY")

	# Refresh leaderboard AFTER submission completes
	load_leaderboard()

func load_leaderboard() -> void:

	var url := (
		SUPABASE_URL +
		"/rest/v1/leaderboard" +
		"?select=player_name,player_id,score,max_combo" +
		"&order=score.desc,max_combo.desc" +
		"&limit=10"
	)

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Authorization: Bearer " + SUPABASE_KEY
	])

	leaderboard_http.request(
		url,
		headers,
		HTTPClient.METHOD_GET
	)

	# Get my score separately
	load_my_score()

func load_daily_leaderboard() -> void:

	var today := Time.get_date_string_from_system()

	var url := (
		SUPABASE_URL +
		"/rest/v1/daily_leaderboard" +
		"?select=player_name,player_id,score,max_combo" +
		"&challenge_date=eq." +
		today +
		"&order=score.desc,max_combo.desc" +
		"&limit=10"
	)

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Authorization: Bearer " + SUPABASE_KEY
	])

	daily_leaderboard_http.request(
		url,
		headers,
		HTTPClient.METHOD_GET
	)

	print("🔥 LOADING DAILY LEADERBOARD:", today)

	load_my_daily_score()

func _on_daily_leaderboard_request_completed(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:

	print("🔥 DAILY LEADERBOARD RESPONSE:", response_code)

	if response_code < 200 or response_code >= 300:

		print(
			"DAILY LEADERBOARD ERROR:",
			body.get_string_from_utf8()
		)

		return

	var text := body.get_string_from_utf8()

	var json := JSON.new()

	if json.parse(text) != OK:

		print("DAILY LEADERBOARD JSON ERROR")

		return

	if json.data is Array:

		daily_leaderboard_scores = json.data

		print(
			"🔥 DAILY LEADERBOARD:",
			daily_leaderboard_scores
		)

		queue_redraw()

func load_my_score() -> void:

	if player_id == "":
		return

	if player_score_request_running:
		print("⏳ PLAYER SCORE REQUEST ALREADY RUNNING")
		return
	player_score_request_running = true

	var url := (
		SUPABASE_URL +
		"/rest/v1/leaderboard" +
		"?select=score,max_combo" +
		"&player_id=eq." +
		player_id +
		"&limit=1"
	)

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Authorization: Bearer " + SUPABASE_KEY
	])

	player_score_http.request(
		url,
		headers,
		HTTPClient.METHOD_GET
	)

func _on_player_score_request_completed(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:

	player_score_request_running = false

	if response_code < 200 or response_code >= 300:
		print("Player score error: ", body.get_string_from_utf8())
		return

	var json := JSON.new()

	if json.parse(body.get_string_from_utf8()) != OK:
		return

	if json.data is Array and json.data.size() > 0:

		my_leaderboard_score = int(
			json.data[0].get("score", 0)
		)

		my_max_combo = int(
			json.data[0].get("max_combo", 0)
		)

		# Keep the highest known score
		best_score = max(
			best_score,
			my_leaderboard_score
		)

		save_best_score()

		print("☁️ CLOUD BEST SCORE:", best_score)
		print("☁️ CLOUD MAX COMBO:", my_max_combo)

		load_my_rank()

	else:

		my_leaderboard_score = 0
		my_max_combo = 0
		my_rank = 0

		print("ℹ️ NO GLOBAL LEADERBOARD SCORE YET")

		queue_redraw()

func load_my_daily_score() -> void:

	if player_id == "":
		return

	var today := Time.get_date_string_from_system()

	var url := (
		SUPABASE_URL +
		"/rest/v1/daily_leaderboard" +
		"?select=score,max_combo" +
		"&player_id=eq." +
		player_id +
		"&challenge_date=eq." +
		today +
		"&limit=1"
	)

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Authorization: Bearer " + SUPABASE_KEY
	])

	daily_player_score_http.request(
		url,
		headers,
		HTTPClient.METHOD_GET
	)

func _on_daily_player_score_request_completed(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:

	if response_code < 200 or response_code >= 300:

		print(
			"Daily player score error: ",
			body.get_string_from_utf8()
		)

		return

	var json := JSON.new()

	if json.parse(body.get_string_from_utf8()) != OK:
		return

	if json.data is Array and json.data.size() > 0:

		daily_my_best = int(
			json.data[0].get("score", 0)
		)

		daily_my_max_combo = int(
			json.data[0].get("max_combo", 0)
		)

		print(
			"🔥 MY DAILY BEST: ",
			daily_my_best
		)

		print(
			"🔥 MY DAILY MAX COMBO: ",
			daily_my_max_combo
		)

		load_daily_rank()

	else:

		daily_my_best = 0
		daily_my_rank = 0

		print("ℹ️ NO DAILY SCORE FOR TODAY")

	queue_redraw()

func load_my_rank() -> void:

		if my_leaderboard_score <= 0:
				return

		var url := (
				SUPABASE_URL +
				"/rest/v1/leaderboard" +
				"?select=score,max_combo" +
				"&or=(" +
				"score.gt." + str(my_leaderboard_score) +
				",and(" +
				"score.eq." + str(my_leaderboard_score) +
				",max_combo.gt." + str(my_max_combo) +
				")" +
                ")"
		)

		var headers := PackedStringArray([
				"apikey: " + SUPABASE_KEY,
				"Authorization: Bearer " + SUPABASE_KEY,
				"Prefer: count=exact",
                "Range: 0-0"
		])

		print("================================")
		print("🏆 CALCULATING GLOBAL RANK")
		print("MY SCORE:", my_leaderboard_score)
		print("MY MAX COMBO:", my_max_combo)
		print("================================")

		rank_http.request(
				url,
				headers,
				HTTPClient.METHOD_GET
		)

func _on_rank_request_completed(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:

	if response_code < 200 or response_code >= 300:
		print("Rank error: ", body.get_string_from_utf8())
		return

	var total_higher_scores := 0

	for header in headers:

		if header.to_lower().begins_with("content-range:"):

			var parts := header.split("/")

			if parts.size() == 2:

				total_higher_scores = int(
					parts[1].strip_edges()
				)

				break

	my_rank = total_higher_scores + 1

	print(
		"MY RANK: ",
		my_rank,
		" | MY SCORE: ",
		my_leaderboard_score
	)

	queue_redraw()

func load_daily_rank() -> void:

	if player_id == "":
		return

	if daily_my_best <= 0:
		return

	var today := Time.get_date_string_from_system()

	var url := (
		SUPABASE_URL +
		"/rest/v1/daily_leaderboard" +
		"?select=score,max_combo" +
		"&challenge_date=eq." +
		today +
		"&or=(" +
		"score.gt." + str(daily_my_best) +
		",and(" +
		"score.eq." + str(daily_my_best) +
		",max_combo.gt." + str(daily_my_max_combo) +
		")" +
		")"
	)

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Authorization: Bearer " + SupabaseAuth.access_token,
		"Prefer: count=exact",
		"Range: 0-0"
	])

	print("================================")
	print("🔥 CALCULATING DAILY RANK")
	print("DAILY SCORE:", daily_my_best)
	print("DAILY MAX COMBO:", daily_my_max_combo)
	print("DATE:", today)
	print("================================")

	daily_rank_http.request(
		url,
		headers,
		HTTPClient.METHOD_GET
	)

func _on_daily_rank_request_completed(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:

	if response_code < 200 or response_code >= 300:

		print(
			"Daily rank error: ",
			body.get_string_from_utf8()
		)

		return

	var total_higher_scores := 0

	for header in headers:

		if header.to_lower().begins_with("content-range:"):

			var parts := header.split("/")

			if parts.size() == 2:

				total_higher_scores = int(
					parts[1].strip_edges()
				)

				break

	daily_my_rank = total_higher_scores + 1

	print(
		"🔥 DAILY RANK: ",
		daily_my_rank,
		" | DAILY SCORE: ",
		daily_my_best,
		" | DAILY COMBO: ",
		daily_my_max_combo
	)

	queue_redraw()

func _on_leaderboard_request_completed(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:

	print("Supabase response: ", response_code)

	if response_code < 200 or response_code >= 300:

		print(
			"Leaderboard error: ",
			body.get_string_from_utf8()
		)

		return

	var text := body.get_string_from_utf8()

	var json := JSON.new()

	var parse_result := json.parse(text)

	if parse_result != OK:

		print("Leaderboard JSON error")

		return

	if json.data is Array:

		leaderboard_scores = json.data

		leaderboard_loaded = true

		print("Leaderboard loaded: ", leaderboard_scores)

		queue_redraw()

# =========================================================
# LEADERBOARD SCREEN
# =========================================================

func draw_leaderboard_screen() -> void:

	var w: float = screen_size.x
	var h: float = screen_size.y

	draw_global_navigation()

	# =====================================================
	# LEADERBOARD LAYOUT
	# =====================================================

	var list_top: float = safe_top + 155.0
	var list_bottom: float = h - safe_bottom - 180.0

	var row_h: float = 38.0
	var list_height: float = list_bottom - list_top

	var display_scores: Array = leaderboard_scores

	if leaderboard_daily_mode:

		display_scores = daily_leaderboard_scores

	var total_height: float = display_scores.size() * row_h

	var max_scroll: float = max(
		0.0,
		total_height - list_height
	)

	leaderboard_scroll = clamp(
		leaderboard_scroll,
		0.0,
		max_scroll
	)

	# =====================================================
	# HEADER
	# =====================================================

	draw_rect(
		Rect2(
			0,
			safe_top,
			w,
			6
		),
		Color("#19E66F")
	)

	var leaderboard_title := "GLOBAL"

	if leaderboard_daily_mode:
		leaderboard_title = "DAILY"

	draw_centered(
		leaderboard_title,
		Vector2(
			w / 2,
			safe_top + 35
		),
		24,
		Color.WHITE
	)

	draw_centered(
		"TOP PLAYERS",
		Vector2(
			w / 2,
			safe_top + 65
		),
		9,
		Color("#697382")
	)

	# =====================================================
	# LEADERBOARD TABS
	# =====================================================

	var tab_y: float = safe_top + 78.0
	var tab_w: float = (w - 60.0) / 2.0
	var tab_h: float = 38.0

	global_tab_rect = Rect2(
		20,
		tab_y,
		tab_w,
		tab_h
	)

	daily_tab_rect = Rect2(
		40 + tab_w,
		tab_y,
		tab_w,
		tab_h
	)


	# =====================================================
	# GLOBAL TAB
	# =====================================================

	var global_color := Color("#202A38")

	if not leaderboard_daily_mode:
		global_color = Color("#19E66F")

	draw_button(
		global_tab_rect,
		"GLOBAL",
		global_color,
	    "leaderboard_global"
	)


	# =====================================================
	# DAILY TAB
	# =====================================================

	var daily_color := Color("#202A38")

	if leaderboard_daily_mode:
		daily_color = Color("#19E66F")

	draw_button(
		daily_tab_rect,
		"DAILY",
		daily_color,
		"leaderboard_daily",
		ICON_FIRE
	)

	# =====================================================
	# COLUMN HEADERS
	# =====================================================

	var header_y: float = list_top - 18.0

	draw_centered(
		"RANK",
		Vector2(
			w * 0.16,
			header_y
		),
		10,
		Color("#697382")
	)

	draw_centered(
		"PLAYER",
		Vector2(
			w * 0.48,
			header_y
		),
		10,
		Color("#697382")
	)

	draw_centered(
		"SCORE",
		Vector2(
			w * 0.84,
			header_y
		),
		10,
		Color("#697382")
	)

	# =====================================================
	# PLAYER ROWS
	# =====================================================

	for i in range(display_scores.size()):

		var entry = display_scores[i]

		var name: String = str(
			entry.get("player_name", "PLAYER")
		)

		var entry_player_id: String = str(
			entry.get("player_id", "")
		)

		var entry_score: int = int(
			entry.get("score", 0)
		)

		# ---------------------------------------------
		# SCROLL POSITION
		# ---------------------------------------------

		var y: float = (
			list_top +
			i * row_h -
			leaderboard_scroll
		)

		# ---------------------------------------------
		# DON'T DRAW ROWS OUTSIDE LIST
		# ---------------------------------------------

		if y + row_h < list_top:
			continue

		if y > list_bottom:
			break

		# ---------------------------------------------
		# ROW
		# ---------------------------------------------

		var row_rect := Rect2(
			w * 0.10,
			y,
			w * 0.80,
			row_h - 3
		)

		# ---------------------------------------------
		# ROW COLOR (uniform now — medal color moves to badge)
		# ---------------------------------------------

		if entry_player_id == player_id:

			draw_rounded_rect(
				row_rect,
				8.0,
				Color("#19E66F")
			)

		else:

			draw_rounded_rect(
				row_rect,
				8.0,
				Color("#111A24")
			)

		# ---------------------------------------------
		# RANK
		# ---------------------------------------------

		var rank_number: int = i + 1

		# Score + max_combo determine ranking.
		# Higher score wins.
		# If score is tied, higher max_combo wins.
		# If both are identical, players share the same rank.

		if i > 0:

			var previous_entry = display_scores[i - 1]

			var previous_score: int = int(
				previous_entry.get("score", 0)
			)

			var previous_combo: int = int(
				previous_entry.get("max_combo", 0)
			)

			var current_combo: int = int(
				entry.get("max_combo", 0)
			)

			if (
				entry_score == previous_score
				and current_combo == previous_combo
			):

				var j: int = i - 1

				while j >= 0:

					var check_entry = display_scores[j]

					var check_score: int = int(
						check_entry.get("score", 0)
					)

					var check_combo: int = int(
						check_entry.get("max_combo", 0)
					)

					if (
						check_score != entry_score
						or check_combo != current_combo
					):
						break

					j -= 1

				rank_number = j + 2


		# ---------------------------------------------
		# MEDAL
		# ---------------------------------------------

		if rank_number <= 3 and entry_player_id != player_id:

			var medal_color := Color("#E08A4B") # bronze

			if rank_number == 1:
				medal_color = Color("#FFD447") # gold

			elif rank_number == 2:
				medal_color = Color("#C7CDD6") # silver

			# Draw medal circle
			draw_circle(
				Vector2(
					w * 0.16,
					y + (row_h - 3) / 2.0
				),
				11.0,
				medal_color
			)

			# Rank number inside medal
			draw_centered(
				str(rank_number),
				Vector2(
					w * 0.16,
					y + 24
				),
				11,
				Color("#06100A")
			)

		else:

			# Normal rank number
			var rank_color := Color.WHITE

			if entry_player_id == player_id:
				rank_color = Color("#06100A")

			draw_centered(
				str(rank_number),
				Vector2(
					w * 0.16,
					y + 24
				),
				12,
				rank_color
			)

		# ---------------------------------------------
		# PLAYER NAME
		# ---------------------------------------------

		var name_color := Color.WHITE

		if entry_player_id == player_id:
				name_color = Color("#06100A")

		draw_centered(
				name,
				Vector2(
						w * 0.48,
						y + 24
				),
				12,
				name_color
		)

		# ---------------------------------------------
		# SCORE
		# ---------------------------------------------

		var score_color := Color("#19E66F")

		if entry_player_id == player_id:
			score_color = Color("#06100A")

		draw_centered(
			str(entry_score),
			Vector2(
				w * 0.84,
				y + 24
			),
			12,
			score_color
		)

	# =====================================================
	# SCROLL INDICATOR
	# =====================================================

	if max_scroll > 0.0:

		draw_centered(
			"↑  SWIPE TO SCROLL  ↓",
			Vector2(
				w / 2,
				list_bottom + 18
			),
			9,
			Color("#697382")
		)

	# =====================================================
	# MY RANK
	# =====================================================

	if leaderboard_daily_mode:

		# =================================================
		# DAILY RANK
		# =================================================

		if daily_my_rank > 0:

			draw_centered(
				"YOUR DAILY RANK  #" + str(daily_my_rank),
				Vector2(
					w / 2,
					h - safe_bottom - 105
				),
				14,
				Color("#19E66F")
			)

			draw_centered(
				"BEST  " + str(daily_my_best),
				Vector2(
					w / 2,
					h - safe_bottom - 83
				),
				11,
				Color("#7C8795")
			)

	else:

		# =================================================
		# GLOBAL RANK
		# =================================================

		if my_rank > 0:

			draw_centered(
				"YOUR RANK  #" + str(my_rank),
				Vector2(
					w / 2,
					h - safe_bottom - 105
				),
				14,
				Color("#19E66F")
			)

			draw_centered(
				"BEST  " + str(my_leaderboard_score),
				Vector2(
					w / 2,
					h - safe_bottom - 83
				),
				11,
				Color("#7C8795")
			)

	# =====================================================
	# BACK BUTTON
	# =====================================================

	var back_button_y: float = (
		h -
		safe_bottom -
		65.0
	)

	leaderboard_back_rect = Rect2(
		40,
		back_button_y,
		w - 80,
		55
	)

	draw_button(
		leaderboard_back_rect,
		"← BACK",
		Color("#202A38"),
        "back"
	)


# =========================================================
# SHARE / BEAT MY SCORE
# =========================================================

func share_score() -> void:

	print("================================")
	print("🔥 BEAT MY SCORE")
	print("================================")

	challenge_score = score
	challenge_active = true
	challenge_completed = false

	var challenge_url := (
		GAME_CHALLENGE_URL +
		"?score=" +
		str(challenge_score)
	)

	var message := (
		player_name +
		" scored " +
		str(challenge_score) +
		" in DON'T TAP RED!\n\n" +
		"Can you beat " +
		str(challenge_score) +
		"?\n\n" +
		"PLAY THE CHALLENGE:\n" +
		challenge_url
	)

	print("📤 SHARE MESSAGE:")
	print(message)

	# Copy the challenge message
	DisplayServer.clipboard_set(message)

	print("✅ CHALLENGE COPIED TO CLIPBOARD")

	# Open challenge page
	OS.shell_open(challenge_url)

	print("🔗 CHALLENGE OPENED:")
	print(challenge_url)

# =========================================================
# ROUNDED BOX HELPER
# =========================================================

func make_rounded_box(
	color: Color,
	radius: float
) -> StyleBoxFlat:

	var box := StyleBoxFlat.new()

	box.bg_color = color

	box.corner_radius_top_left = int(radius)
	box.corner_radius_top_right = int(radius)
	box.corner_radius_bottom_left = int(radius)
	box.corner_radius_bottom_right = int(radius)

	return box
