create database virtualart;

use virtualart;

create table artists (
    artistid int primary key,
    name varchar(255) not null,
    biography text,
    nationality varchar(100)
);

create table categories (
    categoryid int primary key,
    name varchar(100) not null
);

create table artworks (
    artworkid int primary key,
    title varchar(255) not null,
    artistid int,
    categoryid int,
    year int,
    description text,
    imageurl varchar(255),
    foreign key (artistid) references artists (artistid),
    foreign key (categoryid) references categories (categoryid)
);

create table exhibitions (
    exhibitionid int primary key,
    title varchar(255) not null,
    startdate date,
    enddate date,
    description text
);

create table exhibitionartworks (
    exhibitionid int,
    artworkid int,
    primary key (exhibitionid, artworkid),
    foreign key (exhibitionid) references exhibitions (exhibitionid),
    foreign key (artworkid) references artworks (artworkid)
);


--DML Commands to insert data

INSERT INTO Artists (ArtistID, Name, Biography, Nationality) VALUES
(1, 'Pablo Picasso', 'Renowned Spanish painter and sculptor.', 'Spanish'),
(2, 'Vincent van Gogh', 'Dutch post-impressionist painter.', 'Dutch'),
(3, 'Leonardo da Vinci', 'Italian polymath of the Renaissance.', 'Italian');

INSERT INTO Categories (CategoryID, Name) VALUES
(1, 'Painting'),
(2, 'Sculpture'),
(3, 'Photography');

INSERT INTO Artworks (ArtworkID, Title, ArtistID, CategoryID, Year, Description, ImageURL) VALUES
(1, 'Starry Night', 2, 1, 1889, 'A famous painting by Vincent van Gogh.', 'starry_night.jpg'),
(2, 'Mona Lisa', 3, 1, 1503, 'The iconic portrait by Leonardo da Vinci.', 'mona_lisa.jpg'),
(3, 'Guernica', 1, 1, 1937, 'Pablo Picasso powerful anti-war mural.', 'guernica.jpg'),
(4, 'Star', 2, 1, 1876, 'A famous painting by Vincent van Gogh.', 'star.jpg'),
(5, 'alright Night', 2, 1, 1907, 'A famous painting by Vincent van Gogh.', 'alright_night.jpg'),
(6, 'St.', 3, 3, 1806, 'A famous painting ', 'hjk.jpg'),
(7, 'tar', 3, 2, 1986, 'A famous painting vinvi.', 'syj.jpg'),
(8, 'artwo', 3, 2, 1872, 'world famous', 'rty.jpg'),
(9, 'autr', 3, 2, 1900, 'no details', 'fgh.jpg');

INSERT INTO Exhibitions (ExhibitionID, Title, StartDate, EndDate, Description) VALUES
(1, 'Modern Art Masterpieces', '2023-01-01', '2023-03-01', 'A collection of modern art masterpieces.'),
(2, 'Renaissance Art', '2023-04-01', '2023-06-01', 'A showcase of Renaissance art treasures.');

INSERT INTO ExhibitionArtworks (ExhibitionID, ArtworkID) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 2);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--1. Retrieve the names of all artists along with the number of artworks they have in the gallery, and list them in descending order of the number of artworks.
select a.name , count(*) as totalartwork from artists a join artworks aw on
a.artistid=aw.artistid group by a.name order by count(*);


--2. List the titles of artworks created by artists from 'Spanish' and 'Dutch' nationalities, and order them by the year in ascending order.
select aw.title, aw.year from artworks aw join artists a
on a.artistid= aw.artistid where a.nationality in ('Spanish','Dutch') order by aw.year;


--3. Find the names of all artists who have artworks in the 'Painting' category, and the number of artworks they have in this category.
select a.name , count(*) as totalartworkinpaint from artists a join artworks aw on
a.artistid=aw.artistid join categories c on aw.categoryid=c.categoryid
where c.name='Painting' group by a.name;


--4. List the names of artworks from the 'Modern Art Masterpieces' exhibition, along with their artists and categories.
select aw.title , a.name, c.name as category from exhibitionartworks ea
join artworks aw on ea.artworkid = aw.artworkid join artists a on a.artistid = aw.artistid
join categories c on aw.categoryid = c.categoryid join exhibitions e on ea.exhibitionid = e.exhibitionid
where e.title = 'modern art masterpieces';


--5. Find the artists who have more than two artworks in the gallery.
select a.name , count(*) as totalartwork from artists a join artworks aw on
a.artistid=aw.artistid group by a.name having count(*)>2 order by count(*);


--6. Find the titles of artworks that were exhibited in both 'Modern Art Masterpieces' and 'Renaissance Art' exhibitions
select a.title as artwork, e.title as exhibition  from exhibitionartworks ea
join artworks a on ea.artworkid = a.artworkid join exhibitions e on ea.exhibitionid = e.exhibitionid
where e.title in ('Modern Art Masterpieces','Renaissance Art');


--7. Find the total number of artworks in each category
select c.name, count(*) totalartworks from artworks aw join categories c
on aw.categoryid=c.categoryid group by c.name;


--8. List artists who have more than 3 artworks in the gallery.
select a.name , count(*) as totalartwork from artists a join artworks aw on
a.artistid=aw.artistid group by a.name having count(*)>3 order by count(*);


--9. Find the artworks created by artists from a specific nationality (e.g., Spanish).
select aw.title, a.nationality from artworks aw left join artists a
on a.artistid= aw.artistid where a.nationality ='Spanish';


--10. List exhibitions that feature artwork by both Vincent van Gogh and Leonardo da Vinci.
select e.title as exhibition  from artists a join artworks aw 
on aw.artistid=a.artistid join exhibitionartworks ea on ea.artworkid = aw.artworkid join exhibitions e on ea.exhibitionid = e.exhibitionid
where a.name in ('Leonardo Da Vinci','Vincent Van Gogh') group by e.title having count(distinct a.name)>1;


--11. Find all the artworks that have not been included in any exhibition.
select aw.title from artworks aw where aw.artworkid not in (select artworkid from exhibitionartworks);


--12. List artists who have created artworks in all available categories.
select a.name from artists a join artworks aw on aw.artistid = a.artistid
join categories c on aw.categoryid = c.categoryid group by a.name
having count(distinct c.categoryid) = (select count(*) from categories);


--13. List the total number of artworks in each category.
select c.name, count(*) as totalartwork from artworks aw join categories c 
on aw.categoryid=c.categoryid group by c.name;


--14. Find the artists who have more than 2 artworks in the gallery.
select a.name , count(*) as totalartwork from artists a join artworks aw on
a.artistid=aw.artistid group by a.name having count(*)>2 order by count(*);


--15. List the categories with the average year of artworks they contain, only for categories with more than 1 artwork.
select c.name, avg(a.year) as averageyear from categories c 
join artworks a on c.categoryid = a.categoryid group by c.name having count(a.artworkid) > 1;


--16. Find the artworks that were exhibited in the 'Modern Art Masterpieces' exhibition.
select a.title as artwork, aw.name as artist from exhibitionartworks ea
join artworks a on ea.artworkid = a.artworkid join artists aw on a.artistid = aw.artistid
join exhibitions e on ea.exhibitionid = e.exhibitionid where e.title = 'modern art masterpieces';


--17. Find the categories where the average year of artworks is greater than the average year of all artworks.
select c.name, avg(a.year) as averageyear from categories c 
join artworks a on c.categoryid = a.categoryid group by c.name 
having avg(a.year) > (select avg(year) from artworks);


--18. List the artworks that were not exhibited in any exhibition.
select aw.title from artworks aw where aw.artworkid not in (select artworkid from exhibitionartworks);


--19. Show artists who have artworks in the same category as "Mona Lisa."
select a.name, aw.title, c.name from artists a join artworks aw on a.artistid=aw.artistid
join categories c on c.categoryid=aw.categoryid where 
aw.categoryid = (select categoryid from artworks where title = 'Mona Lisa');


--20. List the names of artists and the number of artworks they have in the gallery.
select a.name, count(*) as totalartworks from artists a join artworks aw on a.artistid=aw.artistid
group by a.name;
