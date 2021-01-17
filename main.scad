// $fn = $preview ? 20: 72;
use <fipple.scad>;
use <mouthpiece.scad>;
use <segment.scad>;

/* [ pipe ] */
inner_diameter = 8;
outer_diameter = 10;
length = 100;

/* [ fipple ] */
lip_width = 5;
lip_angle = 90 - 20;
window_size = 5;
windway_height = 2;
windway_length = 20;

module dummy(){}

fipple_length = 40;
inner = inner_diameter / 2;
outer = outer_diameter / 2;
w = lip_width;
w_sz = window_size;
w_h = windway_height;
w_len = windway_length;
f_len = fipple_length;
p_len = length - f_len;

/* measured whistle params

inner_diameter = 15.08; // 19/32 = 15.08mm
outer_diameter = 15.87;  // 5/8 = 15.87mm
fipple_length = 71.46; // 3 - 3/16
windway_length = 25.4;
window_size = 4.76;  // 3/16 = 4.76mm
width = 7.14;  // 9/32 = 7.14mm
angle = 90-20;
*/


// todo
// deepen windway/chin --- lip_radius is dependent on windway height
c = coupler_height();

translate([-outer-3,0,0]){
  translate([0, 0, f_len + w_len + w_sz + 5*c + 3])
    last_segment(inner, outer, p_len);

  translate([0, 0, w_len + w_sz + 3*c  + 2])
    fipple(inner, outer, f_len, w, lip_angle);

  translate([0, 0, w_len + c + 1])
    window(inner, outer, w_sz, w);

  mouthpiece(inner, outer, w_len, w);
}