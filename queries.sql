select province, Count(id) as count
from users as u
group by city
having count >= 2;

drop view if exists LIST_OF_PRODUCTS;
create view LIST_OF_PRODUCTS as
    select p.title, p.city, p.province, c.name
    from products as p
    join categories c on p.category_id = c.id;
select *
from LIST_OF_PRODUCTS;

drop view if exists COMMENT_OF_PRODUCT;
create view COMMENT_OF_PRODUCT as
    select p.id, c.text
    from products as p
    join comments as c on p.id = c.product_id
    order by c.sent_at DESC;
select *
from COMMENT_OF_PRODUCT;


select c.name, count(p.id) as count
from products as p
join categories as c on p.category_id = c.id
group by c.id;


select b.name, Count(cb.product_id) as cnt, (COUNT(cb.product_id) * b.price) as salary
from contains_badge as cb
join badges b on cb.badge_id = b.id
group by b.id;

# child categories
select c1.name as child_cat, c2.name as parent_cat
from categories as c1
join categories as c2 on c1.parent_id = c2.id
where not c1.parent_id = c1.id;

# parent categories
select c1.name as "category name"
from categories as c1
join categories as c2 on c1.parent_id = c2.id
where c1.parent_id = c1.id;



-- find parents
WITH RECURSIVE CategoryPath AS (
    SELECT id, name, parent_id
    FROM categories
    WHERE id = (SELECT category_id FROM products WHERE id = 5)

    UNION ALL

    SELECT c.id, c.name, c.parent_id
    FROM categories c
    INNER JOIN CategoryPath cp ON cp.parent_id = c.id
    WHERE cp.parent_id IS NOT NULL
)
-- Query to select the category path
SELECT id, name
FROM CategoryPath;



-- run bfs to find level
WITH RECURSIVE CategoryTree AS (
    SELECT id, name, parent_id, 1 AS level
    FROM categories
    WHERE parent_id IS NULL

    UNION ALL

    SELECT c.id, c.name, c.parent_id, level + 1
    FROM categories c
    INNER JOIN CategoryTree ct ON ct.id = c.parent_id
)
SELECT id, name, parent_id, level
FROM CategoryTree
ORDER BY level, id;




WITH RECURSIVE CategoryTree AS (
    SELECT id, name, parent_id
    FROM categories
    WHERE name = 'Tech'

    UNION ALL

    SELECT c.id, c.name, c.parent_id
    FROM categories c
    INNER JOIN CategoryTree ct ON ct.id = c.parent_id
)
-- Query to select the names of categories in the subtree under the "Tech" category
SELECT p.title, c2.name
from products as p
join categories c2 on p.category_id = c2.id
where category_id in (
        select id
        from CategoryTree
    )

select title, first_name , last_name
from products
join users on products.user_id = users.id;

select title , first_name , last_name
from products , users
where user_id = users.id;

select title , user_id
from products
where user_id in (select id
                    from users
                    where users.id = products.user_id );

select first_name , last_name
from users
where users.id in (select user_id
                    from products
                    where category_id in (select id
                                            from categories
                                            where name = 'Airpods'));

select first_name, last_name
from users, products, categories
where users.id = products.user_id AND products.category_id = categories.id AND categories.name = 'Airpods';

select first_name , last_name
from users join  products
    on users.id = products.user_id
    join categories
        on products.category_id = categories.id
        where categories.name = 'Airpods';

select province, Count(id) as count
from users
group by city
having count >= 2;

delimiter $$

Create FUNCTION f(x int) RETURNS varchar(50) DETERMINISTIC
begin
 return(
 select province
    from users
    group by city
    having Count(id) >= x
    order by COUNT(id) desc limit 1
    );
End$$

delimiter;

select  f(2);

DELIMITER $$

CREATE PROCEDURE guc(IN min_count INT)
BEGIN
    SELECT city, COUNT(id) AS count
    FROM users
    GROUP BY city
    HAVING COUNT(id) >= min_count;
END $$

DELIMITER ;

CALL guc(2);

