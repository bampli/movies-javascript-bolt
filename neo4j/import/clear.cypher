MATCH (n)-[r]->() DELETE r,n;
MATCH (n) DETACH DELETE n;
