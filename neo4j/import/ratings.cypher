//:auto
//USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS FROM 'file:///ratings.csv' AS row
MATCH (m:Movie { id: toInteger(row.movieId) })
MERGE (u:User { id: toInteger(row.userId) })

MERGE (u)-[r:RATED]->(m)
ON CREATE SET r.rating = toFloat(row.rating), r.timestamp = datetime({epochSeconds: toInteger(row.timestamp)})
