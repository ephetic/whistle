use <arc.scad>;
use <fipple.scad>;
use <segment.scad>;

module mouthpiece(inner, outer, length, width) {
  difference() {
    union() {
      first_segment(inner, outer, length);
      cylinder(r=inner, h=length);
    }
    windway(inner, outer, length, width, 1);
  }
}

module windway(inner, outer, length, width, height) {
  offset = lip_radius(inner, width) - height/2;
  rotate([0,0,90]) translate([offset, -width/2 ,0]) cube([height, width, length]);
}

module window(inner, outer, size, width) {
  offset = lip_radius(inner,width);
  difference() {
    segment(inner, outer, size);
    rotate([0,0,90])
      translate([offset-1, -width/2, coupler_height()])
      cube([outer-offset+1, width, size]);
    translate([0,0,size+coupler_height()]) 
      cheek(inner, outer, width);
  }
}
