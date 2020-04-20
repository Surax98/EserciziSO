#!/bin/bash
if [ "$#" -lt "2" ]; then
	echo "Servono 2 o più argomenti"
	exit
fi

array=( "$@" )

((indice=1))
while [ $indice -ne $# ]
do	
	if [ -d ${array[$indice]} ]; then
		echo "Impossibile eseguire lo script: ${array[$indice]} non è un file, ma una cartella"
		exit
	elif [ ! -f ${array[$indice]} ]; then
		echo "Il file ${array[$indice]} non esiste"
		exit
	fi
	((indice=indice+1))
done

# Il primo  while serve solamente a controllare che i file inseriti esistano e non siano cartelle 
# (ho sfruttato il fatto che fossero inseriti in un array per scorrerli rapidamente tutti quanti e mostrare quali fossero quelli problematici)

((indice=$#-1))
stringa=""
while [ $indice -ne 0 ]
do	
	stringa+="${array[$indice]} "
	((indice=indice-1))
done

	cat $stringa >> $1

# In questo secondo while, itero lungo l'array partendo, anzichè dal primo elemento, dall'ultimo elemento, per far sì di appendere i file dall'ultimo al primo
# Durante l'iterazione, vado a concatenare argomenti all'interno della variabile stringa per fare in modo di poter usare un unico comando cat per appendere tutti i file al primo argomento passatogli

