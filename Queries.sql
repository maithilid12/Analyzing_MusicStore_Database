/* Query 1:  Which countries have the most Invoices? or
Which countries generate more money */
SELECT I.BillingCountry, COUNT(I.InvoiceId) AS num_invoice
FROM Invoice I
GROUP BY 1
ORDER BY 2 DESC;

/* Query 2: We would like to throw a promotional Music Festival in the city
we made the most money. Writing a query that returns the 1 city that has the
highest sum of invoice totals. Returning both the city name and the sum
of all invoice totals. */
SELECT I.BillingCity, SUM(I.Total) AS Invoice_Total
FROM Invoice I
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
/* Result: The top city for Invoice dollars was Prague with an amount of 90.24. */

/* Query 3: Who is the best customer? The customer who has spent the most money
 will be declared the best customer. Building a query that returns the person
who has spent the most money. */
SELECT C.CustomerId, SUM(I.Total) AS Invoice_Total
FROM Invoice I
JOIN Customer C
ON I.CustomerId = C.CustomerId
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;
/* Result: The customer who spent the most according to invoices was
Customer 6 with 49.62 in purchases */

/* Query 4: Return the email, first name, last name, and Genre of all Rock Music
listeners. Return your list ordered alphabetically by email address
starting with A. */
SELECT C.Email, C.FirstName, C.LastName
FROM Customer C
JOIN Invoice I
ON C.CustomerId = I.CustomerId
JOIN InvoiceLine Il
ON I.InvoiceId = Il.InvoiceId
JOIN Track T
ON Il.TrackId = T.TrackId
JOIN Genre G
ON T.GenreId = G.GenreId
WHERE G.Name = "Rock"
GROUP BY 1
ORDER BY 1;

/* Query 5: Who is writing the rock music?
Now that we know that our customers love rock music, we can decide which
musicians to invite to play at the concert. Let's invite the artists who have
written the most rock music in our dataset. Writing a query that returns the
Artist name and total track count of the top 10 rock bands. */

SELECT A.ArtistId, A.Name, COUNT(T.TrackId) AS Songs
FROM Artist A
JOIN Album Al
On A.ArtistId = Al.ArtistId
JOIN Track T
ON Al.AlbumId = T.AlbumId
JOIN Genre G
ON T.GenreId = G.GenreId
WHERE G.Name = "Rock"
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10;

/*Query 6: Which Genre requires more Bytes*/

SELECT G.Name, sum(T.Bytes) Total_Bytes
FROM Genre G
JOIN Track T
ON G.GenreId=T.GenreId
Group By G.Name
Order by sum(T.Bytes) DESC;

/*Query 7: Which are the Top 10 Highest Earning Artists*/

SELECT A.Name, sum(I.UnitPrice) money
FROM Artist A
JOIN Album Al
On A.ArtistId=Al.ArtistId
JOIN Track T
on Al.AlbumId=T.AlbumId
Join InvoiceLine I
On T.TrackId=I.TrackId
group by A.ArtistId
order by sum(I.UnitPrice) DESC
LIMIT 10;

/*Query 8: Which Customers spend the most on the Top Artist*/

SELECT sum(L.UnitPrice) Artist_Money, C.CustomerId, C.FirstName
from Artist A
join Album Al
on A.ArtistId=Al.ArtistId
join Track T
on Al.AlbumId=T.AlbumId
join InvoiceLine L
on T.TrackId=L.TrackId
join Invoice I
on L.InvoiceId=I.InvoiceId
join Customer C
on C.CustomerId=I.CustomerId
where A.Name='Iron Maiden'
group by A.Name, C.CustomerId
order by sum(L.UnitPrice) DESC;
