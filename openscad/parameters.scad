//The dimensions of all other components depend on those of the square absorbers
square_absorber_height=9.8;
square_absorber_width=9.6;
square_absorber_thickness=2;

square_absorber_horizontal_gap=0.4;
square_absorber_vertical_gap=0.1897;
square_absorber_longitudinal_gap=0.34;

// holes in the square absorbers, cblocks, and master plates for placing connector pins.  
conn_hole_spacing=5;
conn_hole_depth=1;
conn_hole_radius=0.25;

// BPC total dimensions
bpc_length=150;
bpc_first_hole_radius=15;
bpc_last_hole_radius=19;
bpc_layer_thickness=square_absorber_thickness+square_absorber_longitudinal_gap;
bpc_nlayers=floor(bpc_length/bpc_layer_thickness);
function bpc_hole_radius(i)=bpc_first_hole_radius+(bpc_last_hole_radius-bpc_first_hole_radius)*i/bpc_nlayers;
//this value has not been finalized
bpc_outer_gap=2;






//scintillator
spider_scint_thickness=0.3;
spider_scint_height=square_absorber_height*6+5*square_absorber_vertical_gap;
spider_scint_width=square_absorber_width*3+3*square_absorber_horizontal_gap-bpc_outer_gap;
spider_scint_inner_gap=square_absorber_horizontal_gap/2;


//pcb
pcb_thickness=.236;

// ESR film
ESR_film_thickness=.015;

//air gap
air_gap_thickness=0.02;

//cover
cover_thickness=0.2;

//cblock
cblock_thickness=bpc_layer_thickness-pcb_thickness-spider_scint_thickness-2*air_gap_thickness-2*ESR_film_thickness-cover_thickness;
cblock_height=square_absorber_height*6+5*square_absorber_vertical_gap;
cblock_width=square_absorber_width*3+3*square_absorber_horizontal_gap-bpc_outer_gap;
cblock_inner_gap=square_absorber_horizontal_gap/2;


