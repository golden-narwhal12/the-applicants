varying vec2 v_vTexcoord;
varying vec2 v_vPosition;

uniform float u_time;
uniform float u_glitch_intensity;
uniform float u_pixelation;
uniform float u_color_shift;
uniform vec2 u_resolution;

// Random function
float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

// Noise function
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

void main()
{
    vec2 uv = v_vTexcoord;
    
    // Glitch trigger - happens rarely and erratically
    float glitch_trigger = random(vec2(floor(u_time * 0.5), 0.0));
    float is_glitching = step(0.97, glitch_trigger); // Only glitches 3% of the time
    
    // Different glitch types occur at different times
    float glitch_type = random(vec2(floor(u_time * 0.5), 1.0));
    
    vec2 sample_uv = uv;
    
    if (is_glitching > 0.5) {
        // TYPE 1: Horizontal displacement (40% of glitches)
        if (glitch_type < 0.4) {
            float line_random = random(vec2(floor(uv.y * 80.0), floor(u_time * 3.0)));
            if (line_random > 0.92) {
                float big_shift = (random(vec2(floor(uv.y * 80.0), floor(u_time * 3.0) + 1.0)) - 0.5) * 0.3;
                sample_uv.x += big_shift * u_glitch_intensity;
            }
        }
        
        // TYPE 2: Block corruption (30% of glitches)
        else if (glitch_type < 0.7) {
            vec2 block_pos = floor(uv * vec2(15.0, 10.0));
            float block_glitch = random(block_pos + vec2(floor(u_time * 2.0), 0.0));
            
            if (block_glitch > 0.85) {
                // Corrupted blocks
                sample_uv = floor(sample_uv * 30.0) / 30.0;
            }
        }
        
        // TYPE 3: Scanline jitter (30% of glitches)
        else {
            float scan_shift = sin(uv.y * 200.0 + u_time * 50.0) * 0.02;
            sample_uv.x += scan_shift * u_glitch_intensity;
        }
    }
    
    // Sample texture
    vec4 color = texture2D(gm_BaseTexture, sample_uv);
    
    // Chromatic aberration - only during intense glitches
    if (is_glitching > 0.5 && glitch_type > 0.6) {
        float shift = u_color_shift * 0.02;
        vec4 color_r = texture2D(gm_BaseTexture, sample_uv + vec2(shift, 0.0));
        vec4 color_b = texture2D(gm_BaseTexture, sample_uv - vec2(shift, 0.0));
        color = vec4(color_r.r, color.g, color_b.b, color.a);
    }
    
    // Random pixel corruption - very rare
    float pixel_corrupt = random(floor(uv * u_resolution) + floor(u_time * 10.0));
    if (is_glitching > 0.5 && pixel_corrupt > 0.995) {
        color.rgb = vec3(random(uv + u_time), random(uv + u_time + 1.0), random(uv + u_time + 2.0));
    }
    
    // Digital noise artifacts - brief flashes
    if (is_glitching > 0.5 && glitch_type < 0.2) {
        float noise_val = noise(uv * 150.0 + u_time * 20.0);
        if (noise_val > 0.7) {
            color.rgb += vec3(0.3);
        }
    }
    
    gl_FragColor = color;
}