class_name GameDb

var games: Array

func _init(games: Array = []) -> void:
    self.games = games
    
func serialize() -> Dictionary:
    var games_data = []
    for game in self.games:
        if not game.has_method("serialize"):
            continue
        games_data.append(game.serialize())
    return {
        "games": games_data
       }
