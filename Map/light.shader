shader_type canvas_item;
render_mode blend_mix,unshaded;
uniform float threshold : hint_range(0, 1) = 0.7;

void fragment() {
    vec4 texture_color = texture(TEXTURE, UV);
    float alpha = texture_color.a;
    vec3 bg = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb;
    float luminosity = 0.2126 * bg.r + 0.7152 * bg.g + 0.0722 * bg.b;
    vec4 color;
    if (luminosity > threshold)
    {
        COLOR.rgb = vec3(0)
    }
    else
    {
        COLOR.rgb = vec3(1)
    }
    COLOR.a = alpha;
}
