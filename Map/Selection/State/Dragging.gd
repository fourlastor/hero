extends SelectionState
class_name Dragging

func input(event: InputEvent) -> void:
    if Input.is_action_just_released("ui_drag"):
        change_state("selected")
    elif event is InputEventMouseMotion:
        persistent.selection.global_position += event.relative * persistent.camera.zoom
        persistent.handles.moved(persistent.selection.global_position)
        get_tree().set_input_as_handled()
