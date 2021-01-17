// Section

module pipe(inner, outer, length) {
  difference() {
    cylinder(r=outer, h=length);
    cylinder(r=inner, h=length);
  }
}

// so other modules can see these values
function coupler_height () = 5;

module coupler(inner, outer, top){
  h = coupler_height();
  w = (outer - inner) / 2;
  if (top) {
    translate([0,0,-h]) pipe(inner+w, outer, h);
  } else {
    pipe(inner, outer-w, h);
  }
}


module segment(inner, outer, length) {
  difference() {
    pipe(inner, outer, length);
    coupler(inner, outer, false);
    translate([0,0,length]) coupler(inner, outer, true);
  }
}

segment(8,10,20);
