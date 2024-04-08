-- vendors_metrics table

/* A foreign_key is a constraint in one table that referes to the primary key of another table */ 

CREATE TABLE vendors_metrics
(
	id int auto_increment primary key,
    company_id varchar(5),
    month int,
    num_orders int,
    num_sales float,
    foreign key (company_id) references vendors(company_id)); -- the vendor table must exist before using company_id as foreign keys