//// courtesy of https://godotshaders.com/shader/wiggle-2d/ cc0 license
//shader_type canvas_item;
////
//uniform float Strength : hint_range(0,20) = 5;
//uniform float RandomOffset = 1f;
//uniform float TimeFactor : hint_range(0,20) = 1;
//
//float random( float seed )
//{
//	return fract( 543.2543 * sin( dot( vec2( seed, seed ), vec2( 3525.46 + RandomOffset, -54.3415 ) ) ) );
//}
//
//void vertex()
//{
//	vec2 VERTEX_OFFSET = VERTEX;
//	VERTEX_OFFSET.x += (
//		random(
//			( trunc( VERTEX_OFFSET.y))
//		+	TIME * TimeFactor
//		) - 0.5
//	) * Strength ;
//
//	VERTEX_OFFSET.y += (
//		random(
//			( trunc( VERTEX_OFFSET.x))
//		+	TIME * TimeFactor
//		) - 0.5
//	) * Strength;
//
//	VERTEX = VERTEX_OFFSET;	
//}

// coutesty of https://godotshaders.com/shader/2d-water-effect/

shader_type canvas_item;

uniform float wave_speed = 3.0; //wave loop speed
uniform float wave_freq = 10.0; //wave vertical freq
uniform float wave_width = 1; //wave width 


uniform float Strength : hint_range(0,20) = 5;
uniform float RandomOffset = 1f;
uniform float TimeFactor : hint_range(0,20) = 0.0001;

float random( float seed )
{
	return fract( 543.2543 * sin( dot( vec2( seed, seed ), vec2( 3525.46 + RandomOffset, -54.3415 ) ) ) );
}

void fragment(){
	vec2 scale_UV = UV;
	vec2 wave_uv_offset;
	wave_uv_offset.x = cos((TIME*wave_speed)+UV.x+UV.y*wave_freq*2.0)*wave_width*0.01;
	//COLOR = vec4(wave_uv_offset,0.0,1.0);
	vec2 random_offset = vec2(0, 0); 
	random_offset.y += random(UV.y + TIME * TimeFactor) * 0.001;
	COLOR = texture(TEXTURE,scale_UV + wave_uv_offset + random_offset);
}