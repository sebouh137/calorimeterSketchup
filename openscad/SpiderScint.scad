include<parameters.scad>


echo("height is", spider_scint_height);
echo("width is", spider_scint_width);

module spider_scint(hole_radius, azimuthal_cells=20, groove_width=0.2, groove_depth=0.2,thickness=0.3, cell_radius_delta=2.5, height=spider_scint_height, width=spider_scint_width,cell_center_min_distance_from_edge=.3,inner_gap=spider_scint_inner_gap)
{   
    epsilon=0.1;
    diagonal=sqrt(height*height/4+width*width);
    delta_phi=180/azimuthal_cells;
    rotate([0,0,90]) difference() {
        //board
        difference() {
            translate([-width/2-inner_gap, 0, 0]) cube([width, thickness, height],center= true);
            rotate([90,0,0]) cylinder(h=.5, r=hole_radius,center=true);
            
        }
        //radial grooves
        for (phi = [delta_phi:delta_phi:180]) {
            rotate([ 0, phi, 0]) translate([0, thickness/2-groove_depth/2,0]) cube([groove_width, groove_depth,diagonal*2.2], center=true);
        }
        //concentric grooves
        for (r = [hole_radius+cell_radius_delta:cell_radius_delta:diagonal]) {
            
            translate([0, thickness/2-groove_depth/2+epsilon/2,0]) rotate([90, 0,0]) difference () {
                cylinder(h=groove_depth+epsilon, r1=r+groove_width/2,r2=r+groove_width/2, center=true);
                cylinder(h=groove_depth+epsilon, r1=r-groove_width/2,r2=r-groove_width/2, center=true);
                //remove wedges from the groove in order to merge cells near the outer edge (if necessary)
                for(phi = [0:delta_phi:45]){
                    if (abs((r+cell_radius_delta/2)*cos(phi-delta_phi/2))>width+inner_gap-cell_center_min_distance_from_edge) {
                        linear_extrude(groove_depth*10, center=true)
                            polygon([[0,0],[-2*r*cos(phi),2*r*sin(phi)], [-2*r*cos(phi), -2*r*sin(phi)]]);
                        
                    }
                    if (abs((r+cell_radius_delta/2)*cos(phi-delta_phi/2))>height/2-cell_center_min_distance_from_edge){
                        linear_extrude(groove_depth*10, center=true)
                            polygon([[-2*r*cos(90-phi),2*r*sin(90-phi)],[0,0], [-2*r*cos(90-phi), -2*r*sin(90-phi)], [2*r, -2*r],[2*r, 2*r]]);
                        
                    }      
                }
            }    
        }
        //dimple
        dimple_sphere_radius=.38;
        dimple_depth=.16;
        for(r = [hole_radius+cell_radius_delta/2:cell_radius_delta:diagonal])
            for(phi = [90+delta_phi/2:delta_phi:270])
                if(abs(r*cos(phi))<width+inner_gap-cell_center_min_distance_from_edge && abs(r*sin(phi))<height/2-cell_center_min_distance_from_edge)
                translate([r*cos(phi),thickness/2+(dimple_sphere_radius-dimple_depth),r*sin(phi)]) sphere(dimple_sphere_radius, $fn=20);
            
        
    }
}

spider_scint(hole_radius=19);

//color([0.9,0.9,.9,0.3]) for (i = [0:3])
    //echo("hole radius",bpc_hole_radius(i))
//    translate([2.34*i,0, 0]) spider_scint(hole_radius=bpc_hole_radius(i));


