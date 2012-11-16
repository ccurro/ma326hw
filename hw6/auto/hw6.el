(TeX-add-style-hook "hw6"
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
     "./qs/1"
     "./qs/5"
     "./qs/6"
     "qs/3"
     "qs/4"
     "qs/7"
     "qs/12"
     "qs/14"
     "qs/15"
     "qs/19"
     "qs/22")))

