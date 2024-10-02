-- Название и продолжительность самого длинного трека
select t.name_track , t.duration 
from tracks t 
order by 2 desc 
limit 1;

--- Название треков, продолжительность которых не менее 3,5 минут
select t.name_track 
from tracks t 
where t.duration >='00:03:30';

---Названия сборников, вышедших в период с 2018 по 2020 год включительно

select c.name_collection
from collection c 
where c.year_collection between 2018 and 2020;

---Исполнители, чьё имя состоит из одного слова
select name_artist from artists a where name_artist not like '% %'

--Название треков, которые содержат слово «мой» или «my»
select t.name_track 
from tracks t where lower(t.name_track) like '%my %';

--- Количество исполнителей в каждом жанре

select g.genre_name , count(distinct ga.artist_id) counter
from genres as g
join generes_artists as ga on g.genre_id = ga.genre_id 
group by g.genre_name 
order by 2 desc;

--Количество треков, вошедших в альбомы 2019–2020 годов.
select count(t.track_id)
from albums a 
join tracks t on a.album_id = t.album_id 
where a.release_year  between 2019 and 2020;

---Средняя продолжительность треков по каждому альбому
select a.name_albums, avg(t.duration) as avg_duration
from albums a 
join tracks t  on t.album_id =a.album_id
group by a.name_albums ;

--Все исполнители, которые не выпустили альбомы в 2020 году.
select distinct a.artist_id, a.name_artist 
from artists a 
left join albums_artists aa  on a.artist_id = aa.artist_id
left join albums a2 on a2.album_id = aa.albums_id  and a2.release_year =2020
where a2.album_id is null;

--Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами).

select c.name_collection 
from collection c 
join tracks_collection tc on c.collection_id = tc.collection_id 
join tracks t on t.track_id = tc.track_id 
join albums a on a.album_id = t.album_id 
join albums_artists aa on aa.albums_id = a.album_id 
where aa.artist_id =9;


-- Названия альбомов, в которых присутствуют исполнители более чем одного жанра.

with artist_ganre as (
select artist_id, count(*)
from generes_artists 
group by artist_id
having count(*) > 1
)
select a.name_albums 
from albums a 
join albums_artists aa on aa.albums_id =a.album_id 
join artist_ganre ag on ag.artist_id= aa.artist_id;

---Наименования треков, которые не входят в сборники.

select t.name_track 
from tracks t 
left join tracks_collection tc on tc.track_id= t.track_id
where tc.tracks_collection_id is null;

---Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.

with smol_track as(
select t.duration
from tracks t
order by t.duration
limit 1
)
select a.name_artist 
from artists a 
join albums_artists aa on a.artist_id = aa.artist_id 
join albums a2 on a2.album_id = aa.albums_id 
join tracks t on t.album_id = a2.album_id 
where t.duration = (select * from smol_track)

---Названия альбомов, содержащих наименьшее количество треков.
select name_albums  FROM
(select a.name_albums , count(t.track_id) as counter, dense_rank() over(order by count(t.track_id)) rn
from albums a 
join tracks t on t.album_id = a.album_id
group by a.name_albums)
where rn =1
