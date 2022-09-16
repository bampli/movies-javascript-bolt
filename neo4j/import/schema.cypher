DROP CONSTRAINT cMovie IF EXISTS;
DROP CONSTRAINT cLanguage IF EXISTS;
DROP CONSTRAINT cCountry IF EXISTS;
DROP CONSTRAINT cGenre IF EXISTS;
DROP CONSTRAINT cProductionCompany IF EXISTS;
DROP CONSTRAINT cCollection IF EXISTS;
DROP CONSTRAINT cPerson IF EXISTS;
DROP CONSTRAINT cUserId IF EXISTS;
DROP CONSTRAINT cUserEmail IF EXISTS;
DROP CONSTRAINT cKeyword IF EXISTS;
DROP CONSTRAINT cPlan IF EXISTS;
DROP CONSTRAINT cSubscription IF EXISTS;

CREATE CONSTRAINT cMovie FOR (n:Movie) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT cLanguage FOR (n:Language) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT cCountry FOR (n:Country) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT cGenre FOR (n:Genre) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT cProductionCompany FOR (n:ProductionCompany) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT cCollection FOR (n:Collection) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT cPerson FOR (n:Person) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT cUserId FOR (n:User) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT cUserEmail FOR (n:User) REQUIRE n.email IS UNIQUE;
CREATE CONSTRAINT cKeyword FOR (n:Keyword) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT cPlan FOR (n:Plan) REQUIRE n.id IS UNIQUE;
CREATE CONSTRAINT cSubscription FOR (n:Subscription) REQUIRE n.id IS UNIQUE;
