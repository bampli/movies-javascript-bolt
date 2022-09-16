LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row
MERGE (u:User {id: toInteger(row.id)})
SET u.email = row.email,
    u.firstname = row.firstname,
    u.lastname = row.lastname,
    u.dateOfBirth = date(row.dateofbirth)

CREATE (u)-[:PURCHASED]->(s:Subscription{
    id: u.id,
    expiresAt: datetime() + duration('P2M'),
    renewsAt: datetime() + duration('P2M'),
    status: 'active',
    orderId: u.id,
})-[:FOR_PLAN]->(p:Plan {id: 2})
