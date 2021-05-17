#!/bin/bash
rm cv-1.png || :
pdftoppm ptbr/sample.pdf cv -png
