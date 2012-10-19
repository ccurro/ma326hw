(TeX-add-style-hook "hw4"
 (lambda ()
    (TeX-add-symbols
     '("mfrac" 2)
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
     "./qs/5"
     "./qs/12"
     "qs/6"
     "qs/14"
     "qs/20"
     "qs/2"
     "qs/3"
     "qs/7"
     "qs/9"
     "qs/10")))

