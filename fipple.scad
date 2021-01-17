use <arc.scad>;
use <mouthpiece.scad>;
use <segment.scad>;

function lip_radius (inner, width, height) = inset(inner, width, height) + height/2;
function lip_height (inner, outer, width, angle, height) = tan(angle) * (outer - inset(inner, width, height) - height/2);

module lip(inner, outer, width, angle, height) {
  w2 = width/2;
  r = lip_radius(inner, width, height);
  h = lip_height(inner, outer, width, angle, height);
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

module cheek(inner, outer, width) {
  angle = asin((width/2)/inner)/2;
  delta = 30;
  arc(inner, outer, coupler_height(), 90-angle-delta, 90+angle+delta);
}

module chin(inner, outer, length, width, angle, height) {
  r = lip_radius(inner, width, height);
  bottom_offset = max(coupler_height(), lip_height(inner, outer, width, angle, height));
  top_offset = length + coupler_height();
  w = inner-r;
  relief = atan2(-w,top_offset - bottom_offset);

  // 2sqrt(r2 - h2) = w
  w_at_lip = 2*sqrt(inner*inner - r*r);
  intersection() {
    cylinder(r=outer,h=length);
    translate([-w_at_lip/2,r,0]) {
      translate([0,0,bottom_offset]) 
        rotate([relief,0,0]) 
        cube([w_at_lip, outer-r, top_offset-bottom_offset]);
      cube([w_at_lip, outer-r, bottom_offset]);
    }
  }
}

module fipple(inner, outer, length, width, angle, height) {
  difference() {
    union() {
      segment(inner, outer, length);
      chin(inner, outer, length, width, angle, height);
      cheek(inner, outer, width);
    }
    lip(inner, outer, width, angle, height);
  }
}

inner = 8;
outer = 10;
length = 40;
width = 5;
angle = 90-20;
height = 2;

fipple(inner, outer, length, width, angle, height);
// lip(inner, outer, width, angle, height);