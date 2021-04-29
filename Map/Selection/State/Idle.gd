extends SelectionState
class_name Idle

func enter() -> void:
    persistent.handles.deselected()

func input(_event: InputEvent) -> void:
    if Input.is_action_just_pressed("ui_drag"):
        attempt_drag()
      
func attempt_drag():
    var results = tokens_at(get_global_mouse_position())
    
    if results.size() == 0:
        return
    var result = results[0]
    var collider = result['collider'] as Token
    var shape_id = result['shape']
    var owner_id = collider.shape_find_owner(shape_id)
    var shape = collider.shape_owner_get_shape(owner_id, shape_id)
    if shape is RectangleShape2D:
        persistent.selection = collider #.shadow()
        persistent.handles.selected(collider.global_position, shape.extents)
        change_state("selected")

