use <segment.scad>;
use <arc.scad>;

function lip_radius(inner, width) = sqrt(pow(inner,2) - pow(width/2,2));
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
  */

function lip_height (inner, outer, width, angle) = tan(angle) * (outer - lip_radius(inner, width));

module lip(inner, outer, width, angle) {
  w2 = width/2;
  r = lip_radius(inner, width);
  h = lip_height(inner, outer, width, angle);
  points = [
    [-w2,r,0],
    [w2,r,0],
    [-w2,outer,0],
    [w2,outer,0],
    [-w2,outer,h],
    [w2,outer,h]   
  ];
  faces = [
    [0,1,3,2],
    [1,0,4,5],
    [2,3,5,4],
    [0,2,4],
    [1,5,3]
  ];
  polyhedron(points, faces);
}

// could collide with segment.collar
module chin(inner, outer, length, width, angle) {
  r = lip_radius(inner, width);
  bottom_offset = max(coupler_height(), lip_height(inner, outer, width, angle));
  top_offset = length - coupler_height();
  w = inner-r;
  relief = atan2(-w,top_offset - bottom_offset);
  
  intersection() {
    cylinder(r=outer,h=length);
    translate([-width/2,r,0]) {
      translate([0,0,bottom_offset]) rotate([relief,0,0]) cube([width, outer-r, top_offset-bottom_offset]);
      cube([width, outer-r, bottom_offset]);
    }
  }

  // TODO so close, but doesn't line up with built-in
  cheek_angle = asin((width/2)/inner)/2;
  cylinder_arc(inner,[90+cheek_angle,90+cheek_angle+30], outer-inner, coupler_height());
  cylinder_arc(inner,[90-cheek_angle,90-cheek_angle-30], outer-inner, coupler_height());
}

inner = 8;
outer = 10;
length = 20;
width = 3;
angle = 45;

// $fn=50;

difference() {
  union() {
    segment(inner, outer, length);
    chin(inner, outer, length, width, angle);
  }
  lip(inner, outer, width, angle);
}

// chin(inner, outer, width, length);
// lip(inner, outer, width, angle);


// chin(inner, outer, length, width, angle);
// translate([0,0,10]) lip(inner, outer, width, angle);

