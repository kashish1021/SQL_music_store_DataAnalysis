-- SQL PROJECT
-- Q1) WHO IS THE SENIOR MOST EMPLOYEE BASED ON JOB TITLE

select * from employee
order by levels desc
limit 1
 
-- Q2) WHICH COUNTRY HAS THE MOST INVOICES.

select count(*) as c , billing_country
from invoice
group by billing_country
order by c desc
-- Q3) WHAT ARE TOP 3 VALUES OF TOTAL INVOICES

select total  from invoice
order by total desc
limit 3

/*Q4) which city has the best customers?we would like to throw
the music festival in the city we made most money.write a query
that returns one city that has the highest sum of invoice total
return both the city name &sum of all total invoice */

select sum (total) as invoice_total , billing_city
from invoice
group by billing_city 
order by invoice_total desc
limit 2

-- prague have the best customers
/*Q5) WHOS IS THE  EST CUSTOMER? THE CUSTOMER WHO HAVE SPEND THE MOST MONEY
WILL BE BEST.WRITE A QUERY.8*/

select sum(total) as money_paid, customer_id
from invoice
group by customer_id
order by money_paid desc
limit 10

select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total
from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc
limit 1
-- best customer is R Madhav

/*Q6) return the email,first name,last name & genre of all rock music listeners
return list in alphabetical order by email stating with A.*/

select  distinct email,first_name, last_name
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
select track_id from track
	join genre on track.genre_id= genre.genre_id
	where genre.name like 'Rock'
)
order by email;

/*Q7)LETS INVITE THE ARTISTS WHO HAVE WRITTEN THE MOST ROCK MUSIC
IN OUR DATASET.WRITE A QUERY THAT RETURNS THE ARTIST NAME AND TOTAL
TRACK COUNT OF THE TOP 10 ROCK BANDS*/
select *from artist
select *from genre

select artist.artist_id, artist.name, count(artist.artist_id) as no_of_songs
from artist
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
group by artist.artist_id
order by no_of_songs desc
limit 10;

/*Q8) RETURN ALL THE TRACK NAMES THAT HAVE A SONG LENGTH LONGER THAN THE AVERAGE SONG LENGTH.RETUN THE NAME AND THE 
MILLISECONDS FOR EACH TRACK. ORDER BY THE SONG LENGTH .*/


select name, milliseconds
from track
where milliseconds > (select avg(milliseconds) as average_length from track)
order by milliseconds desc

