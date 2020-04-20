
indice=0
files=( "$@" )
lineetotali=0
sommatotale=0		#inzializzazione delle variabili globali necessarie al conteggio finale di somma, media, ecc ecc
mediatotale=0
deviazionetotale=0
stringa=""

while [ $indice -ne $# ];
do	
	stringa+="${files[$indice]} " #questa variabile servirà più avanti per calcolare la deviazione standard complessiva
	readarray array < <(cat ${files[$indice]} | cut -d' ' -f2) #archivio i valori del secondo campo nel file in un array temporaneo necessario soltanto per i conti
	somma=0
	tempindex=0
	media=0
	devtemp=0
	deviazione=0
	linee=$(wc -l "${files[$indice]}" | cut -d' ' -f1)

	for i in $(cat "${files[$indice]}" | cut -d' ' -f2); #Ho inserito questo ciclo for qui per fare in modo che lo script proceda ugualmente fin quando non si incontra il file "incriminato".
		do 												 #In questo modo, si faranno tutti i calcoli fino a quando suddetto file non viene analizzato e lo script si andrà a bloccare, segnalando il file
			if ! [[ "$i" =~ ^[0-9]+$ ]]; then
		        echo "Ho trovato un carattere che non è un numero nel file ${files[$indice]}. Si può procedere solamente se sono presenti soltanto numeri"
		        exit
			fi
		done

	


	for i in $(cat "${files[$indice]}" | cut -d' ' -f2); #il ciclo scorre tutto l'array e somma gli elementi precedentemente archiviati
	    do
	        ((somma+=i))
	        ((tempindex++))
	        if [ "$tempindex" -eq "$linee" ]; then		#una volta che ha raggiunto l'ultima linea del file, procede a calcolare la media
	        	media=$(echo "scale=2; $somma/$tempindex" | bc)	

	        	for j in $(cat "${files[$indice]}" | cut -d' ' -f2);	#e con questo for procede a scorrere nuovamente l'array per calcolare la dev. standard sfruttando la media appena calcolata
		        	do
			        	devtemp=$(echo "scale=2; $j-$media" | bc)
			        	devtemp=$(echo "scale=2; $devtemp^2" | bc)				#ho continuamente sovrascritto il valore di devtemp e di deviazione perchè ricevevo errori di sintassi non meglio specificati.
			        															#In questo modo, sono riuscito ad arginare l'errore
			        	deviazione=$(echo "scale=2; $deviazione+$devtemp" | bc)
			        done
			    deviazione=$(echo "scale=2; $deviazione/$tempindex" | bc)
		        deviazione=$(echo "scale=2; sqrt($deviazione)" | bc)
	        fi
		done 
	printf ${files[$indice]} | cut -d'.' -f1 | tr -d "\n"
	printf "  Numero di linee: $linee  "
	printf "Somma: $somma  "
	printf "Media: $media  "
	printf "Deviazione Standard: $deviazione\n"
	

	((sommatotale+=somma))
	((lineetotali+=$linee))
	((indice++))
	
done

mediatotale=$(echo "scale=2; $sommatotale/$lineetotali" | bc) 
unset array

cat $stringa >> "temp.txt"		#genere un file temporaneo e ausiliario al fine di poter calcolare più semplicemente la deviazione standard. Tale file è creato concatenando il contenuto di tutti gli altri passati in argomento
readarray array < <(cat "temp.txt" | cut -d' ' -f2) #uso lo stesso comando di prima, ma questa volta archivio nell'array il secondo campo di TUTTI i file
devtemp=0


for i in ${array[@]};
	do
		devtemp=$(echo "scale=2; $i-$mediatotale" | bc)
		devtemp=$(echo "scale=2; $devtemp^2" | bc)								#calcolo della deviazione standard totale
		deviazionetotale=$(echo "scale=2; $deviazionetotale+$devtemp" | bc)
	done

deviazionetotale=$(echo "scale=2; $deviazionetotale/$lineetotali" | bc)
deviazionetotale=$(echo "scale=2; sqrt($deviazionetotale)" | bc)

printf "TOT:"
printf "  Numero di linee: $lineetotali  "
printf "Somma: $sommatotale  "
printf "Media: $mediatotale  "
printf "Deviazione Standard: $deviazionetotale\n"


rm temp.txt		#rimuovo il file temp.txt, non essendo più utile
