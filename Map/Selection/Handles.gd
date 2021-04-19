extends NinePatchRect
class_name Handles

var selection_extent := Vector2.ZERO
onready var patch_extent := Vector2(patch_margin_left + patch_margin_right, patch_margin_top + patch_margin_bottom) / 2 - Vector2.ONE

func moved(selection_position: Vector2) -> void:
    rect_global_position = selection_position - selection_extent

func selected(selection_position: Vector2, extent: Vector2) -> void:
    selection_extent = extent + patch_extent
    rect_size = selection_extent * 2
    rect_global_position = selection_position - selection_extent
    rect_pivot_offset = selection_extent
    visible = true

func deselected() -> void:
    visible = false
    selection_extent = Vector2.ZERO
