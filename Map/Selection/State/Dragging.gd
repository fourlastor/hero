extends SelectionState
class_name Dragging

func input(event: InputEvent) -> void:
    if Input.is_action_just_released("ui_drag"):
        var position_on_grid = persistent.grid.world_to_map(persistent.grid.to_local(get_global_mouse_position()))
        var snapped_position = persistent.grid.to_global(persistent.grid.map_to_world(position_on_grid)) + persistent.grid.cell_size / 2
        persistent.selection.global_position = snapped_position
        persistent.handles.moved(persistent.selection.global_position)
        change_state("selected")
    elif event is InputEventMouseMotion:
        persistent.selection.global_position += event.relative * persistent.camera.zoom
        persistent.handles.moved(persistent.selection.global_position)
        get_tree().set_input_as_handled()
