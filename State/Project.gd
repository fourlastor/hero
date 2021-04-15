class_name Project

var name: String

func _init(name: String) -> void:
    self.name = name

func serialize() -> Dictionary:
    return {
        "name": self.name
       }
