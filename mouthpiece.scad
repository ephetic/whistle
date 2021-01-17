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
