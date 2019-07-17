#!/bin/bash
rm cv-1.png || :
pdftoppm en/sample.pdf cv -png
