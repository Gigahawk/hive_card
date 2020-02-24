// Code printed on the bottom of your membership card
code = "12345";

// Small to mimic the original card, regular for credit card size
size = "R"; // [S:Small, R:Regular]

// Layer height for your print
layer_height = 0.3; // [0.1:0.05:0.4]

// Number of layers to print
layers = 2; // [2:8]

// Keychain hole
hole = false;

// Visual preview of card (uncheck for export)
preview = true;

padded_code = str("*", code, "*");
total_height = layers*layer_height;
preview_bot_height = (layers - 1)*layer_height;


module card(size="R", hole=false) {
    small_width = 54.25;
    small_height = 28.75;
    small_radius = 2.7;

    regular_width = 85.60;
    regular_height = 53.98;
    regular_radius = 3;

    keyring_dia = 4.65;
    keyring_x = 3.5 + keyring_dia/2;

    width = size == "R" ? regular_width : (size == "S" ? small_width : null);
    height = size == "R" ? regular_height : (size == "S" ? small_height : null);
    radius = size == "R" ? regular_radius : (size == "S" ? small_radius : null);
    keyring_y = height/2;

    difference() {
        hull() {
            translate([radius, radius])
                circle(r=radius);
            translate([width - radius, radius])
                circle(r=radius);
            translate([radius, height - radius])
                circle(r=radius);
            translate([width - radius, height - radius])
                circle(r=radius);
        }
        if(hole)
            translate([keyring_x, keyring_y])
                circle(d=keyring_dia);
    }
}


if(preview) {
    color("black") {
        linear_extrude(height=preview_bot_height)
            card(size=size, hole=hole);
    }
    color("white") {
        translate([0, 0, preview_bot_height])
            linear_extrude(height=layer_height)
                card(size=size, hole=hole);
    }
} else {
    difference() {
        linear_extrude(height=total_height)
            card(size=size, hole=hole);
    }
}

