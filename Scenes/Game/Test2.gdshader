shader_type canvas_item;

const float scale = 1.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

void fragment() {
	float x_offset = float(int(FRAGCOORD.x)%3);
	float y_offset = float(int(FRAGCOORD.y)%3);
	float x = FRAGCOORD.x-x_offset;
	float y = FRAGCOORD.y-y_offset;
	x = x/1920.0;
	y = y/1080.0;
	
	
	vec4 pixelColor = texture(SCREEN_TEXTURE, vec2(x,y));
	COLOR = pixelColor;
}

