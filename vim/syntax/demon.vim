"AM: BEGIN OF .vim/syntax/demon.vim
" Created by Jonny Johannes, based on the work of charmm.vim, September 30, 2013

syn sync clear
syn sync fromstart
syn case ignore

syn match Comment "[#].*$"
"floating point number, with dot, optional exponent
syn match cFloat "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
"floating point number, starting with a dot, optional exponent
syn match cFloat "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
"floating point number, without dot, with exponent
syn match cFloat "\d\+e[-+]\=\d\+[fl]\=\>"
syn match cNumber "0x\x\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match cNumber "\<[-+]\=\d\+\>"
highlight def link cNumber Constant
highlight def link cFloat Constant
highlight Comment ctermfg=Grey

syn match Title "^title.*$"
highlight Title ctermfg=DarkGreen

syn match Statement "^\s*AUXIS\w*\>"
syn match Statement "^\s*BASIS\w*\>"
syn match Statement "^\s*BATH\w*\>"
syn match Statement "^\s*BOX\w*\>"
syn match Statement "^\s*CFPINTEGRATION\w*\>"
syn match Statement "^\s*CHARGE\w*\>"
syn match Statement "^\s*CONFIGURE\w*\>"
syn match Statement "^\s*CONSTANTS\w*\>"
syn match Statement "^\s*CPSEARCH\w*\>"
syn match Statement "^\s*DAVIDSON\w*\>"
syn match Statement "^\s*DIIS\w*\>"
syn match Statement "^\s*DIPOLE\w*\>"
syn match Statement "^\s*DISPERSION\w*\>"
syn match Statement "^\s*DOS\w*\>"
syn match Statement "^\s*DYNAMICS\w*\>"
syn match Statement "^\s*ECPS\w*\>"
syn match Statement "^\s*EMBED\w*\>"
syn match Statement "^\s*ERIS\w*\>"
syn match Statement "^\s*EXCITATION\w*\>"
syn match Statement "^\s*FIXMOS\w*\>"
syn match Statement "^\s*FREEZE\w*\>"
syn match Statement "^\s*FREQUENCY\w*\>"
syn match Statement "^\s*GEOMETRY\w*\>"
syn match Statement "^\s*GEOSURFACE\w*\>"
syn match Statement "^\s*GRID\w*\>"
syn match Statement "^\s*GUESS\w*\>"
syn match Statement "^\s*HESSIAN\w*\>"
syn match Statement "^\s*IRC\w*\>"
syn match Statement "^\s*ISOSURFACE\w*\>"
syn match Statement "^\s*LOCALIZATION\w*\>"
syn match Statement "^\s*LPCONSERVE\w*\>"
syn match Statement "^\s*MATDIA\w*\>"
syn match Statement "^\s*MATINV\w*\>"
syn match Statement "^\s*MCPS\w*\>"
syn match Statement "^\s*MIXING\w*\>"
syn match Statement "^\s*MOEXCHANGE\w*\>"
syn match Statement "^\s*MULTIPLICITY\w*\>"
syn match Statement "^\s*NMR\w*\>"
syn match Statement "^\s*NONCOLLINEAR\w*\>"
syn match Statement "^\s*NQR\w*\>"
syn match Statement "^\s*OPTIMIZATION\w*\>"
syn match Statement "^\s*ORBITALS\w*\>"
syn match Statement "^\s*PARALLEL\w*\>"
syn match Statement "^\s*PHASE\w*\>"
syn match Statement "^\s*PLOT\w*\>"
syn match Statement "^\s*POINTS\w*\>"
syn match Statement "^\s*POLARIZABILITY\w*\>"
syn match Statement "^\s*POPULATION\w*\>"
syn match Statement "^\s*PRINT\w*\>"
syn match Statement "^\s*PRODUCT\w*\>"
syn match Statement "^\s*QUADRATURE\w*\>"
syn match Statement "^\s*REACTANT \w*\>"
syn match Statement "^\s*SADDLE\w*\>"
syn match Statement "^\s*SCAN\w*\>"
syn match Statement "^\s*SCFTYPE\w*\>"
syn match Statement "^\s*SHIFT\w*\>"
syn match Statement "^\s*SIGPI\w*\>"
syn match Statement "^\s*SIMULATION\w*\>"
syn match Statement "^\s*SMEAR\w*\>"
syn match Statement "^\s*STEPTYPE\w*\>"
syn match Statement "^\s*SYMMETRY\w*\>"
syn match Statement "^\s*THERMO\w*\>"
syn match Statement "^\s*TOPOLOGY\w*\>"
syn match Statement "^\s*TRAJECTORY\w*\>"
syn match Statement "^\s*UPDATE\w*\>"
syn match Statement "^\s*VARIABLES\w*\>"
syn match Statement "^\s*VELOCITIES\w*\>"
syn match Statement "^\s*VISUALIZATION\w*\>"
syn match Statement "^\s*VXCTYPE\w*\>"
syn match Statement "^\s*WEIGHTING\w*\>"

highlight Statement ctermfg=Brown

"syn region CursorLine start="-\s*\([!].*\)\=$" end="\<" contains=Comment

let b:current_syntax = "deMon"
colorscheme vividchalk
"AM: END OF .vim/syntax/demon.vim

