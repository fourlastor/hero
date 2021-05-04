extends SelectionState
class_name Selected

func input(event: InputEvent) -> void:
    if Input.is_action_just_pressed("ui_drag") and not token_under_mouse():
        change_state("idle")
    elif event is InputEventMouseMotion and Input.is_action_pressed("ui_drag") and token_under_mouse():
        change_state("dragging")

func token_under_mouse() -> bool:
    var tokens = tokens_at(get_global_mouse_position())
    for token in tokens:
        if token['collider'] == persistent.selection:
            return true
    return false
