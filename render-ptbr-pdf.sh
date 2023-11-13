#!/bin/bash
rm cv-ptbr-1.png || :
pdftoppm ptbr/sample.pdf cv-ptbr -png
