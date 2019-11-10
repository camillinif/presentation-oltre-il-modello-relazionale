# schema

CALL db.schema()

# tutti i meetup

MATCH (m:Meetup)
return m


# tutti i meetup ed i relativi Tag

MATCH (m:Meetup)-[r:TAGGED]->(t:Tag)
RETURN m,r,t

# meetup a cui Assunta ha partecipato

MATCH (u:User)-[r:JOINED]->(m:Meetup)
WHERE u.name="Assunta V."
return u,m,r

# utenti che hanno creato meetup e relativi meetup

MATCH (u:User)-[c:CREATED]->(m:Meetup)
return u,m,c

# tutte le relazioni di un utente

MATCH (u:User {name:"Enrico R."})-[r]->(o)
RETURN u,r,o

# iscrizioni a meetup dopo il 01/01/2017

MATCH (u:User)-[r:JOINED]->(m:Meetup)
WHERE r.when > apoc.date.parse('01/01/2017', 'ms', 'dd/MM/yyyy')
RETURN u,r,m

# top 5 meetup

MATCH (m:Meetup)
WITH m, size(()-[:JOINED]->(m)) as degree
ORDER BY degree DESC
RETURN m.name, degree
LIMIT 5

# top utenti piú attivi

MATCH (u:User)
WITH u, size((u)-[:JOINED]->(:Meetup)) as degree
ORDER BY degree DESC
RETURN u.name, degree
LIMIT 10

# utenti con piú interessi

MATCH (u:User)-[:JOINED]->(:Meetup)-[:TAGGED]->(t:Tag)
WITH u, SIZE(COLLECT(DISTINCT t)) as interests
ORDER BY interests DESC
RETURN u.name, interests
LIMIT 10

# percorso piú corto tra due nodi

MATCH (u1:User {name:"Piero S."}), (u2:User {name:"Eros B."}), p=shortestPath((u1)-[*]-(u2))
RETURN u1,u2,p

# Quali meetup suggeriresti a Eros in base ai sui amici?

MATCH (eros:User {name: "Eros B."}),
    (eros)-[:JOINED]->(:Meetup)<-[:JOINED]-(colleague:User),
    (colleague)-[:JOINED]->(newMeetup:Meetup)
WHERE NOT (eros)-[:JOINED]->(newMeetup)
RETURN newMeetup.name, COUNT(DISTINCT colleague.name) AS occurrences
ORDER BY occurrences DESC;

# Quali meetup suggeriresti a Eros in base alle sue preferenze?

MATCH(eros:User {name: "Eros B."}),
    (eros)-[:JOINED]->(m:Meetup),
    (meetup:Meetup)-[:TAGGED]->(tag:Tag)<-[:TAGGED]-(newMeetup:Meetup)
WHERE NOT (eros)-[:JOINED]->(newMeetup)
return newMeetup