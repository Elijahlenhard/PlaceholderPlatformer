shader_type canvas_item;

const float scale = 2.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
void fragment() {
	vec4 pixelColor = texture(SCREEN_TEXTURE, UV * scale);
	COLOR = pixelColor;
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
