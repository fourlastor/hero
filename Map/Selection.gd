extends Control

var camera_zoom = Vector2.ONE
var camera_offset = Vector2.ZERO

onready var center = get_viewport_rect().size / 2

var selection

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index != BUTTON_LEFT:
            return
        drag_or_drop(event)
    elif event is InputEventMouseMotion and selection:
        var delta = event.relative
        selection.global_position += delta * camera_zoom
        get_tree().set_input_as_handled()

func drag_or_drop(event: InputEvent):
    if event.is_pressed():
        drag(event)
    else:
        selection = null
    
func drag(event: InputEvent):
    var mouse_position = get_global_mouse_position()
    var map_offset = camera_offset
    # The camera is anchored to the center of the screen
    # When it zooms, it does it from the center so there is
    # an offset in respect to the center of the viewport
    var zoom_delta = Vector2.ONE - camera_zoom
    var camera_zoom_offset = center * zoom_delta
    var map_position = mouse_position * camera_zoom + map_offset + camera_zoom_offset
    var results = get_world_2d().direct_space_state.intersect_point(
        map_position,
        32,
        [  ],
        0x7FFFFFFF,
        false,
        true
    )
    
    if results.size() == 0:
        return
    var result = results[0]
    selection = result['collider']
    if selection is Token:
        var shape_id = result['shape']
        var owner_id = selection.shape_find_owner(shape_id)
        print(selection.shape_owner_get_shape(owner_id, shape_id).extents)
    else:
        print("Not a token")

func drop():
    selection = null
