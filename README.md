# svgtodxfcnc3040

I needed some automatic tool to create DXF files for my laser-CNC3040 from my SVG drawings. It turned out to be not trivial at all, but finally it worked out.

I have folders in each is an SVG drawing with parts. Each drawing contains 3 layers (1) guidelines and text writings (2) half-cutting (3) cutting. 
an example will be here later.

What I try to achive is that each layer is converted into a single DFX file. Addidionally, this file needs to be mirrored (as it will be mirrored again at the CNC 3040)

The solution I have is not perfect, there seems to be issues with paper sizes, however, this does not affect the printer at the end.

Additionally, the script collects all SVG drawings into a single overview PDF with paths to original files. 
