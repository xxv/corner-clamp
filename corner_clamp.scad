size = [30, 30, 12];
//overhang = [10, 10, 0];
overhang = [0, 0, 0];

radius = 53;
extension = 3;
groove_d = 4;

corner_notch_r = 6;

smidge = 0.01;

$fn=120;

preview_box = [94, 94, 32] + [6, 6, 6];

%translate([-preview_box.x, -preview_box.y, 0] + [size.x, size.y, 0])
  cube(preview_box);
bracket();

module bracket() {
  difference() {
    pie_slice(radius + extension, size.z);
    translate([-smidge, -smidge, -smidge])
      cube(size + [smidge, smidge, smidge * 2]);
    // notch
    translate([size.x, size.y, -smidge])
      cylinder(r=corner_notch_r, h=size.z + smidge * 2);

    translate([0, 0, size.z * (1/4) - groove_d/2])
      groove(radius, groove_d);
    translate([0, 0, size.z * (3/4) - groove_d/2])
      groove(radius, groove_d);
  }
  translate([size.x, -overhang.y, 0])
    cube([radius - size.x, overhang.y, size.z]);

  translate([-overhang.x, size.y, 0])
    cube([overhang.x, radius - size.y, size.z]);
}

module groove(r, d) {
  translate([0, 0, d/2])
  rotate_extrude(convexity = 10)
    translate([r, 0, 0])
      circle(d = d);
}

module pie_slice(r, h) {
  intersection() {
    cylinder(r=r, h=h);
    cube([r, r, h]);
  }
}
