module sector(radius, height, start, end) {
  rotate([0,0,start])
  rotate_extrude(angle=end-start) {
    square([radius,height]);
  }
}

module arc(inner, outer, height, start, end) {
  difference(){
    sector(outer,height,start,end);
    sector(inner,height,0,360);
  }
}

arc(8,10,5,30,60);

