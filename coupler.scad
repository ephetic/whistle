use <segment.scad>;

function coupler_height () = 4;

// function gap = 0.4;
elephant_toe = 0.4;

module coupler(inner, outer, is_at_top, gap=0.1){
  h = coupler_height();
  w = (outer - inner) / 2;
  if (is_at_top) {
    translate([0,0,-h]) 
      pipe(inner, outer-w-gap, h);
  } else {
    difference() {
      pipe(inner+w+gap, outer, h);
      cylinder(r2=inner+w+gap, r1=outer-elephant_toe, h/2);
    }

  }
}

module offset_check(){
  intersection(){
    translate([0,-25,-25]) cube([50,50,50]);
    union(){
      segment(8,11,2);
      translate([0,0,2+coupler_height()+.1]) segment(8,11,2);
    }
  }
}

module coupler_tests() {
  // use comprehension to make vector of [gap, [dx, dy]] for one big stl
  gaps = [for (i=[0.0:0.05:0.2]) each [i,i]];
  r = 11;
  dr = r + 3;
  offsets = [for (x=[0:len(gaps)]) each [for (y=[0:1]) [dr*x,dr*y,0]]];
  for (i=[0:len(gaps)-1]) {
    // echo("i:", i, gaps[i], offsets[i]);
    translate(offsets[i]) segment(8/2,11/2,4,gaps[i]);
  }
}

// $fn=100;
// coupler_tests();
offset_check();
// segment(8,11,4,0.1);