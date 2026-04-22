PRAGMA foreign_keys = ON;
PRAGMA journal_mode = WAL;

CREATE TABLE uw_Voting_candidates(
    uw_id integer NOT NULL,
    uw_name text NOT NULL,
    uw_votes integer NOT NULL,
    CONSTRAINT uw_Voting_candidates_pkey PRIMARY KEY (uw_id));

