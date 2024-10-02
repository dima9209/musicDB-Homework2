create table genres(
genre_id SERIAL primary key,
genre_name varchar(60) not null
);

create table artists(
artist_id SERIAL primary key,
name_artist varchar(60) not null
);

create table albums(
album_id SERIAL primary key,
name_albums varchar(60) not null,
release_year INTEGER,
constraint c1 CHECK(release_year between 1900 and 5999)
);

create table tracks(
track_id SERIAL primary key,
name_track varchar(60) not null,
duration TIME,
album_id INTEGER references albums(album_id) not null
);

create table collection(
collection_id SERIAL primary key,
name_collection varchar(60) not null,
year_collection INTEGER NULL,
constraint c2 CHECK(year_collection between 1900 and 5999)
);

CREATE TABLE generes_artists (
  genre_artist_id SERIAL PRIMARY KEY, 
  genre_id INT NOT NULL, 
  artist_id INT NOT NULL, 
  CONSTRAINT fk_genre FOREIGN KEY(genre_id) REFERENCES genres(genre_id) ON DELETE CASCADE, 
  CONSTRAINT fk_artist FOREIGN KEY(artist_id) REFERENCES artists(artist_id) ON DELETE CASCADE
);

CREATE TABLE albums_artists (
  albums_artist_id SERIAL PRIMARY KEY, 
  artist_id INT NOT NULL, 
  albums_id INT NOT NULL, 
  CONSTRAINT fk_albums FOREIGN KEY(albums_id) REFERENCES albums(album_id) ON DELETE CASCADE, 
  CONSTRAINT fk_artist FOREIGN KEY(artist_id) REFERENCES artists(artist_id) ON DELETE CASCADE
);

CREATE TABLE tracks_collection (
  tracks_collection_id SERIAL PRIMARY KEY, 
  track_id INT NOT NULL, 
  collection_id INT NOT NULL, 
  CONSTRAINT fk_track FOREIGN KEY(track_id) REFERENCES tracks(track_id) ON DELETE CASCADE, 
  CONSTRAINT fk_collection FOREIGN KEY(collection_id) REFERENCES collection(collection_id) ON DELETE CASCADE
);



