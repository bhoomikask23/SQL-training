create table customer11(
c_id int AUTO_INCREMENT primary key,
f_name varchar(30) not null,
l_name varchar(30) not null,
phone varchar(10) not null,
email varchar(255) not null,
address varchar(255) not null);

create table flight11(
f_id int primary key,
start varchar(255) not null,
dest varchar(255) not null,
departure date not null,
price int not null,
no_of_seats int not null);

create table booking(
t_id int AUTO_INCREMENT primary key,
f_id int not null,
c_id int not null,
foreign key(f_id) references flight11(f_id),
foreign key(c_id) references customer11(c_id));

insert into customer11 values
(NULL, 'bhoomi', 's', '9686433781', 'bhoomi@gmail.com', 'Bengaluru'),
(NULL, 'bhanu', 'V', '8966780987', 'bhanu@gmail.com', 'Bengaluru'),
(NULL, 'anusha', 'S', '88784268', 'anu@gmail.com', 'mumbai'),
(NULL, 'monika', 'S', '9999009987', 'monika@gmail.com', 'Mysore');

insert into flight11 values
(101, 'Bengaluru', 'Rajasthan', '2022-09-06', 10000, 100),
(103, 'Mysore', 'Bengaluru', '2022-09-08', 15000, 150),
(105, 'mumbai', 'Mysore', '2022-09-11', 20000, 200),
(106, 'Bengaluru', 'Mysore', '2022-09-12', 10000, 130);

insert into booking values
(NULL,101,1),
(NULL,105,1),
(NULL,103,4),
(NULL,106,4);

alter table booking rename column f_id to F_id;
+------+------+------+
| t_id | F_id | c_id |
+------+------+------+
|    1 |  101 |    1 |
|    2 |  105 |    1 |
|    3 |  103 |    4 |
|    4 |  106 |    4 |
+------+------+------+

 IT shows the customer11 details -
select c.c_id, c.f_name,c.l_name, f.f_id, f.dest, f.start, f.price, f.departure
from customer11 c, flight11 f, booking b
where c.c_id = b.c_id AND f.f_id=b.F_id;
+------+--------+--------+------+-----------+-----------+-------+------------+
| c_id | f_name | l_name | f_id | dest      | start     | price | departure  |
+------+--------+--------+------+-----------+-----------+-------+------------+
|    1 | bhoomi | s      |  101 | Rajasthan | Bengaluru | 10000 | 2022-09-06 |
|    1 | bhoomi | s      |  105 | Mysore    | mumbai    | 20000 | 2022-09-11 |
|    4 | monika | S      |  103 | Bengaluru | Mysore    | 15000 | 2022-09-08 |
|    4 | monika | S      |  106 | Mysore    | Bengaluru | 10000 | 2022-09-12 |
+------+--------+--------+------+-----------+-----------+-------+------------+



select f.f_id,count(b.F_id) from flight11 f, booking b where f.f_id=b.F_id group by b.F_id;
+------+---------------+
| f_id | count(b.F_id) |
+------+---------------+
|  101 |             1 |
|  103 |             1 |
|  105 |             1 |
|  106 |             1 |
+------+---------------+


select f.f_id, f.price * count(b.F_id) as revenue
from flight11 f, booking b
where f.f_id = b.F_id
GROUP BY b.F_id;
+------+---------+
| f_id | revenue |
+------+---------+
|  101 |   10000 |
|  103 |   15000 |
|  105 |   20000 |
|  106 |   10000 |
+------+---------+
