//:auto
//USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS FROM 'file:///keywords.csv' AS row
MATCH (m:Movie { id: toInteger(row.id) })

FOREACH (keyword IN apoc.convert.fromJsonList(row.keywords) |
    MERGE (k:Keyword {id: keyword.id})
    ON CREATE SET k.name = keyword.name

    MERGE (m)-[:HAS_KEYWORD]->(k)
);
