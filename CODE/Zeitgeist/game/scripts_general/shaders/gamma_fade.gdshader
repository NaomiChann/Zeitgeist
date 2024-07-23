shader_type canvas_item;

// externally provided value with min, max and step
uniform float gamma : hint_range( 0.0, 1.0, 0.01 );
// entirety of the current screen as a texture
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	// maps screen texture to coordinates, essentially obtaining pixel color values
	vec3 color = texture( screen_texture, SCREEN_UV ).rgb;
	
	// applies the gamma equation to the screen colors
	color = pow( color, vec3( 1.0 / gamma ) );
	
	// limits the colors to the original calculation so it doesnt get too bright*
	// and makes it so the color darkens faster with lower gamma**
	COLOR.rgb = clamp( color / ( 0.35 / gamma ), vec3( 0.0 ), color );
	// *(since the gamma input has a limit of 1.0 that result will at most be
	// the original brightness)
	// **(by dividing the color value, making it reach #000000 (black) faster)
}