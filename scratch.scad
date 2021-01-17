/*
parametric fipple practice.  many interdependencies.

- block/windway should be made separate part
- max lip length (at 15°) should be limit of this section 
- need coupler fitting
- fitting could extend into window at its maximum depth
- need architecture for interdependencies and geometry helpers
*/
module pipe(inner,outer){
    difference() {
        cylinder(r=outer,h=30);
        difference() {
            cylinder(r=inner,h=30);
            // lip extension
            translate([6,-6,0]) cube([2,13,30]);
            // block
            cylinder(r=outer,h=7);
        }
    }
}


module lip() {
    translate([0,-5,0])
    difference() {
        rotate([0, 45, 0])
        cube([10,10,10]);
        translate([0,0,-10])
        cube([15,10,10]);
        translate([5*sqrt(2),0,0])
        cube([10,10,10]);    
    }
}

difference(){
    pipe(8,10);
    translate([6,0,10]) lip();
    // window
    translate([6,-5,7]) cube([10,10,3]);
    // windway (bottom cut from block)
    translate([5,-5,0]) cube([2,10,10]);    
}

