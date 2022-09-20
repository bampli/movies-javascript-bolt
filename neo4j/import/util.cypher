// nice and easy initialization
MERGE (:Movie {title: 'Apollo 13', tmdbId: 568, released: '1995-06-30', imdbRating: 7.6, genres: ['Drama', 'Adventure', 'IMAX']})
MERGE (:Person {name: 'Tom Hanks', tmdbId: 31, born: '1956-07-09'})
MERGE (:Person {name: 'Meg Ryan', tmdbId: 5344, born: '1961-11-19'})
MERGE (:Person {name: 'Danny DeVito', tmdbId: 518, born: '1944-11-17'})
MERGE (:Person {name: 'Jack Nicholson', tmdbId: 514, born: '1937-04-22'})
MERGE (:Movie {title: 'Sleepless in Seattle', tmdbId: 858, released: '1993-06-25', imdbRating: 6.8, genres: ['Comedy', 'Drama', 'Romance']})
MERGE (:Movie {title: 'Hofa', tmdbId: 10410, released: '1992-12-25', imdbRating: 6.6, genres: ['Crime', 'Drama']})

// move property to a new node
MATCH (m:Movie)
UNWIND m.languages AS language
WITH  language, collect(m) AS movies
MERGE (l:Language {name:language})
WITH l, movies
UNWIND movies AS m
WITH l,m
MERGE (m)-[:IN_LANGUAGE]->(l);
MATCH (m:Movie)
SET m.languages = null


// :param userId => "fd9c8926-b8a1-4b23-bd89-c0d2106d8652";
// :param status => "active";

:params {
    userId: "fd9c8926-b8a1-4b23-bd89-c0d2106d8652",
    status: "active"
};
MATCH (u:User {id: $userId})-[:PURCHASED]->(s)-[:FOR_PLAN]->(p)
            WHERE s.expiresAt >= datetime() AND s.status = $status

            OPTIONAL MATCH  (p)-[:PROVIDES_ACCESS_TO]->(g)<-[:IN_GENRE]-(m)
            WHERE exists(m.poster)

            WITH p, g, m ORDER BY g.name, m.releaseDate DESC

            WITH p, g, collect(m) AS movies
            WITH p, g, movies[0] as topMovie

            RETURN p, collect(g {
                .id,
                .name,
                totalMovies: size((g)<-[:IN_GENRE]-()),
                poster: topMovie.poster
            }) AS genres

// changing exists, since it is deprecated
:params {
    userId: "fd9c8926-b8a1-4b23-bd89-c0d2106d8652",
    status: "active"
};
MATCH (u:User {id: $userId})-[:PURCHASED]->(s)-[:FOR_PLAN]->(p)
            WHERE s.expiresAt >= datetime() AND s.status = $status
            OPTIONAL MATCH (p)-[:PROVIDES_ACCESS_TO]->(g)<-[:IN_GENRE]-(m)
            WHERE m.poster IS NOT NULL
            WITH p, g, m ORDER BY g.name, m.releaseDate DESC
            WITH p, g, collect(m) AS movies
            WITH p, g, movies[0] as topMovie
            RETURN p, collect(g {
                .id,
                .name,
                totalMovies: size((g)<-[:IN_GENRE]-()),
                poster: topMovie.poster
            }) AS genres

// ok!!
MATCH (u:User)-[:PURCHASED]->(s)-[:FOR_PLAN]->(p)-[:PROVIDES_ACCESS_TO]->(g:Genre)<-[:IN_GENRE]-(m:Movie)
WHERE u.id = "fd9c8926-b8a1-4b23-bd89-c0d2106d8652" AND s.expiresAt >= datetime() AND s.status = "active"
RETURN p, g, m;

// ok!
MATCH (u:User {id: "fd9c8926-b8a1-4b23-bd89-c0d2106d8652"})-[:PURCHASED]->(s)-[:FOR_PLAN]->(p)-[:PROVIDES_ACCESS_TO]-(g)
WHERE s.expiresAt >= datetime() AND s.status = "active"
RETURN u, s, p, g

// ok
MATCH (u:User {id: "fd9c8926-b8a1-4b23-bd89-c0d2106d8652"})-[:PURCHASED]->(s)-[:FOR_PLAN]->(p)-[:PROVIDES_ACCESS_TO]->(g)<-[:IN_GENRE]-(m)
WHERE s.expiresAt >= datetime() AND s.status = "active"
RETURN u, s, p, g

// ok
MATCH (m:Movie)-[:IN_GENRE]->(g:Genre)<-[:PROVIDES_ACCESS_TO]-(p:Plan)
RETURN *

// no params ok, why null genres?!
MATCH (u:User {id: "fd9c8926-b8a1-4b23-bd89-c0d2106d8652"})-[:PURCHASED]->(s)-[:FOR_PLAN]->(p)
            WHERE s.expiresAt >= datetime() AND s.status = "active"
            OPTIONAL MATCH (p)-[:PROVIDES_ACCESS_TO]->(g)<-[:IN_GENRE]-(m)
            WHERE m.poster IS NOT NULL
            WITH p, g, m ORDER BY g.name, m.releaseDate DESC
            WITH p, g, collect(m) AS movies
            WITH p, g, movies[0] as topMovie
            RETURN p, collect(g {
                .id,
                .name,
                totalMovies: size((g)<-[:IN_GENRE]-()),
                poster: topMovie.poster
            }) AS genres

// ╒═══════════════════════════════════════════════════════╤════════╕
// │"p"                                                    │"genres"│
// ╞═══════════════════════════════════════════════════════╪════════╡
// │{"duration":P1M,"price":0.0,"name":"Free Trial","id":0}│[]      │
// └───────────────────────────────────────────────────────┴────────┘

// ok running fine now!
MATCH (u:User {id: "c85e6097-85e9-4930-b13f-70bb26c2ec6e"})-[:PURCHASED]->(s)-[:FOR_PLAN]->(p)
            WHERE s.expiresAt >= datetime() AND s.status = "active"
            OPTIONAL MATCH (p)-[:PROVIDES_ACCESS_TO]->(g)
            OPTIONAL MATCH (g)<-[:IN_GENRE]-(m)
            WHERE m.poster IS NOT NULL
            WITH p, g, m ORDER BY g.name, m.releaseDate DESC
            WITH p, g, collect(m) AS movies
            WITH p, g, movies[0] as topMovie
            RETURN p, collect(g {
                .id,
                .name,
                totalMovies: size((g)<-[:IN_GENRE]-()),
                poster: topMovie.poster
            }) AS genres