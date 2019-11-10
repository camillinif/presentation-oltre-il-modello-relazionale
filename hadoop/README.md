# Hadoop

## Obiettivo

Utilizzare Hadoop per contare il numero di occorrenze di ciascuna parola all'interno dei file di testo contenuti all'interno della cartella `input`.
Consiglio di mantenere 2 tab aperte in console per

- visualizzazione stato e log processi hadoop
- esecuzione comandi

## Step

- Avviare lo stack di servizi necessari per utilizzare Hadoop (eseguire questo comando nella prima console tab)

`docker-compose up`

Eseguire i successivi comandi nella seconda console tab

- Aprire una console all'interno del container che gestire il file system virtuale `hdfs`

`docker exec -it namenode bash`

- Creare la cartella `input` all'interno del file system virtuale

`hadoop fs -mkdir -p input`

- Copiare il contenuto della cartella `input` all'interno della cartella virtuale `input`

`hdfs dfs -put ./input/* input`

- Avviare l'esecuzione del job java all'interno di Hadoop

`hadoop jar count_word.jar org.apache.hadoop.examples.WordCount input output`

- Visualizzare l'output ottenuto

`hdfs dfs -cat output/part-r-00000`

- Scaricare il file di output dal file system virtuale

`hadoop fs -get output/part-r-00000 input`
