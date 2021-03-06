# LaTex utils

This folder contains useful scripts I've implemented while using LaTex
(on Notepad++).

### Bat setup to create a PDF
Simple script that executes all needed commands to build the PDF document
starting from bibliography, sources and text.\
Currently using **pdflatex** and **biber** but can be adjusted to other 
compilers.

Main features:
- only shows warning and errors as outputs
- automatically uses PDF viewer (once path is provided)
- reuses already open instances of the viewer, if it supports it
- quiet mode supported
- auto cleanup procedure

Built upon [prrao answer](https://tex.stackexchange.com/a/44046/218258) in 
[this tex.stackexchange post](https://tex.stackexchange.com/questions/43984/using-notepad-with-miktex-on-windows).

### LaTex command glossary
A simple list of commads with a brief description, to easily review some forgotten
command.