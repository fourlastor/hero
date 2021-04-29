tool
extends Area2D
class_name Token

export var has_vision: bool = true setget set_vision
export var has_light: bool = true setget set_light

var extents = Vector2.ZERO

func _ready() -> void:
    var shape = $CollisionShape2D.shape
    if shape is RectangleShape2D:
        extents = shape.extents

func set_vision(vision: bool):
    has_vision = vision
    $Vision.enabled = vision

func set_light(light: bool):
    has_light = light
    $Light.enabled = light
