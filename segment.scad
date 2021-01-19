use <coupler.scad>;
// Section

module pipe(inner, outer, length) {
  difference() {
    cylinder(r=outer, h=length);
    cylinder(r=inner, h=length);
  }
}

function bevel_height(inner, outer, gap=0.1) = (outer-inner)/2 + gap;

module bevel(inner, outer){
  w = (outer - inner);
  difference(){
    cylinder(r1=inner+w,r2=inner,h=w);
    cylinder(r=inner,h=w);
  }
}

module segment(inner, outer, length, gap=0.1) {
  w = (outer-inner)/2;
  union() {
    difference(){
      pipe(inner, outer, length);
      bevel(inner, outer+gap-w);
    }
    translate([0,0,-coupler_height()]) 
      coupler(inner, outer, false);
    translate([0,0,length + coupler_height()]) {
      coupler(inner, outer, true);
      bevel(inner, inner+w-gap);
    }
  }
}

module first_segment(inner, outer, length, gap=0.1) {
  w = (outer-inner)/2;
  union() {
    pipe(inner, outer, length);
    translate([0,0,length + coupler_height()]) {
      coupler(inner, outer, true);
      bevel(inner, inner+w-gap);
    }
  }
}

module last_segment(inner, outer, length, gap=0.1) {
  w = (outer-inner)/2;
  union() {
    difference(){
      pipe(inner, outer, length);
      bevel(inner, outer+gap-w);
    }
    translate([0,0,-coupler_height()]) 
      coupler(inner, outer, false);
  }
}

d = [4,6,2];

difference() {
  union() {
    first_segment(d.x, d.y, d.z);
    translate([0,0,d.z + coupler_height() + 0.1])
      segment(d.x, d.y, d.z);
    translate([0,0,2*(d.z + coupler_height() + 0.1)])
      last_segment(d.x, d.y, d.z);
  }
  translate([-20,0,0]) cube([50,50,50]);
}
