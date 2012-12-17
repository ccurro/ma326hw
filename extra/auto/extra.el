(TeX-add-style-hook "extra"
 (lambda ()
    (TeX-add-symbols
     '("norm" 1)
     '("M" 3)
     '("mfrac" 2)
     '("dete" 1)
     '("dime" 1)
     '("rank" 1)
     '("tr" 1)
     "tab"
     "gap"
     "T"
     "U"
     "V"
     "W"
     "bigzero")
    (TeX-run-style-hooks
     "fancyhdr"
     "geometry"
     "right=1.2in"
     "left=1.2in"
     "bottom=1in"
     "top=1in"
     "verbatim"
     "appendix"
     "microtype"
     "siunitx"
     "url"
     "multirow"
     "mathtools"
     "gauss"
     "booktabs"
     "stmaryrd"
     "amsfonts"
     "amsthm"
     "amssymb"
     "amsmath"
     "graphicx"
     "enumerate"
     "babel"
     "english"
     "inputenc"
     "utf8"
     "setspace"
     ""
     "latex2e"
     "art12"
     "article"
     "12pt"
     "letterpaper")))

