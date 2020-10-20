-- How do websites store information
    -- Persisting information
    -- Databases

-- For our purposes, there are two parts to storing and accessing data:
    -- DataBase Management System
        -- An application that stores dta at scale and can be queried for data
    -- The Querying Language
        -- The language we use to interact with the database managemtne systems

-- Relational DataBase Management System
    -- An application that stores data at scale and organizes the data in tables
    -- We will be using:
        -- PostgreSQL (We will be using this for the next two days, and for most projects)
        -- SQLite (Thursday's project uses this)

-- SQL
    -- The way we communicate with our database
    -- Structured Query Language

    -- It's a domanin-specific language for relational databases
    -- Other DSLs: HTML, RSpec

-- Column Types
    -- Every column must have a data type specified. Some common types:
        -- varchar
        -- boolean
        -- integer
        -- float
        -- date
        -- many, many more

-- Modeling Relationships
    -- ONe-to-many
        -- If I am a user, I can post many posts/updates. However each one of those posts only belongs to me
        -- User is associated with many posts. Posts belong to one user
    -- Many-to-many
        -- User can have many friends, each friend can have many friends
    -- Foreign keys
        -- Optional column that references the primary key of another table
    -- Primary keys
        -- Every table has this

-- PostgreSQL Shell Commands
    -- psql
    -- CREATE DATABASE lecture;
    -- cat demo/setup_lecture_demo.sql | psql lecture
    -- psql lecture
    -- \d (list tables)
    -- \d table (show schema for table)
    -- \?
    -- end with ";"

-- The basics of SQL
    -- SELECT: choose which columns to extract data from
        -- * (give me everything)
    -- FROM: specifies the relation you're getting data from
    -- Where/Where not: filters the data according to a logical expression
        -- =, >=, <=, >, <, <>, !=
        -- IN, BETWEEN, LIKE, (%)
        -- AND, OR

-- Common SQL Filters and Commands
    -- ORDER BY: Sorts results based on a specific column
        -- ASC or DESC
        -- ASC is default
    -- LIMIT: how many rows you want in the result
    -- OFFSET: how many rows you want to skip from the top
    -- DISTINCT: De-duplicates data in a result (like Array#uniq)
        -- SELECT DISTINCT name, type
        -- SELECT COUNT (DISTINCT name)

-- NULL
    -- Comparisons to NULL don't work in SQL
    -- NULL represents an unknown value
        -- NULL is not a value, it is a non-value
    -- Use IS NULL and IS NOT NULL to check for null values

-- Using Aggregate Functions
    -- Aggregate functions combine data from a column into a single value
    -- You should always use an alias with aggregate functions to make for clearer results
    -- count, sum, avg, min/max, and more

-- What if I want subset
    -- GROUP BY
        -- collapses each group of rows into a single row
        -- any column we SELECT must be in our GROUP BY *******
        -- Aggregate functions in SELECT will apply to the individual groups, not the groups as a whole
        -- Example
            SELECT
                type, COUNT(*) AS num_items
            FROM
                possessions
            GROUP BY
                type;
    -- HAVING
        SELECT
            type, COUNT(*) AS num_items
        FROM
            possessions
        GROUP BY
            type
        HAVING
            COUNT(*) > 5;

    -- WHERE vs HAVING
        -- WHERE gets evaluated before GROUP BY
        -- HAVING gets evaluated after GROUP BY
        -- Aggregate functions are not alowed in WHERE. You must use aggregate functions in HAVING

    -- ORDER of OPERATION EXECUTION IN SQL
        -- FROM
        -- JOIN
        -- WHERE
        -- GROUP BY
        -- HAVING
        -- SELECT
        -- ORDER BY
        -- LIMIT/OFFSET
    
    -- Can I use the result of a query in a different query?
        -- What is the most common possession and which ones cost more than $1000
        -- Most commonly used in the WHERE clause:
            -- WHERE IN subquery
            -- WHERE NOT IN subquery
        -- When to use a subquery:
            -- You will want to use a subquery if your query follows the logic of "Get me this data A, as long as it is in this dataset B"
    -- Subqueries
        -- Can also be used in the FROM statement
        -- However, you must alias the subquery
        -- You have to name your subquery so you will be able to add further constrains on the results, otherwise your db will not know how to refer to the subquery

    -- JOINS
        -- Combine data from multiple tables into one relations using a JOIN
        -- Types of relationships
            -- One-to-many
            -- Many-to-many
        -- INNER JOIN
            -- returns only rows from table1 and table2 that match each other. This is the default
        -- LEFT OUTER JOIN (LEFT JOIN)
            -- returns all rows in table1, whether or not they match table2. Not supported by all engines
        -- FULL OUTER JOIN
            -- returns all rows in table1 and table2, whether or not their data matches up

    -- When do we join tables rather than using a subquery?
        -- when you have lots of data across many tables
        -- subqueries use less memory than joins
        -- subqueries use more CPU than joins (CPU is usually the bottleneck)
        -- In practice, this can differ between SQL engines

    -- Self-JOIN
        -- Joins a table back against self