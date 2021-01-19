use <coupler.scad>;
use <fipple.scad>;
use <mouthpiece.scad>;
use <segment.scad>;

module window(inner, outer, size, width, height) {
  echo(inner, outer, size, width, height);
  offset = inset(inner, width, height);
  difference() {
    segment(inner, outer, size);
    rotate([0,0,90])
      translate([offset-1, -width/2, 0])
        cube([outer-offset+1, width, size + coupler_height()]);
    translate([0,0,size+coupler_height()]) 
      cheek(inner, outer, width);
  }
}

window(6, 7.6, 4, 7, 1.4);