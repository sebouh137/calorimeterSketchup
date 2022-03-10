include<parameters.scad>
echo("Cblock thickness", cblock_thickness);
module cblock(hole_radius,thickness=cblock_thickness, height=cblock_height, width=cblock_width,inner_gap=cblock_inner_gap)
{   
    epsilon=0.1;
    rotate([0,0,90]) difference() {
        //board
        difference() {
            translate([-width/2-inner_gap/2, 0, 0]) cube([width, thickness, height],center= true);
            rotate([90,0,0]) cylinder(h=10, r=hole_radius,center=true);
            
        }
        // holes on top and bottom
        for (x = [conn_hole_spacing/2:-conn_hole_spacing:-width]) {
            translate([x,0,height/2-conn_hole_depth/2+epsilon/2]) cylinder(conn_hole_depth+epsilon, conn_hole_radius, conn_hole_radius, true, $fn=24);
            translate([x,0,-(height/2-conn_hole_depth/2+epsilon/2)]) cylinder(conn_hole_depth-epsilon, conn_hole_radius, conn_hole_radius, true, $fn=24);
            
        }
        
    }
}
//cblock(hole_radius=15);
for (i = [0:3])
    //echo("hole radius",bpc_hole_radius(i))
    translate([2.34*i,0, 0]) cblock(hole_radius=bpc_hole_radius(i));