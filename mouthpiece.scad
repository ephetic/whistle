use <arc.scad>;
use <fipple.scad>;
use <segment.scad>;

module mouthpiece(inner, outer, length, width) {
  difference() {
    union() {
      segment(inner, outer, length);
      cylinder(r=inner, h=length);
      cylinder(r=outer, h=coupler_height());
    }
    windway(inner, outer, length, width, 1);
  }
}

module windway(inner, outer, length, width, height) {
  offset = lip_radius(inner, width) - height/2;
  rotate([0,0,90]) translate([offset, -width/2 ,0]) cube([height, width, length]);
}

module window(inner, outer, size, width) {
  length = size + 2*coupler_height();
  offset = lip_radius(inner,width);
  difference() {
    segment(inner, outer, length);
    rotate([0,0,90])
      translate([offset-1, -width/2, coupler_height()])
      cube([outer-offset+1, width, size+1]);
    translate([0,0,length-coupler_height()]) cheek(inner, outer, width);
  }
}

// todo
// deepen windway/chin --- lip_radius is dependent on windway height
// re-parameterize accounting for couplers
// create parameters file (can customizer globals get re-exported as fns?)

inner = 15.08; // 19/32 = 15.08mm
outer = 15.87;  // 5/8 = 15.87mm
fipple_length = 71.46; // 3 - 3/16
windway_length = 25.4;
window_size = 4.76;  // 3/16 = 4.76mm
width = 7.14;  // 9/32 = 7.14mm
angle = 90-20;

translate([0,0,windway_length+window_size+8])
fipple(inner, outer, fipple_length, width, angle);

translate([0,0,windway_length+2])
window(inner, outer, window_size, width);

mouthpiece(inner, outer, windway_length, width);
