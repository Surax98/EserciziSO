#!/bin/bash
find /home -type f -mmin -2 | grep 'Cookies'
#il comando find mi permette di trovare tutti i file con una certa caratteristica nella directory specificata
#In questo caso, si è specificato che siano file (e non cartelle) e che siano stati modificati negli ultimi 2 minuti con il predicato cmin
#grep fa in modo di prendere in considerazione solo quelli specificati
