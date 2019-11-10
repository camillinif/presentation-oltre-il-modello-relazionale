# Neo4J

## Obiettivo

Popolare una instanza Neo4j con un dump ed effettuare delle query per testare le potenzialitá di un database a grafo

## Caricamento dei dati

- Aprire una console all'interno del container contenente l'istanza di Neo4j

`docker-compose run neo4j bash`

- Caricare il dump

`./bin/neo4j-admin load --from=/import/meetups.dump --database=graph.db --force`

- Avviare il server Neo4j

`docker-compose up`

- Al termine dell'avviamento del server, collegarsi all'interfaccia di amministrazione web di Neo4j

`http://localhost:7474`

- Utilizzare le query presenti all'interno del file `query.cypher` oppure scriverne di proprie utilizzando la sintassi `cypher` per testare le possibilitá del database Neo4J

