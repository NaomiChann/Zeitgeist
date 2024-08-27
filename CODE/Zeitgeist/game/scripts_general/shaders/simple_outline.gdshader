shader_type canvas_item;

uniform vec4 color : source_color = vec4( 1.0 );
uniform float width : hint_range( 0.0, 10.0, 1.0 ) = 1.0;

/* 
 checks every pixel for non-transparent neighbors
 if any neighbor is not transparent, returns true
*/
bool IsOnBorder( vec2 uv, vec2 tex_pixel_size, sampler2D tex ) {
	for ( float x = -width; x <= width; ++x ) {
		for ( float y = -width; y <= width; ++y ) {
			// converts xy position to uv
			vec2 xy = uv + tex_pixel_size * vec2( x, y );
			
			// checks if the neighbor is not transparent
			if ( texture( tex, xy ).a > 0.0 ) {
				return true;
			}
		}
	}
	return false;
}

void fragment() {
	// checks whether or not the pixel is transparent and on a border
	if ( COLOR.a == 0.0 && IsOnBorder( UV, TEXTURE_PIXEL_SIZE, TEXTURE ) ) {
		COLOR = color;
	}
}
