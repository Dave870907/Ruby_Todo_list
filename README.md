# Ruby Todo list

## Table Schema

User Table:

PK  user_id int NOT NULL

    user_name char(50) NOT NULL
    
Task Table:

PK  task_id int NOT NULL

FK  user_id iny NOT NULL
    
    start_time datetime NOT NULL
    
    end_time datetime NOT NULL
    
    status char(10) NOT NULL
    
    title char(50) NOT NULL
    
    content text
    
    order char(10)
    
    category char(15)
