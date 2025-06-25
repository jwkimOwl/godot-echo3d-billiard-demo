extends Node

signal asset_downloaded
var downloaded_assets=0


func _ready():
	#create assets folder if it doesn't exist
	if not DirAccess.dir_exists_absolute("res://assets"):
		var dir = DirAccess.make_dir_absolute("res://assets")
		if dir!=OK:
			print(dir)
			return
	
	#return without calling API if the assets exist in assets folder
	var asset_count=0
	var asset = FileAccess.file_exists("./assets/Billiard Ball Clube.glb")
	if asset:
		asset_count+=1
	for i in range(1,16):
		asset = FileAccess.file_exists("./assets/Billiard Ball "+str(i)+".glb")
		if asset:
			asset_count+=1
	asset = FileAccess.file_exists("./assets/Billiard Table.glb")
	if asset:
		asset_count+=1
	if asset_count==17:
		emit_signal("asset_downloaded")
		return
	
	#calling API for Billiard Ball Assets in glb format
	for i in range(16): 
		var request_ball = HTTPRequest.new()
		add_child(request_ball)
		var body = ""
		request_ball.request_completed.connect(_on_request_completed.bind(i))
		var error = request_ball.request("https://api.echo3D.com/download-model?key="+Constants.API_KEY
										+"&entry="+Constants.BALL_ENTRY[i]
										+"&email="+Constants.EMAIL
										+"&secKey="+Constants.SEC_KEY
										+"&userKey="+Constants.USER_KEY
										+"&fileFormat="+Constants.FILE_FORMAT
										+"&convertMissing=true", [], HTTPClient.METHOD_GET, body)
	
	#calling API for Billiard Table Asset in glb format
	var request_table = HTTPRequest.new()
	add_child(request_table)
	var body = ""
	request_table.request_completed.connect(_on_request_completed.bind(16))
	var error = request_table.request("https://api.echo3D.com/download-model?key="+Constants.API_KEY
									+"&entry="+Constants.TABLE_ENTRY
									+"&email="+Constants.EMAIL
									+"&secKey="+Constants.SEC_KEY
									+"&userKey="+Constants.USER_KEY
									+"&fileFormat="+Constants.FILE_FORMAT
									+"&convertMissing=true", [], HTTPClient.METHOD_GET, body)
	

func _on_request_completed(result, response_code, headers, body,asset_number:int):
	if result!= OK:
		_on_request_error()
		return
	
	if asset_number == 0:
		var file_access = FileAccess.open("./assets/Billiard Ball Clube.glb", FileAccess.WRITE)
		for item in body:
			file_access.store_8(item)
		file_access.close()
		
	elif asset_number < 16:
		var file_access = FileAccess.open("./assets/Billiard Ball "+str(asset_number)+".glb", FileAccess.WRITE)
		for item in body:
			file_access.store_8(item)
		file_access.close()
	
	else:
		var file_table_access = FileAccess.open("./assets/Billiard Table.glb", FileAccess.WRITE)
		for item in body:
			file_table_access.store_8(item)
		file_table_access.close()
	
	downloaded_assets+=1
	if downloaded_assets==17:
		emit_signal("asset_downloaded")
		print("assets downloaded!")
	
	
func _on_request_error():
	print("api error")
	pass
