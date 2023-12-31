create database test;
use test;

create table categories (
	id int primary key auto_increment,
    name varchar(100) unique check(name not like ' ' ) ,
    status tinyint default 0 
);

create table products(
id int PRIMARY KEY AUTO_INCREMENT,
name varchar(200)  check(name not like ''),
price float check(price not like ''),
image varchar(200),
category_id int ,
foreign key (category_id) references categories(id)
);

create table customers (
id int PRIMARY KEY AUTO_INCREMENT,
name varchar(100) check(name not like ''),
email varchar(100) unique check(email not like '') ,
image varchar(200) ,
birthday date ,
gender tinyint 
);

create table orders (
id int PRIMARY KEY AUTO_INCREMENT,
customer_id int ,
foreign key(customer_id) references customers(id),
created timestamp default now(),
status tinyint default 0
);

create table order_details (
order_id int ,
foreign key (order_id) references orders(id),
product_id int ,
foreign key (product_id) references products(id),
quantity int check(quantity not like ''),
price float check(price not like '') 
);

insert into categories(name,status) values('Áo',1),('Quần',1),('Mũ',1),('Giày',1);

insert into products(name,category_id,price) values('Áo sơ mi',1,150000),('Áo khoác dạ',1,500000),('Quần KaKi',2,200000),('Giầy tây',4,1000000),('Mũ bảo hiểm A1',3,100000);

insert into customers(name,email,birthday,gender) values('Nguyễn Minh Khôi','khoi@gmail.com','2021-12-21',1),
('Nguyễn Khánh Linh','linh@gmail.com','2001-12-21',0),('Đỗ Khánh Linh','linh2@gmail.com','1999-01-01',0);

insert into orders (customer_id,created) values(1,'2023-11-08'),(2,'2023-11-09'),(1,'2023-11-09'),(3,'2023-11-09');

insert into order_details values(1,1,1,149000),(1,2,1,499000),(2,2,2,499000),(3,2,1,499000),(4,1,1,149000);

-- 1. Hiển thị danh sách danh mục gồm id,name,status (3đ).
select * from  categories;

-- 2. Hiển thị danh sách sản phẩm gồm id,name,price,sale_price,category_name(tên
-- danh mục) (7đ). 
select p.id,p.name,p.price, categories.name from products p join categories on p.category_id = categories.id; 

-- 3. Hiển thị danh sách sản phẩm có giá lớn hơn 200000 (5đ).
select * from products where price >200000;

-- 4. Hiển thị 3 sản phẩm có giá cao nhất (5đ).
select * from products order by price desc limit 3;

-- 5. Hiển thị danh sách đơn hàng gồm id,customer_name,created,status.(5đ)
select o.id,o.customer_id as cusid,o.created,o.status,c.name as customer_name from orders o join customers c on o.customer_id = c.id;

-- 6. Cập nhật trạng thái đơn hàng có id là 1(5đ)
update orders set status = 1 where id =1; 

-- 7. Hiển thị chi tiết đơn hàng của đơn hàng có id là 1, bao gồm
-- order_id,product_name,quantity,price,total_money là giá trị của (price * quantity)
-- (10đ)
select od.order_id,od.quantity,od.price ,(od.price*od.quantity) as total_money ,p.name from order_details od join products p on od.product_id = p.id where od.order_id=1; 

-- 8. Danh sách danh mục gồm, id,name, quantity_product(đếm trong bảng product) (20đ) 
select c.id,c.name,c.status ,count(p.id) as quantity_product  from categories c join products p on c.id = p.category_id group by c.id;
