extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # $FileDialog.popup()
#    get_tree().connect("files_dropped", self, "on_files_dropped")
    _on_FileDialog_file_selected("/Users/daniele/Documents/vtt-godot/testbed.dd2vtt")

func on_files_dropped(files: PoolStringArray) -> void:
    if files.size() <= 0:
        return
    _on_FileDialog_file_selected(files[0])


func _on_FileDialog_file_selected(path: String) -> void:
    var file = File.new()
    file.open(path, File.READ)
    var file_len = file.get_len()
    var compressed_data = file.get_buffer(file_len).compress(File.COMPRESSION_GZIP)
#    rpc("load_texture", file_len, compressed_data)
    load_texture(file_len, compressed_data)
    file.close()
    
func load_texture(content_length: int, compressed_data: PoolByteArray) -> void:
    var content = compressed_data.decompress(content_length, File.COMPRESSION_GZIP).get_string_from_utf8()
    var json = JSON.parse(content)
    if json.error != OK or not json.result is Dictionary:
        return
    var data = json.result
    var bytes = Marshalls.base64_to_raw(data['image'])
    var image = Image.new()
    image.load_png_from_buffer(bytes)
    var texture = ImageTexture.new()
    texture.create_from_image(image)
    $Sprite.texture = texture
