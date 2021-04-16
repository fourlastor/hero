extends Camera2D

const ZOOM_MIN = 0.3
const ZOOM_MAX = 4
const ZOOM_STEP = 0.2
const ZOOM_IN = -ZOOM_STEP
const ZOOM_OUT = +ZOOM_STEP

export var smooth: bool = true

var panning: bool = false
onready var tween: Tween = $Tween

func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        if panning:
            offset -= event.relative * zoom
    elif event is InputEventMouseButton:
        var mouse_position = event.position
        match event.button_index:
            BUTTON_RIGHT:
                panning = event.pressed
            BUTTON_WHEEL_UP:
                zoom_at_point(ZOOM_IN, mouse_position)
            BUTTON_WHEEL_DOWN:
                zoom_at_point(ZOOM_OUT, mouse_position)
    elif event is InputEventMagnifyGesture:
        var zoom_change = ZOOM_OUT if event.factor < 1 else ZOOM_IN
        var mouse_position = get_global_mouse_position()
        zoom_at_point(zoom_change, mouse_position)
                
func zoom_at_point(zoom_change: float, zoom_center: Vector2) -> void:
    var viewport_center = 0.5 * get_viewport().size
    var previous_zoom = zoom
    var next_z_x = clamp(zoom_change + previous_zoom.x, ZOOM_MIN, ZOOM_MAX)
    var next_z_y = clamp(zoom_change + previous_zoom.y, ZOOM_MIN, ZOOM_MAX)
    var next_zoom =  Vector2(next_z_x, next_z_y)
    var next_offset = offset + (zoom_center - viewport_center) * (next_zoom - previous_zoom)
    
    if smooth:
        tween.interpolate_property(self, "zoom", zoom, next_zoom, 0.05, Tween.TRANS_LINEAR, Tween.EASE_IN)
        tween.interpolate_property(self, "offset", offset, next_offset, 0.05, Tween.TRANS_LINEAR, Tween.EASE_IN)
        tween.start()
    else:
        zoom = next_zoom
        offset += next_offset
