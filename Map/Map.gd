extends Node2D

export var darknessColor: Color
export var darknessActivated: bool

var _token: Token = null

func _ready() -> void:
    on_camera_movement($Camera.zoom, $Camera.offset)
    $Camera.connect("camera_movement", self, "on_camera_movement")

func on_camera_movement(zoom: Vector2, offset: Vector2) -> void:
    $UIContainer/UI/Selection.camera_zoom =  zoom
    $UIContainer/UI/Selection.camera_offset = offset
