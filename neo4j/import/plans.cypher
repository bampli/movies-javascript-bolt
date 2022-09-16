//CREATE CONSTRAINT ON (p:Plan) ASSERT p.id IS UNIQUE;
//CREATE CONSTRAINT ON (s:Subscription) ASSERT s.id IS UNIQUE;

// Regular plans
LOAD CSV WITH HEADERS FROM 'file:///plans.csv' AS row
MERGE (p:Plan {id: toInteger(row.id)})
SET p.name = row.name,
  p.duration = duration('P'+ row.days +'D'),
  p.price = toFloat(row.price)

FOREACH (name IN split(row.genres, '|') |
	MERGE (g:Genre {name: name})
  MERGE (p)-[:PROVIDES_ACCESS_TO]->(g)
);

// FOREACH (name IN split(row.genres, '|') |
// 	MERGE (g:Genre {name: name, id: apoc.text.random(2, "0-9")})
//   MERGE (p)-[:PROVIDES_ACCESS_TO]->(g)
// );

// Free Trial
CREATE (p:Plan {
  id: 0,
  name: "Free Trial",
  price: 0.00,
  duration: duration('P30D')
})
WITH p
MATCH (g:Genre)
CREATE (p)-[:PROVIDES_ACCESS_TO]->(g);

