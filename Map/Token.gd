tool
extends Area2D
class_name Token

signal token_dragged(token)
signal token_dropped

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

    
func _input_event(viewport: Object, event: InputEvent, shape_idx: int) -> void:
    if event is InputEventMouseButton:
        if event.button_index != BUTTON_LEFT:
            return
        if event.is_pressed():
            emit_signal("token_dragged", self)
        else:
            emit_signal("token_dropped")
            
# TODO
#func shadow() -> Node:
#    var node := $Sprite.duplicate()
#    node.modulate.a = 0.5
#    return node
