extends WindowDialog

signal game_created(game_name)

func _on_Create_pressed() -> void:
    var game_name = $Name.text.strip_edges()
    if game_name.empty(): 
        return
    emit_signal("game_created", game_name)
    self.hide()
    $Name.text = ""
