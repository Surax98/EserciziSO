#!/bin/bash
if [ $# -eq 2 ] && [ -f $1 ] && [ -f $2 ]; then #con questo if controllo il numero di argomenti ed il loro tipo (esattamente 2 file, non sono ammesse directory)

	stringa=$(echo "$1" | cut -d"." -f1)$(echo "$2" | cut -d"." -f1)		#rimozione delle estensioni dal nome del file per la creazione dell'archivio compresso

	while true; do	#questo while consente di mostrare ripetutamente il menù di selezione in caso di scelta errata
		read -p "Selezionare un'opzione tra le seguenti (digitare il numero corrispondente e premere invio):
		1. rimuovere entrambi i file
		2. archiviare entrambi i file
		3. appendere il file f1 al file f2
		4. esci
		" choice #con il read riesco a creare sia un menù visibile che ad archiviare la scelta all'interno della variabile choice
			case $choice in
				[1] ) while true; do
						read -p "Sicuro di voler rimuovere i file $1 e $2? [S/N]" choice2
						case $choice2 in
							[Ss] )   if rm $1 $2; then		#scelta 1: comando di rimozione dei file 1 e 2
									echo "File $1 e $2 rimossi con successo"
								else
									echo "Errore nell'eliminazione dei file $1 e $2"
								fi
								break;;
							[Nn] ) echo "Uscita dal programma"
								exit;;
							* ) echo "Selezionare o S o N";;
						esac
					done;;
											


				[2] ) if [ -e $stringa.tar.gz ]; then 		#scelta 2: archivio dei file 1 e 2 in un file tar
					while true; do		#while con la stessa funzione del primo, in questo caso per scegliere se sovrascrivere o meno un archivio già esistente
						read -p "L'archivio $stringa.tar.gz esiste già. Desidera sovrascriverlo? [S/N]" choice2
						case $choice2 in
							[Ss] ) rm $stringa.tar.gz
								 break;;
							[Nn] ) echo "Uscita dal programma"
								exit;;
							* ) echo "Selezionare o S o N";;
						esac
					done
					fi

					if tar -zcf $stringa.tar.gz $1 $2; then 	#comando per l'archiviazione dei file 1 e 2 senza il parametro v (non verbose)
						echo "Archivio $stringa.tar.gz creato con successo"
					else
						echo "Errore nella creazione dell'archivio"
					fi
					break;;

				[3] ) if cat $1 >> $2; then	#scelta 3: comando per leggere il file 1 ed appenderlo al file 2
						echo "File $1 appeso al file $2 con successo"
					else
						echo "Errore nell'appendere il file $1 al file $2"
					fi				
					break;;

				[4] ) echo "Uscita dal programma"	#scelta 4: uscita dal programma
					exit;;
				* ) echo "Selezionare una tra le opzioni disponibili";;
			esac
	done
elif [ -d $1 ] || [ -d $2 ]; then
	echo "Gli argomenti non possono essere cartelle"
else
	echo "Per poter eseguire lo script, il numero di argomenti dev'essere pari a 2"
fi
