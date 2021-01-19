use <coupler.scad>;
use <fipple.scad>;
use <mouthpiece.scad>;
use <segment.scad>;
use <window.scad>;

/* [ pipe ] */
inner_diameter = 12;
outer_diameter = 15;
length = 100;

/* [ fipple ] */
lip_width = 7;
lip_angle = 15;
window_size = 4;
windway_height = 1.4;
windway_length = 40;


/* measured whistle params

inner_diameter = 15.08;   // 19/32 = 15.08mm
outer_diameter = 15.87;   // 5/8 = 15.87mm
fipple_length = 71.46;    // 3 - 3/16
windway_length = 25.4;
window_size = 4.76;       // 3/16 = 4.76mm
width = 7.14;             // 9/32 = 7.14mm
angle = 20;
*/


module dummy(){}

// derived parameters
fipple_length = 40;
angle = 90 - lip_angle;
inner = inner_diameter / 2;
wall_thickness = ceil((outer_diameter / 2-inner)/0.4)*0.4; // whole number of nozzles
outer = inner + wall_thickness;

w = lip_width;
w_sz = window_size;
w_h = windway_height;
w_len = windway_length;
f_len = fipple_length;
p_len = length - f_len;
b_h = bevel_height(inner, outer);

module last() {
  last_segment(inner, outer, p_len);
}

module non_last() {
  segment(inner, outer, p_len);
}

module fip() {
  fipple(inner, outer, f_len, w, angle, w_h);
}

module win() {
  window(inner, outer, w_sz, w, w_h);
}

module mouth() {
  mouthpiece(inner, outer, w_len, w, w_h);
}

module test() {
  c = coupler_height();

  // translate([0, 0, p_len + f_len + w_len + w_sz + 7*c + 4])
  //   last();

  // translate([0, 0, f_len + w_len + w_sz + 5*c + 3])
  //   non_last();

  translate([0, 0, w_len + w_sz + 3])
    fip();

  color("#aaaaaa55") translate([0, 0, w_len - b_h ])
    win();

  mouth();
}

test();