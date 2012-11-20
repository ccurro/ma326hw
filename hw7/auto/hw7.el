(TeX-add-style-hook "hw7"
 (lambda ()
    (TeX-add-symbols
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
     "latex2e"
     "art12"
     "article"
     "letterpaper"
     "12pt"
     "qs/2"
     "qs/3"
     "qs/7"
     "qs/9"
     "qs/11")))

