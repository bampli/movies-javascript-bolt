LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row

MERGE (u:User {id: toInteger(row.id)})
SET u.email = row.email,
    u.firstname = row.firstname,
    u.lastname = row.lastname,
    u.dateOfBirth = date(row.dateofbirth);

// MERGE (s:Subscription {id: toInteger(row.id)})
// SET s.expiresAt = datetime() + duration('P2M'),
//     s.renewsAt = datetime() + duration('P2M'),
//     s.status = 'active'
// MERGE (u)-[:PURCHASED]->(s)-[:FOR_PLAN]->(p:Plan {id: 2});

// CREATE (u)-[:PURCHASED]->(s:Subscription{
//     id: u.id,
//     expiresAt: datetime() + duration('P2M')
// })-[:FOR_PLAN]->(p:Plan {id: 2});

// LOAD CSV WITH HEADERS FROM 'file:///users.csv' AS row
// MERGE (u:User {id: toInteger(row.id)})
// SET u.email = row.email,
//     u.firstname = row.firstname,
//     u.lastname = row.lastname,
//     u.dateOfBirth = date(row.dateofbirth);

// MERGE (s:Subscription {id: toInteger(row.id)})
// SET s.expiresAt = datetime() + duration('P2M'),
//     s.renewsAt = datetime() + duration('P2M'),
//     s.status = 'active',
//     s.orderId = toInteger(row.id)
// CREATE (u)-[:PURCHASED]->(s)-[:FOR_PLAN]->(p:Plan {id: 2});
