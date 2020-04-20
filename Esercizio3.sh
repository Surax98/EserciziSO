#!/bin/bash
if  [ $# = 1 ]; then
	if [[ -d "$1" ]]; then
		if [ -e $1.tar.gz ]; then
			while true; do
				read -p "L'archivio $1.tar esiste già. Desidera sovrascriverlo? [S/N]" choice
				case $choice in
					[Ss] ) rm $1.tar; break;;
					[Nn] ) echo "Uscita dal programma"
						exit;;
					* ) echo "Selezionare o S o N";;
				esac
			done
		fi
		echo "Creo l'archivio"
			if tar -zcf $1.tar.gz $1; then
				echo "La creazione dell'archivio è andata a buon fine e sono presenti i seguenti file:"
				tar -tf $1.tar.gz
			else
				echo "Errore nella creazione del file"
			fi

	else
		echo "L'elemento passato non è una directory"
	fi
else
	echo "Il parametro inserito dev'essere esattamente uno:
Sintassi -> Esercizio3.sh nomedirectory"
fi

#Ho deciso di utilizzare diversi if, anche se sicuramente non è la soluzione più elegante. Nel primo if ho inserito come condizione il controllo del numero di parametri, che dev'essere uno
#nel secondo if controllo se il parametro sia una directory, mentre nel terzo if si controlla l'esistenza del file compresso
#All'interno del terzo if, il while fa in modo che si possa scegliere se sovrascrivere un archivio con lo stesso nome già esistente
#Dopo aver controllato il tutto, in caso affermativo, si procede alla creazione dell'archivio con il comando tar ma senza il parametro v, in quanto verranno mostrati in seguito gli elementi archiviati
