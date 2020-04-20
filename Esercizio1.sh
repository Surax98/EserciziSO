#!/bin/bash
cat /etc/passwd | grep '/home' | cut -d: -f1,6
#cat serve a leggere il contenuto di un file di testo, 
#con grep seleziono solamente quelle righe che contento la stringa"/home" 
#e con cut stampo su terminale il contenuto delle singole righe contenenti il solo valore "/home", avendo cura di selezionare soltanto il primo e sesto elemento con il parametro f1,6
#(gli elementi sono separati da : come specificato con d) 
