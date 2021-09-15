PLOTNAME=IL2

PDFS=""
find ./$PLOTNAME -name "*dxf" -exec rm -rf {} \;
mkdir -p ./tmppdf
for d in $(find ./$PLOTNAME -name "*.svg" | sort)
do
 echo "Working on: $d"
  #Do something, the directory is accessible with $d:
  svgname="$(basename -s .svg $d)"
  inkscape $d -o "./tmppdf/$svgname.pdf"
  echo $(dirname "${d}") | enscript  -B -f Courier-Bold16 -o- | ps2pdf - | pdftk "./tmppdf/$svgname.pdf" stamp - output "./tmppdf/stamped_$svgname.pdf"
 
  
  
  
  PDFS="$PDFS ./tmppdf/stamped_$svgname.pdf"
  python intolayers.py "$d" "./tmp"
  DIR=$(dirname "${d}")
  
    for r in $(find ./tmp -name "*.svg" |sort)
    do
        #Do something, the directory is accessible with $d:
        #inkscape $r --export-eps $r.eps
        e=$r.eps
        inkscape $r -o $r.eps
        
        pstops  -p a3 H  "$e" "$e.flipped.eps"
        ps2pdf -dEPSCrop "$e.flipped.eps" "$e.flipped.ps.pdf"
        pdf2ps "$e.flipped.ps.pdf" "$e.flipped.ps.pdf.back.eps"
        layername="$(basename -s .svg $r)"
        pstoedit -dt -f 'dxf_s:-splineasbezier -mm' "$e.flipped.ps.pdf.back.eps" "$DIR/${layername}_$svgname.dxf" >/dev/null 2>&1
    done 
    rm ./tmp/*
done 

pdfunite $PDFS $DIR/$PLOTNAME-complett.pdf
rm -R ./tmppdf
rm -R ./tmp
rm  $DIR.zip
zip -r $DIR.zip $DIR
