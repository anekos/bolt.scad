$fn = 70;

// Config {{{

length = 43;
lay = true;

cap_hole_length = 3;
tolerance = 0.5;

bars = 3;

// }}}

// Const {{{

total_length = length + cap_hole_length * 2;
cap_thickness = 2;
cap_diameter = diameter + tolerance + cap_thickness;

// }}}

module bar() // {{{
{
    if (lay)
    {
        rotate([ 0, 90, 0 ])
        {
            cylinder(h = total_length, d = diameter);
        }
    }
    else
    {
        cylinder(h = total_length, d = diameter);
    }
} // }}}

module cap() // {{{
{
    difference()
    {
        cylinder(h = cap_hole_length, d = cap_diameter);
        cylinder(h = cap_hole_length, d = diameter + tolerance);
    }
} // }}}

module jig() // {{{
{
    difference()
    {
        d = cap_diameter * 3;
        l = cap_hole_length * 3;
        union()
        {
            cylinder(h = l, d = d);
            translate([ 0, 0, l ])
            {
                sphere(r = d / 2);
            }
        }
        union(){
            translate([0, diameter + tolerance * 3])
            {
                cylinder(h = l, d = diameter + tolerance * 4);
                cylinder(h = 2, d = cap_diameter + tolerance * 2);
            }
        }
    }
} // }}}

module main() // {{{
{
    for (i = [0:bars - 1])
    {
        translate([ 0, -i * (diameter + 5), diameter / 2 ])
        {
            bar();
        }
    }

    for (i = [0:bars * 2 - 1])
    {
        translate([ i * (cap_diameter + 5), diameter * 2, 0 ])
        {
            cap();
        }
    }

    for (i = [1:2])
    {
        translate([ -cap_diameter * 5 * i, 0, 0 ])
        {
            jig();
        }
    }
} // }}}

main();
