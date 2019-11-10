SELECT p2.nome, m1.titolo
FROM persone as p1
JOIN attore a1 ON p1.id = a1.persona_id
JOIN film f1 ON a1.film_id = f1.id
JOIN attore a2 ON a2.film_id = f1.film_id
JOIN persone p2 ON p2.id = a2.persona_id
WHERE p1.nome = 'Keanu Reeves'
