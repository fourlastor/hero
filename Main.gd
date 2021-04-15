extends Node

const SERVER_PORT = 4567
const SERVER_IP = "127.0.0.1"

const DB_PATH = "user://db.json"

var db: GameDb = GameDb.new()

func _ready() -> void:
    pass
#    var file = File.new()
#    if not file.file_exists(DB_PATH):
#        file.open("user://db.json", File.WRITE)
#        file.store_string(JSON.print(GameDb.new([]).serialize()))
#    file.close()

func _on_client_pressed() -> void:
    var peer = NetworkedMultiplayerENet.new()
    peer.create_client(SERVER_IP, SERVER_PORT)
    get_tree().network_peer = peer

func _on_server_pressed() -> void:
    var peer = NetworkedMultiplayerENet.new()
    peer.create_server(SERVER_PORT)
    get_tree().network_peer = peer

func _on_NewGame_pressed() -> void:
    $NewGameDialog.show()

func _on_game_created(game_name: String) -> void:
    var game = Project.new(game_name)
    db.games.append(game)
    save_db(db)
    
func save_db(db: GameDb) -> void:
    var file = File.new()
    file.open("user://db.json", File.WRITE)
    file.store_string(JSON.print(db.serialize()))
    file.close()
