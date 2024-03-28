#!/bin/bash
rm cv-ptbr-1.png || :
pdftoppm ptbr/marcelo-vironda-rozanti.pdf cv-ptbr -png
