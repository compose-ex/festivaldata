CREATE TABLE IF NOT EXISTS
artists (
  name TEXT PRIMARY KEY CHECK (length(name) < 256),
  mb_id UUID UNIQUE,
  date_formed DATE 
);

CREATE TABLE IF NOT EXISTS
users (
  email TEXT PRIMARY KEY CHECK ( email ~* '^.+@.+\..+$' ),
  pass TEXT NOT NULL CHECK (length(pass) < 256),
  role NAME NOT NULL CHECK (length(role) < 256)
);

CREATE TABLE IF NOT EXISTS
sort_types (
  name TEXT PRIMARY KEY CHECK (length(name) < 256),
  description TEXT NOT NULL CHECK (length(description) < 512)
);

CREATE TABLE IF NOT EXISTS
sorts (
  artist_name TEXT NOT NULL REFERENCES artists(name),
  sort_type_name TEXT NOT NULL REFERENCES sort_types(name),
  ordinal INTEGER NOT NULL
);

ALTER TABLE sorts ADD CONSTRAINT sorts_pkey
PRIMARY KEY(artist_name, sort_type_name);

CREATE TABLE IF NOT EXISTS
rating_types (
  name TEXT PRIMARY KEY CHECK (length(name) < 256),
  description TEXT NOT NULL CHECK (length(description) < 512)
);

CREATE TABLE IF NOT EXISTS
ratings (
  artist_name TEXT NOT NULL REFERENCES artists(name),
  email TEXT NOT NULL REFERENCES users(email),
  rating_type_name TEXT NOT NULL REFERENCES rating_types(name),
  rating INTEGER NOT NULL,
  at TIMESTAMP WITH TIME ZONE DEFAULT now()
);

ALTER TABLE ratings ADD CONSTRAINT ratings_pkey
PRIMARY KEY(artist_name, email, rating_type_name);

CREATE ROLE music_lover;

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE users TO music_lover;
GRANT SELECT ON TABLE artists TO music_lover;
GRANT SELECT ON TABLE sort_types TO music_lover;
GRANT SELECT ON TABLE sorts TO music_lover;
GRANT SELECT ON TABLE rating_types TO music_lover;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE ratings TO music_lover;

