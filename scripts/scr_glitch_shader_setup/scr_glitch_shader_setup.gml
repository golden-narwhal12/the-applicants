/// @desc Setup glitch shader uniforms
/// @param time
/// @param intensity (0-1)
/// @param pixelation (1-10, higher = more pixelated)
/// @param color_shift (0-10)
/// @param width
/// @param height

function glitch_shader_setup(_time, _intensity, _pixelation, _color_shift, _width, _height) {
    shader_set(shd_glitch);
    
    var u_time = shader_get_uniform(shd_glitch, "u_time");
    var u_glitch_intensity = shader_get_uniform(shd_glitch, "u_glitch_intensity");
    var u_pixelation = shader_get_uniform(shd_glitch, "u_pixelation");
    var u_color_shift = shader_get_uniform(shd_glitch, "u_color_shift");
    var u_resolution = shader_get_uniform(shd_glitch, "u_resolution");
    
    shader_set_uniform_f(u_time, _time);
    shader_set_uniform_f(u_glitch_intensity, _intensity);
    shader_set_uniform_f(u_pixelation, _pixelation);
    shader_set_uniform_f(u_color_shift, _color_shift);
    shader_set_uniform_f(u_resolution, _width, _height);
}