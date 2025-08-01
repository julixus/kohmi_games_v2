shader_type canvas_item;
/*
	Simplified and adapted from:
	https://www.shadertoy.com/view/MlKBWw
*/

#define TAU 6.28318

// Uncomment the following line to get a flare in the center (Disney-style)
#define FLARE 1

// The way this shader works is by looking at the screen as if it were a disk and then
// this disk is split into a number of slices centered at the origin. Each slice renders
// a single trail. So this setting controls the overall density of the effect:
#define NUM_SLICES 125.0
//#define NUM_SLICES 50.0

// Each trail is rendered within its slice; but to avoid generating regular patterns, we
// randomly offset the trail from the center of the slice by this amount:
const float MAX_SLICE_OFFSET = 0.4;

// This is the length of the effect in seconds:
const float T_MAX = 3.0;
// T_JUMP is in normalized [0..1] time: this is the time when the
// trails zoom out of view because we've jumped into hyperspace:
const float T_JUMP = 0.75;
// This is the speed during the final jump:
const float jump_speed = 15.0;

const vec2 iResolution = vec2(1152, 648);
varying vec2 uv_screen;

// I've noticed that the effect tends to have a bluish tint. In this
// shader, the blue color is towards the start of the trail, and the
// white color towards the end:
const vec3 blue_col = vec3(0.3, 0.3, 0.5);
//const vec3 white_col = vec3(0.95, 0.95, 1.0);
const vec3 white_col = vec3(0.0, 0.706, 0.0); //vec3(0.0, 0.706, 0.0);
const vec3 flare_col = vec3(0.9, 0.9, 1.4); //ec3(0.9, 0.9, 1.4);
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;
uniform float u_time;



float array_mix(in float[4] array, in int n, float index)
{
    float dec = fract(index);
    int i = int(floor(index));
    if (i >= n - 1)
        return array[i];
    else
    	return mix(array[i], array[i+1], dec);
}

float sdLine( in vec2 p, in vec2 a, in vec2 b, in float ring )
{
    vec2 pa = p-a, ba = b-a;
    float h = clamp( dot(pa,ba)/dot(ba,ba), 0.0, 1.0 );
    return length( pa - ba*h ) - ring;
}

float rand(vec2 co){
    return fract(sin(dot(co.xy, vec2(12.9898,78.233))) * 43758.5453);
}

/*
	Lens flare from: https://www.shadertoy.com/view/XdfXRX
	and: https://www.shadertoy.com/view/4sX3Rs
*/
vec3 lensflare(vec3 uv, vec3 pos, float flare_size, float ang_offset)
{
    float z = uv.z / length(uv.xy);
	vec2 main = uv.xy - pos.xy;
    float dist = length(main);
	float num_points = 2.71;
    float disk_size = 0.2;
    float inv_size = 1.0 / flare_size;
	float ang = atan(main.y, main.x) + ang_offset;
    float fade = (z < 0.0) ? -z : 1.0;
    //if (z < 0.0) return vec3(0.0);

    float f0 = 1.0/(dist * inv_size + 1.0);
    f0 = f0 + f0 * (0.1 * sin((sin(ang*2.0 + pos.x)*4.0 - cos(ang*3.0 + pos.y)) * num_points) + disk_size);
    if (z < 0.0)
		return clamp(mix(vec3(f0), vec3(0.0), 0.75 * fade), 0.0, 1.0);
    else
        return vec3(f0);
}

vec3 cc(vec3 color, float factor, float factor2) // color modifier
{
	float w = color.x+color.y+color.z;
	return mix(color, vec3(w) * factor, w * factor2);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec3 color = vec3(0.0);
	float time = mod(u_time, T_MAX);
    float t = time / T_MAX;
    vec2 p = (2.0 * fragCoord.xy - iResolution.xy) / min(iResolution.x, iResolution.y);
    //vec2 mo = (2.0 * iMouse.xy - iResolution.xy) / min(iResolution.x, iResolution.y);
    p += vec2(0, -0.2); // In XWA the aiming HUD is not at the screen's center

    float ta = TAU * mod(TIME, 8.0) / 8.0;
    //ta = 12.0 * 0.01745;

    float ay = 0.0, ax = 0.0, az = 0.0;

    //p += vec2(0.0, -0.1); // + 12.0*m;
    //p = (mX * vec3(p, 1.0)).xy;

    float p_len = length(p);
    vec3 v = vec3(p, 1.0);

    // The following line reverts the effect:
    //t = 1.0 - t;
    // DEBUG
    //t = 0.5;
    // DEBUG

    //float[4] flare_size;
    //flare_size[0] = 0.0

    float trail_start, trail_end;
    // Fade all the trails into view from black to a little above full-white:
    float fade = clamp(mix(0.1, 1.1, t * 2.0), 0.0, 2.0);
    //fade = 1.0;

    // Each slice renders a single trail; but we can render multiple layers of
    // slices to add more density and randomness to the effect:
	for(float i = 0.0; i < 80.0; i++)
    //float i = 1.0;
    {
        vec3 trail_color = vec3(0.0);
		//float angle = (atan(v.y, v.x) / 3.141592 / 3.0 + 0.5);
        float angle = atan(v.y, v.x) / 3.141592 / 2.0 + 0.13 * i;

		float slice = floor(angle * NUM_SLICES);
        float slice_fract = fract(angle * NUM_SLICES);

        // Don't center the trail in the slice: wiggle it a little bit:
        float slice_offset = MAX_SLICE_OFFSET *
            rand(vec2(slice, 4.0 + i * 25.0)) - (MAX_SLICE_OFFSET / 2.0);


        // Without dist, all trails get stuck to the walls of the
        // tunnel.
        //float dist = rand(vec2(slice, 1.0 + i * 10.0)) * (2.0 + i);
        float dist = 10.0 * rand(vec2(slice, 1.0 + i * 10.0)) - 5.0;
        float z = dist * v.z / length(v.xy);
        // When dist is negative we have to invert a number of things:
        float f = sign(dist);
        if (f == 0.0) f = 1.0;
        // This is the speed of the current slice
        float fspeed = f * (0.1 * rand(vec2(slice, 1.0 + i * 10.0)) + i * 0.01);
        float fjump_speed = f * jump_speed;

		//trail_start = 5.0 + 2.0 * rand(vec2(slice, 0.0 + i * 10.0));
        trail_start = 10.0 * rand(vec2(slice, 0.0 + i * 10.0)) - 5.0;

        // Accelerate the trail_start:
        trail_start -= mix(0.0, fjump_speed, smoothstep(T_JUMP, 1.0, t));
        trail_end = trail_start - t * fspeed;

        //float trail_x = smoothstep(trail_start, trail_end, p_len);
        float trail_x = smoothstep(trail_start, trail_end, z);
        trail_color = mix(blue_col, white_col, trail_x);

        // This line computes the distance from the current pixel, in "slice-coordinates"
        // to the ideal trail centered at the slice center. The last argument makes the lines
        // a bit thicker when they reach the edges as time progresses.
        float h = sdLine(
            vec2(slice_fract + slice_offset, z),
            vec2(0.5, trail_start),
            vec2(0.5, trail_end),
            //0.0);
	       	mix(0.0, 0.015, t * z));

        //h = smoothstep(0.075, 0.01, abs(h) - 0.05);
        // This threshold adds a "glow" to the line. This glow grows with
        // time:
        //float threshold = mix(0.04, 0.175, smoothstep(0.0, 0.5, t));
        float threshold = 0.09;
        h = (h < 0.01) ? 1.0 : 0.85 * smoothstep(threshold, 0.0, abs(h));

        trail_color *= fade * h;
        // DEBUG
        // This part displays the size of each slice.
        //float r = 0.0;
        //if (trail_start <= p_len && p_len <= trail_end)
        //    r = 1.0;
        //trail_color = vec3(h, h, h);
        // DEBUG

        // Accumulate this trail with the previous ones
        color = max(color, trail_color);
	}

#ifdef FLARE
    // Add the disk at the center to transition into the hyperspace
    // tunnel
    float flare_size = mix(0.0, 0.1, smoothstep(0.35, T_JUMP + 0.2, t));
    flare_size += mix(0.0, 20.0, smoothstep(T_JUMP + 0.05, 1.0, t));
    vec3 flare = flare_col * lensflare(v, vec3(0.0), flare_size, t);
    color += cc(flare, 0.5, 0.1);
    //color += flare;
    // Whiteout
    color += mix(0.0, 1.0, smoothstep(T_JUMP + 0.1, 1.0, t));
#else
    // Whiteout
    color += mix(0.0, 1.0, smoothstep(T_JUMP - 0.0, 1.0, t));
#endif
	vec4 bg = texture(SCREEN_TEXTURE, uv_screen);
	fragColor = vec4(bg.rgb + color, 1.0);
}

void fragment() {
	uv_screen = FRAGCOORD.xy / iResolution;
    vec4 color;
    mainImage(color, UV * iResolution);
    COLOR = color;
}
