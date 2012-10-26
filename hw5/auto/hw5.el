(TeX-add-style-hook "hw5"
 (lambda ()
    (TeX-add-symbols
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
     "stmaryrd"
     "amsfonts"
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
     "./qs/2"
     "./qs/8"
     "./qs/11"
     "./qs/14"
     "./qs/15"
     "qs/10"
     "qs/23"
     "qs/29"
     "qs/30"
     "qs/12"
     "qs/15")))

