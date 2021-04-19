extends Node2D
class_name SelectionState

signal change_state(state_name)

var persistent: Persistent

func setup(persistent: Persistent):
    self.persistent = persistent

func enter() -> void:
    pass

func input(event: InputEvent) -> void:
    pass
    
func exit() -> void:
    pass
    
func tokens_at(position: Vector2) -> Array:
    var results = get_world_2d().direct_space_state.intersect_point(
        position,
        32,
        [  ],
        0x7FFFFFFF,
        false,
        true
    )
    var tokens = []
    for result in results:
        if (result['collider'] is Token):
            tokens.push_back(result)
    return tokens

func change_state(state_name: String) -> void:
    emit_signal("change_state", state_name)

class Persistent:
    
    func _init(camera: Camera2D, handles: Handles) -> void:
        self.camera = camera
        self.handles = handles
    
    var camera: Camera2D
    var selection: Token
    var handles: Handles
