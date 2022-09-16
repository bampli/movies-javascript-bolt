//:auto
//USING PERIODIC COMMIT 1000
LOAD CSV WITH HEADERS FROM 'file:///credits.csv' AS row

MATCH (m:Movie { id: toInteger(row.id) })

FOREACH (cast IN apoc.convert.fromJsonList(row.cast) |
    MERGE (p:Person { id: toInteger(cast.id) })
    ON CREATE SET p.name = cast.name, p.gender = cast.gender, p.profile_path = cast.profile_path

    MERGE (p)-[r:CAST_FOR]->(m)
    ON CREATE SET r += cast {
        .credit_id,
        .cast_id,
        .character,
        .order
    }
)

FOREACH (crew IN apoc.convert.fromJsonList(row.crew) |
    MERGE (p:Person { id: toInteger(crew.id) })
    ON CREATE SET p.name = crew.name, p.gender = crew.gender, p.profile_path = crew.profile_path

    MERGE (p)-[r:CREW_FOR]->(m)
    ON CREATE SET r += crew {
        .credit_id,
        .department,
        .job
    }
);
