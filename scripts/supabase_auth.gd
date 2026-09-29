extends Node

signal login_success(user_id: String)
signal login_failed(message: String)

signal session_restored(user_id: String)
signal session_restore_failed()
signal logged_out()

signal profile_loaded(profile_name: String)

signal stats_loaded(
	games_played: int,
	max_combo: int,
	daily_best: int,
	achievements: Array
)

const SUPABASE_URL: String = "https://cyobggtrsmldmaalitpi.supabase.co"
const SUPABASE_KEY: String = "sb_publishable__Kg9gSUD5tgHQWsSmLCcJA_Sk0yn4rw"

# Use ONE persistent session file
const AUTH_SAVE_PATH := "user://auth_session.cfg"

var access_token: String = ""
var refresh_token: String = ""
var user_id: String = ""
var username: String = ""

var session_restoring: bool = false

var player_games_played: int = 0
var player_max_combo: int = 0
var player_daily_best: int = 0
var player_achievements: Array = []

var auth_http: HTTPRequest
var profile_http: HTTPRequest
var profile_save_http: HTTPRequest


func _ready() -> void:

	auth_http = HTTPRequest.new()

	add_child(auth_http)

	auth_http.request_completed.connect(
		_on_auth_request_completed
	)
	profile_http = HTTPRequest.new()
	add_child(profile_http)

	profile_http.request_completed.connect(
		_on_profile_loaded
	)
	profile_save_http = HTTPRequest.new()

	add_child(profile_save_http)

	profile_save_http.request_completed.connect(
		_on_profile_saved
	)


# =========================================================
# LOGIN
# =========================================================

func login(email: String, password: String) -> void:

	print("================================")
	print("🔐 SUPABASE LOGIN")
	print("EMAIL:", email)
	print("================================")

	var url := (
		SUPABASE_URL +
		"/auth/v1/token?grant_type=password"
	)

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Content-Type: application/json"
	])

	var data := {
		"email": email,
		"password": password
	}

	var body := JSON.stringify(data)

	var error := auth_http.request(
		url,
		headers,
		HTTPClient.METHOD_POST,
		body
	)

	if error != OK:

		print("❌ AUTH REQUEST ERROR:", error)

		login_failed.emit(
			"Could not connect to server."
		)

# =========================================================
# AUTH RESPONSE
# =========================================================

func _on_auth_request_completed(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:

	var text := body.get_string_from_utf8()

	print("================================")
	print("🔐 SUPABASE AUTH RESPONSE")
	print("RESULT:", result)
	print("HTTP CODE:", response_code)
	print("BODY:", text)
	print("================================")

	# -----------------------------------------------------
	# NETWORK ERROR
	# -----------------------------------------------------

	if result != HTTPRequest.RESULT_SUCCESS:

		print("❌ NETWORK ERROR")
		print("RESULT CODE:", result)

		if session_restoring:

			session_restoring = false
			clear_auth_session()
			session_restore_failed.emit()

		else:

			login_failed.emit(
				"Could not connect to Supabase."
			)

		return


	# -----------------------------------------------------
	# HTTP ERROR
	# -----------------------------------------------------

	if response_code < 200 or response_code >= 300:

		print("❌ SUPABASE LOGIN FAILED")
		print("HTTP:", response_code)
		print("BODY:", text)

		var error_message := "Login failed."

		var error_json := JSON.new()

		if error_json.parse(text) == OK:

			if error_json.data is Dictionary:

				var data: Dictionary = error_json.data

				print("ERROR JSON:", data)

				if data.has("error_description"):
					error_message = str(
						data["error_description"]
					)

				elif data.has("message"):
					error_message = str(
						data["message"]
					)

				elif data.has("msg"):
					error_message = str(
						data["msg"]
					)

				elif data.has("error"):
					error_message = str(
						data["error"]
					)

		if session_restoring:

			print("❌ SAVED SESSION INVALID")

			session_restoring = false

			clear_auth_session()

			session_restore_failed.emit()

		else:

			login_failed.emit(error_message)

		return


	# -----------------------------------------------------
	# SUCCESS
	# -----------------------------------------------------

	print("✅ SUPABASE LOGIN HTTP SUCCESS")

	var json := JSON.new()

	if json.parse(text) != OK:

		print("❌ AUTH JSON ERROR")

		login_failed.emit(
			"Invalid authentication response."
		)

		return

	if not json.data is Dictionary:

		print("❌ AUTH RESPONSE IS NOT DICTIONARY")

		login_failed.emit(
			"Invalid authentication response."
		)

		return

	var response_data: Dictionary = json.data


	# -----------------------------------------------------
	# ACCESS TOKEN
	# -----------------------------------------------------

	access_token = str(
		response_data.get(
			"access_token",
			""
		)
	)


	# -----------------------------------------------------
	# REFRESH TOKEN
	# -----------------------------------------------------

	refresh_token = str(
		response_data.get(
			"refresh_token",
			""
		)
	)


	# -----------------------------------------------------
	# USER
	# -----------------------------------------------------

	var user_data = response_data.get(
		"user",
		null
	)

	if not user_data is Dictionary:

		print("❌ USER DATA MISSING")

		login_failed.emit(
			"Login succeeded but user data is missing."
		)

		return


	user_id = str(
		user_data.get(
			"id",
			""
		)
	)


	# -----------------------------------------------------
	# VALIDATE
	# -----------------------------------------------------

	if user_id.is_empty():

		print("❌ USER ID MISSING")

		login_failed.emit(
			"User ID missing."
		)

		return


	if access_token.is_empty():

		print("❌ ACCESS TOKEN MISSING")

		login_failed.emit(
			"Access token missing."
		)

		return


	# -----------------------------------------------------
	# SUCCESS
	# -----------------------------------------------------

	print("================================")
	print("✅ GODOT LOGIN SUCCESS")
	print("USER ID:", user_id)
	print("ACCESS TOKEN RECEIVED:", true)
	print("REFRESH TOKEN RECEIVED:", not refresh_token.is_empty())
	print("================================")

	save_auth_session()

	if session_restoring:

		session_restoring = false

		session_restored.emit(user_id)

	else:

		login_success.emit(user_id)

func load_stats() -> void:

	if user_id.is_empty():
		print("⚠️ Cannot load stats - no user ID")
		return

	if access_token.is_empty():
		print("⚠️ Cannot load stats - no access token")
		return

	print("================================")
	print("📊 LOADING PLAYER STATS")
	print("USER ID:", user_id)
	print("================================")

	var url := (
		SUPABASE_URL +
		"/rest/v1/player_stats" +
		"?select=games_played,max_combo,daily_best,achievements" +
		"&user_id=eq." +
		user_id +
		"&limit=1"
	)

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Authorization: Bearer " + access_token,
		"Content-Type: application/json"
	])

	var http := HTTPRequest.new()

	add_child(http)

	http.request_completed.connect(
		func(
			result: int,
			response_code: int,
			response_headers: PackedStringArray,
			body: PackedByteArray
		) -> void:

			print("📊 STATS RESPONSE:", response_code)

			if response_code < 200 or response_code >= 300:

				print(
					"❌ STATS LOAD ERROR:",
					body.get_string_from_utf8()
				)

				http.queue_free()
				return

			var json := JSON.new()

			if json.parse(
				body.get_string_from_utf8()
			) != OK:

				print("❌ STATS JSON ERROR")

				http.queue_free()
				return

			if not json.data is Array:

				http.queue_free()
				return

			var rows: Array = json.data

			if rows.is_empty():

				print("ℹ️ NO PLAYER STATS YET")

				player_games_played = 0
				player_max_combo = 0
				player_daily_best = 0
				player_achievements = []

			else:

				var row: Dictionary = rows[0]

				player_games_played = int(
					row.get("games_played", 0)
				)

				player_max_combo = int(
					row.get("max_combo", 0)
				)

				player_daily_best = int(
					row.get("daily_best", 0)
				)

				var saved_achievements = row.get(
					"achievements",
					[]
				)

				if saved_achievements is Array:

					player_achievements = saved_achievements

				else:

					player_achievements = []

			print("🎮 GAMES:", player_games_played)
			print("🔥 MAX COMBO:", player_max_combo)
			print("🔥 DAILY BEST:", player_daily_best)
			print("🏆 ACHIEVEMENTS:", player_achievements)

			stats_loaded.emit(
				player_games_played,
				player_max_combo,
				player_daily_best,
				player_achievements
			)

			http.queue_free()
	)

	var error := http.request(
		url,
		headers,
		HTTPClient.METHOD_GET
	)

	print("STATS REQUEST RESULT:", error)

func save_stats(
	games_played: int,
	max_combo: int,
	daily_best: int,
	achievements: Array
) -> void:

	if user_id.is_empty():
		print("⚠️ Cannot save stats - no user ID")
		return

	if access_token.is_empty():
		print("⚠️ Cannot save stats - no access token")
		return

	print("================================")
	print("📊 SAVING PLAYER STATS")
	print("USER ID:", user_id)
	print("GAMES:", games_played)
	print("MAX COMBO:", max_combo)
	print("DAILY BEST:", daily_best)
	print("ACHIEVEMENTS:", achievements)
	print("================================")

	var url := (
		SUPABASE_URL +
		"/rest/v1/player_stats" +
		"?on_conflict=user_id"
	)

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Authorization: Bearer " + access_token,
		"Content-Type: application/json",
		"Prefer: resolution=merge-duplicates,return=minimal"
	])

	var data := {
		"user_id": user_id,
		"games_played": games_played,
		"max_combo": max_combo,
		"daily_best": daily_best,
		"achievements": achievements,
		"updated_at": Time.get_datetime_string_from_system(true)
	}

	var body := JSON.stringify(data)

	var http := HTTPRequest.new()

	add_child(http)

	http.request_completed.connect(
		func(
			result: int,
			response_code: int,
			response_headers: PackedStringArray,
			response_body: PackedByteArray
		) -> void:

			print("================================")
			print("📊 SAVE PLAYER STATS RESPONSE")
			print("RESULT:", result)
			print("HTTP:", response_code)
			print("BODY:", response_body.get_string_from_utf8())

			if response_code >= 200 and response_code < 300:

				print("✅ PLAYER STATS SAVED TO SUPABASE")

			else:

				print("❌ PLAYER STATS SAVE FAILED")

			print("================================")

			http.queue_free()
	)

	var error := http.request(
		url,
		headers,
		HTTPClient.METHOD_POST,
		body
	)

	print("STATS POST REQUEST RESULT:", error)

# =========================================================
# SAVE AUTH SESSION
# =========================================================

func save_auth_session() -> void:

	if refresh_token.is_empty():
		print("⚠️ NO REFRESH TOKEN TO SAVE")
		return

	var config := ConfigFile.new()

	config.set_value(
		"auth",
		"refresh_token",
		refresh_token
	)

	config.set_value(
		"auth",
		"user_id",
		user_id
	)

	var error := config.save(AUTH_SAVE_PATH)

	print("================================")
	print("💾 SAVING AUTH SESSION")
	print("PATH:", AUTH_SAVE_PATH)
	print("USER ID:", user_id)
	print("REFRESH TOKEN LENGTH:", refresh_token.length())
	print("SAVE RESULT:", error)
	print("================================")

	if error == OK:

		print("✅ AUTH SESSION SAVED")

	else:

		print("❌ FAILED TO SAVE AUTH SESSION")
		print("ERROR:", error)

# =========================================================
# CLEAR AUTH SESSION
# =========================================================

func clear_auth_session() -> void:

	var path := ProjectSettings.globalize_path(
		AUTH_SAVE_PATH
	)

	print("================================")
	print("🗑️ CLEARING AUTH SESSION")
	print("PATH:", path)
	print("FILE EXISTS:", FileAccess.file_exists(path))
	print("================================")

	if FileAccess.file_exists(path):

		var error := DirAccess.remove_absolute(path)

		print("DELETE RESULT:", error)

		if error == OK:
			print("✅ AUTH SESSION FILE DELETED")
		else:
			print("❌ FAILED TO DELETE AUTH SESSION")

	else:

		print("ℹ️ NO AUTH SESSION FILE FOUND")

	access_token = ""
	refresh_token = ""
	user_id = ""
	username = ""

	player_games_played = 0
	player_max_combo = 0
	player_daily_best = 0
	player_achievements = []

	print("🧹 AUTH MEMORY CLEARED")

# =========================================================
# RESTORE AUTH SESSION
# =========================================================

func restore_session() -> void:

	print("================================")
	print("🔄 CHECKING SAVED LOGIN")
	print("================================")

	var config := ConfigFile.new()

	var error := config.load(AUTH_SAVE_PATH)

	print("📂 CONFIG LOAD RESULT:", error)

	if error != OK:

		print("ℹ️ NO SAVED LOGIN")

		session_restore_failed.emit()

		return

	var saved_refresh_token := str(
		config.get_value(
			"auth",
			"refresh_token",
			""
		)
	)

	var saved_user_id := str(
		config.get_value(
			"auth",
			"user_id",
			""
		)
	)

	print("💾 SAVED USER ID:", saved_user_id)
	print("🔑 REFRESH TOKEN EXISTS:", not saved_refresh_token.is_empty())
	print("🔑 REFRESH TOKEN LENGTH:", saved_refresh_token.length())

	if saved_refresh_token.is_empty():

		print("⚠️ NO REFRESH TOKEN")

		clear_auth_session()

		session_restore_failed.emit()

		return

	refresh_token = saved_refresh_token
	user_id = saved_user_id

	session_restoring = true

	print("================================")
	print("🔄 REFRESHING SAVED SESSION")
	print("================================")

	var url := (
		SUPABASE_URL +
		"/auth/v1/token?grant_type=refresh_token"
	)

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Content-Type: application/json"
	])

	var data := {
		"refresh_token": refresh_token
	}

	var body := JSON.stringify(data)

	var error_request := auth_http.request(
		url,
		headers,
		HTTPClient.METHOD_POST,
		body
	)

	print("🔄 REFRESH REQUEST RESULT:", error_request)

	if error_request != OK:

		print("❌ SESSION REFRESH REQUEST FAILED")

		session_restoring = false

		clear_auth_session()

		session_restore_failed.emit()

# =========================================================
# SAVE PROFILE
# =========================================================

func save_profile(profile_name: String) -> void:

	if user_id.is_empty():

		print("❌ PROFILE: USER ID MISSING")
		return

	if access_token.is_empty():

		print("❌ PROFILE: ACCESS TOKEN MISSING")
		return

	username = profile_name.strip_edges()

	if username.is_empty():
		username = "PLAYER"

	print("================================")
	print("👤 SAVING PROFILE")
	print("USER ID:", user_id)
	print("USERNAME:", username)
	print("================================")

	var url := SUPABASE_URL + "/rest/v1/profiles"

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Authorization: Bearer " + access_token,
		"Content-Type: application/json",
		"Prefer: resolution=merge-duplicates,return=representation"
	])

	var data := {
		"user_id": user_id,
		"username": username
	}

	var body := JSON.stringify(data)

	var error := profile_save_http.request(
		url,
		headers,
		HTTPClient.METHOD_POST,
		body
	)

	if error != OK:

		print("❌ PROFILE REQUEST ERROR:", error)

	else:

		print("📤 PROFILE REQUEST SENT")

func _on_profile_saved(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:

	print("================================")
	print("👤 PROFILE SAVE RESPONSE")
	print("HTTP:", response_code)
	print("BODY:", body.get_string_from_utf8())
	print("================================")

	if response_code >= 200 and response_code < 300:

		print("✅ PROFILE SAVED")

	else:

		print("❌ PROFILE SAVE FAILED")

# =========================================================
# LOAD PROFILE
# =========================================================

func load_profile() -> void:

	if user_id.is_empty():

		print("❌ PROFILE LOAD: USER ID MISSING")
		return

	if access_token.is_empty():

		print("❌ PROFILE LOAD: ACCESS TOKEN MISSING")
		return

	print("================================")
	print("👤 LOADING PROFILE")
	print("USER ID:", user_id)
	print("================================")

	var url := (
		SUPABASE_URL +
		"/rest/v1/profiles" +
		"?select=username" +
		"&user_id=eq." +
		user_id
	)

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Authorization: Bearer " + access_token,
		"Content-Type: application/json"
	])

	var error := profile_http.request(
		url,
		headers,
		HTTPClient.METHOD_GET
	)

	if error != OK:

		print("❌ PROFILE LOAD REQUEST ERROR:", error)

	else:

		print("📥 PROFILE LOAD REQUEST SENT")

# =========================================================
# PROFILE LOADED
# =========================================================

func _on_profile_loaded(
	result: int,
	response_code: int,
	headers: PackedStringArray,
	body: PackedByteArray
) -> void:

	print("================================")
	print("👤 PROFILE RESPONSE")
	print("HTTP:", response_code)
	print("BODY:", body.get_string_from_utf8())
	print("================================")

	if response_code < 200 or response_code >= 300:

		print(
			"❌ PROFILE LOAD ERROR:",
			body.get_string_from_utf8()
		)

		return

	var json := JSON.new()

	if json.parse(body.get_string_from_utf8()) != OK:

		print("❌ PROFILE JSON ERROR")

		return

	if not json.data is Array:

		print("❌ PROFILE DATA IS NOT ARRAY")

		return

	if json.data.is_empty():

		print("⚠️ NO PROFILE FOUND")

		return

	var profile = json.data[0]

	username = str(
		profile.get(
			"username",
			"PLAYER"
		)
	).strip_edges()

	if username.is_empty():

		username = "PLAYER"

	print("================================")
	print("✅ PROFILE LOADED")
	print("USERNAME:", username)
	print("================================")

	profile_loaded.emit(username)

# =========================================================
# REFRESH SESSION
# =========================================================

func refresh_session() -> void:

	if refresh_token.is_empty():

		print("⚠️ NO REFRESH TOKEN")

		session_restore_failed.emit()

		return

	var url := (
		SUPABASE_URL +
		"/auth/v1/token?grant_type=refresh_token"
	)

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Content-Type: application/json"
	])

	var data := {
		"refresh_token": refresh_token
	}

	var body := JSON.stringify(data)

	var http := HTTPRequest.new()

	add_child(http)

	http.request_completed.connect(
		func(
			result: int,
			response_code: int,
			response_headers: PackedStringArray,
			response_body: PackedByteArray
		) -> void:

			var text := response_body.get_string_from_utf8()

			print("================================")
			print("🔄 SESSION REFRESH")
			print("HTTP:", response_code)
			print("BODY:", text)
			print("================================")

			if response_code < 200 or response_code >= 300:

				print("❌ SESSION REFRESH FAILED")

				clear_auth_session()

				session_restore_failed.emit()

				http.queue_free()

				return

			var json := JSON.new()

			if json.parse(text) != OK:

				print("❌ REFRESH JSON ERROR")

				clear_auth_session()

				session_restore_failed.emit()

				http.queue_free()

				return

			if not json.data is Dictionary:

				print("❌ INVALID REFRESH RESPONSE")

				clear_auth_session()

				session_restore_failed.emit()

				http.queue_free()

				return

			var data_dict: Dictionary = json.data

			access_token = str(
				data_dict.get(
					"access_token",
					""
				)
			)

			refresh_token = str(
				data_dict.get(
					"refresh_token",
					refresh_token
				)
			)

			var user_data = data_dict.get(
				"user",
				null
			)

			if user_data is Dictionary:

				user_id = str(
					user_data.get(
						"id",
						user_id
					)
				)

			if access_token.is_empty() or user_id.is_empty():

				print("❌ REFRESH DATA INVALID")

				clear_auth_session()

				session_restore_failed.emit()

				http.queue_free()

				return

			# Save the NEW refresh token
			save_auth_session()

			print("================================")
			print("✅ SESSION RESTORED")
			print("USER ID:", user_id)
			print("================================")

			session_restored.emit(user_id)

			http.queue_free()
	)

	var error := http.request(
		url,
		headers,
		HTTPClient.METHOD_POST,
		body
	)

	print("REFRESH REQUEST RESULT:", error)

func delete_account() -> void:

	print("================================")
	print("🗑️ DELETE ACCOUNT")
	print("================================")

	if user_id.is_empty():
		print("❌ DELETE ACCOUNT: USER ID MISSING")
		return

	if access_token.is_empty():
		print("❌ DELETE ACCOUNT: ACCESS TOKEN MISSING")
		return

	var url := (
		SUPABASE_URL +
		"/functions/v1/delete-account"
	)

	var headers := PackedStringArray([
		"apikey: " + SUPABASE_KEY,
		"Authorization: Bearer " + access_token,
		"Content-Type: application/json"
	])

	var http := HTTPRequest.new()
	add_child(http)

	http.request_completed.connect(
		func(
			result: int,
			response_code: int,
			response_headers: PackedStringArray,
			body: PackedByteArray
		) -> void:

			var response_text := body.get_string_from_utf8()

			print("================================")
			print("🗑️ DELETE ACCOUNT RESPONSE")
			print("HTTP:", response_code)
			print("BODY:", response_text)
			print("================================")

			if response_code >= 200 and response_code < 300:

				print("✅ ACCOUNT DELETED")

				clear_auth_session()

				access_token = ""
				refresh_token = ""
				user_id = ""
				username = ""

				player_games_played = 0
				player_max_combo = 0
				player_daily_best = 0
				player_achievements = []

				print("🧹 LOCAL ACCOUNT DATA CLEARED")

				logged_out.emit()

			else:

				print("❌ ACCOUNT DELETION FAILED")

			http.queue_free()
	)

	var error := http.request(
		url,
		headers,
		HTTPClient.METHOD_POST,
		"{}"
	)

	print(
		"DELETE ACCOUNT REQUEST RESULT:",
		error
	)

# =========================================================
# LOGOUT
# =========================================================

func logout() -> void:

	print("================================")
	print("🔴 SUPABASE LOGOUT")
	print("================================")

	# Stop any session restoration
	session_restoring = false

	# Clear local saved session + memory
	clear_auth_session()

	# Extra safety
	access_token = ""
	refresh_token = ""
	user_id = ""
	username = ""

	# Clear player stats
	player_games_played = 0
	player_max_combo = 0
	player_daily_best = 0
	player_achievements = []

	print("================================")
	print("🧹 AUTH SESSION CLEARED")
	print("✅ LOGOUT COMPLETE")
	print("================================")

	logged_out.emit()
