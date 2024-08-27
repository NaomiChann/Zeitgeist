shader_type canvas_item;

uniform float transparency = 1.0;

void fragment() {
	if ( texture( TEXTURE, UV ).a < 1.0 ) {
		COLOR.a = transparency;
	}
}