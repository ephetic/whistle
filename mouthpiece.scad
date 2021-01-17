use <arc.scad>;
use <fipple.scad>;
use <segment.scad>;

module mouthpiece(inner, outer, length, width, height) {
  difference() {
    union() {
      first_segment(inner, outer, length);
      cylinder(r=inner, h=length);
    }
    windway(inner, outer, length, width, height);
  }
}

  /*
    / \    |
  r/   \   | h
  /__w__\  |

  s = (r+r+w)/2 = r + w/2
  A = sqrt(s(s-r)(s-r)(s-w))
    = sqrt( s (s-r)^2 (s-w) )
    = sqrt( (r+w/2) (r+w/2-r)^2 (r+w/2-w) )
    = sqrt( (r+w/2) (w/2)^2 (r-w/2) )
    = sqrt( (r^2 - (w/2)^2) (w/2)^2 )
    = (w/2) sqrt(r^2 - (w/2)^2)
  A = wh/2
  h = 2A/w
    = 2/w (w/2) sqrt(r^2 - (w/2)^2)
    = sqrt(r^2 - (w/2)^2)

  // to find w from h
  h2 = r2 - (w/2)2
  r2 - h2 = (w/2)2
  2sqrt(r2 - h2) = w
  */

function inset(inner, width, height) = -height + sqrt(pow(inner,2) - pow(width/2,2));

module windway(inner, outer, length, width, height) {
  offset = inset(inner, width, height);
  rotate([0,0,90]) 
    translate([offset, -width/2 ,0]) 
    cube([height, width, length]);
}

module window(inner, outer, size, width, height) {
  offset = inset(inner, width, height);
  difference() {
    segment(inner, outer, size);
    rotate([0,0,90])
      translate([offset-1, -width/2, coupler_height()])
      cube([outer-offset+1, width, size]);
    translate([0,0,size+coupler_height()]) 
      cheek(inner, outer, width);
  }
}
