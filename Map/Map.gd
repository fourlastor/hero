extends Node2D

export var darknessColor: Color
export var darknessActivated: bool

func _ready() -> void:
    set_process_input(true)
    change_selection_state("idle")

onready var states := {
    "idle": Idle,
    "selected": Selected,
    "dragging": Dragging,
}

var selection_state: SelectionState
onready var persistent := SelectionState.Persistent.new(Vector2.ZERO, Vector2.ONE, $Handles)

func change_selection_state(state_name: String) -> void:
    assert(states.has(state_name))
    if selection_state != null:
        selection_state.queue_free()
    selection_state = states[state_name].new()
    selection_state.connect("change_state", self, "change_selection_state")
    selection_state.setup(persistent)
    add_child(selection_state)
    selection_state.enter()
    
func _input(event: InputEvent) -> void:
    selection_state.input(event)

func _on_camera_moved(zoom, offset) -> void:
    persistent.camera_zoom = zoom
    persistent.camera_offset = offset
