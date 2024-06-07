COPY users
FROM '/Users/hosseinb/projects/database_universtiy_project/divar_users.csv'
DELIMITER ','
CSV HEADER;

COPY admins
FROM '/Users/hosseinb/projects/database_universtiy_project/divar_admins.csv'
DELIMITER ','
CSV HEADER;

COPY wallets
FROM '/Users/hosseinb/projects/database_universtiy_project/divar_wallets.csv'
DELIMITER ','
CSV HEADER;

COPY payments
FROM '/Users/hosseinb/projects/database_universtiy_project/divar_payments.csv'
DELIMITER ','
CSV HEADER;

COPY categories
FROM '/Users/hosseinb/projects/database_universtiy_project/divar_categories.csv'
DELIMITER ','
CSV HEADER;

COPY products
FROM '/Users/hosseinb/projects/database_universtiy_project/divar_products.csv'
DELIMITER ','
CSV HEADER;

COPY comments
FROM '/Users/hosseinb/projects/database_universtiy_project/divar_comments.csv'
DELIMITER ','
CSV HEADER;

COPY badges
FROM '/Users/hosseinb/projects/database_universtiy_project/divar_badges.csv'
DELIMITER ','
CSV HEADER;

COPY contains_badge
FROM '/Users/hosseinb/projects/database_universtiy_project/divar_contains_badge.csv'
DELIMITER ','
CSV HEADER;



