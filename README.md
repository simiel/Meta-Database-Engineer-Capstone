# Little Lemon database capstone

This repository is the Meta Database Engineer capstone for the Little Lemon restaurant. It holds MySQL Workbench models, forward-engineered InnoDB scripts for the `Little_Lemon` schema, Module 2 SQL exercises, and a Module 3 Jupyter notebook that queries MySQL with `mysql-connector-python`. The commits are from 2024-08-26 and are labeled Module 1, Module 2, and Module 3.

## Key features

- A restaurant schema for customers, table bookings, orders, order lines, menu items, staff, and delivery status.
- Stored procedures that check whether a table is free, add a booking inside a transaction and roll it back when that table is already booked, and add, update, or cancel a booking.
- Procedures that cancel an order and return the maximum quantity on `Orders`.
- A view of orders with quantity greater than 2, a multi-table cost report, a subquery over menu items on large orders, and a prepared statement for order details.
- A Python notebook that installs the MySQL connector, opens a connection, runs `SHOW TABLES`, and defines a join of customers to orders with `TotalCost` above 60.

## Stack and frameworks

- **MySQL** with the **InnoDB** engine. Each schema script sets `SQL_MODE` to `ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION`.
- **MySQL Workbench**, via the `.mwb` models and the “MySQL Workbench Forward Engineering” headers on the schema scripts.
- **Python** in `Module 3/test.ipynb`, using `mysql.connector` from the `mysql-connector-python` package.

## Architecture

The schema scripts each create `Little_Lemon`. They are separate Workbench exports. `LittleLemon-Final.sql` and `LittleLemon.sql` landed in the “Module 1 complete” commit. `LittleLemonDB.sql` landed later, in “Module 1 update”.

`LittleLemon-Final.sql` defines these tables:

| Table | Contents |
| --- | --- |
| `Customers` | `CustomerID` primary key, `FirstName`, `LastName`, `ContactNumber`, `Email` |
| `Bookings` | `BookingID` primary key, `BookingDate`, `TableNumber`, foreign key `CustomerID` |
| `Orders` | `OrderID` primary key, `OrderDate`, `Quantity`, `TotalCost`, unique `BookingID` foreign key to `Bookings`, foreign keys `DeliveryStatusID` and `StaffID` |
| `Order Delivery Status` | `DeliveryStatusID` primary key, `DeliveryDate`, `Status`, `OrderID` (the column is not a foreign key) |
| `Staff` | `StaffID` primary key, `FirstName`, `LastName`, `Role`, `Salary` |
| `Menu` | `MenuItemID` primary key, `ItemName`, `Category`, `Price` |
| `OrderItems` | `OrderItemID` primary key, `Quantity`, foreign keys to `Orders` and `Menu` |

`LittleLemonDB.sql` (with `LittleLemonDB.mwb`) keeps that booking and order shape. Its `Menu` table uses `CourseName`, `StarterName`, and `DessertName`, and `DessertName` is declared as `INT`.

`LittleLemon.sql` (with `LittleLemon.mwb` and `Model.mwb`) is an earlier shape. `Bookings` has no `BookingID` primary key. `Bookings.Orders_OrderID` references `Orders.BookingID`, and in that script `BookingID` is an ordinary column on `Orders`. `Menu` matches `LittleLemon-Final.sql` (`ItemName`, `Category`, `Price`).

Workbench files are `LittleLemon.mwb`, `LittleLemon.mwb.bak`, `LittleLemonDB.mwb`, `Model.mwb`, and `Model.mwb.bak`. The three PNG files are MySQL Workbench diagram screenshots from the Module 1 commits.

Module 2 scripts expect `Bookings (BookingID, BookingDate, TableNumber, CustomerID)`, which is the shape in `LittleLemon-Final.sql` and `LittleLemonDB.sql`. Those scripts do not select a database.

| File | Contents |
| --- | --- |
| `Module 2/7-insert-data.sql` | Inserts four `Bookings` rows (ids 1–4, dates in October and November 2022, `CustomerID` 1, 3, 2, and 1) |
| `Module 2/8-check-bookings.sql` | `CheckBooking(bookingDate, tableNumber)` returns whether that table is booked |
| `Module 2/9-add-valid-booking.sql` | `AddValidBooking` starts a transaction, rolls back when the table is taken, and otherwise inserts the booking and commits |
| `Module 2/10-add-booking.sql` | `AddBooking(bookingID, customerID, bookingDate, tableNumber)` |
| `Module 2/11-update-booking.sql` | `UpdateBooking(bookingID, newBookingDate)` sets `BookingDate` |
| `Module 2/12-cancelbooking.sql` | `CancelBooking(bookingID)` deletes that row |
| `Module 2/cancel-order.sql` | `CancelOrder(orderID)` deletes from `Orders`, then calls `CancelOrder(1)` |
| `Module 2/max-quantity.sql` | `GetMaxQuantity()` returns `MAX(Quantity)` from `Orders`, then calls the procedure |
| `Module 2/order-detail.sql` | Prepared statement `GetOrderDetail` selects from `Orders` where `CustomerID` equals a placeholder, then executes it with `@id = 1` |
| `Module 2/task1.sql` | View `OrdersView` of `OrderID`, `Quantity`, and `TotalCost` where `Quantity > 2` |
| `Module 2/task2.sql` | Join of `Customers`, `Orders`, `OrderItems`, `Menu`, and `MenuItems` for `TotalCost > 150` |
| `Module 2/task3.sql` | Subquery returning `Menu.ItemName` for items on orders with `Quantity > 2` |

`Module 3/test.ipynb` is marked “Exercise 1”. It connects, runs `SHOW TABLES`, closes the cursor and the connection, then defines `join_query` and calls `cursor.execute` on that string.

## Getting started

This repository has no environment variables, dependency manifest, or application process. Credentials in the notebook are string literals.

The schema scripts create the database themselves with `CREATE SCHEMA IF NOT EXISTS Little_Lemon` and `USE Little_Lemon`. Load one export with the MySQL client:

```bash
mysql -u root -p < LittleLemon-Final.sql
```

`LittleLemonDB.sql` is the later Menu variant and loads the same way:

```bash
mysql -u root -p < LittleLemonDB.sql
```

Module 2 files do not issue `USE`. Pass the schema name on the client command:

```bash
mysql -u root -p Little_Lemon < "Module 2/7-insert-data.sql"
mysql -u root -p Little_Lemon < "Module 2/8-check-bookings.sql"
mysql -u root -p Little_Lemon < "Module 2/9-add-valid-booking.sql"
mysql -u root -p Little_Lemon < "Module 2/10-add-booking.sql"
mysql -u root -p Little_Lemon < "Module 2/11-update-booking.sql"
mysql -u root -p Little_Lemon < "Module 2/12-cancelbooking.sql"
```

Commented calls in those files are `CALL CheckBooking('2022-10-10', 5);`, `CALL AddValidBooking('2022-10-14', 5, 2);`, `CALL AddBooking(5, 3, '2023-09-15', 4);`, `CALL UpdateBooking(3, '2023-10-01');`, and `CALL CancelBooking(2);`.

`Module 2/cancel-order.sql`, `Module 2/max-quantity.sql`, and `Module 2/order-detail.sql` execute their statements when the file runs (`CALL CancelOrder(1);`, `Call GetMaxQuantity();`, and `EXECUTE GetOrderDetail USING @id;`).

The notebook installs the driver with this cell:

```text
%pip install mysql-connector-python
```

It then connects with these arguments:

```python
connection = connector.connect(
    user="root",
    password="your_password",
    host="localhost",
    port=3306,
    # database="LittleLemon"
)
```

`your_password` is the literal stored in `Module 3/test.ipynb`. The `database` argument is commented out. The schema scripts create `Little_Lemon`. The comment in the notebook spells that name `LittleLemon`.

## Status

The tree is the 2024-08-26 coursework snapshot: schema exports, SQL exercises, and one notebook. It includes no test suite and no seed data for `Customers`, `Orders`, `Menu`, `Staff`, or `Order Delivery Status`. `Module 2/7-insert-data.sql` inserts bookings for `CustomerID` 1, 2, and 3.

Some statements refer to objects the DDL does not create:

- `Orders` in every schema script has no `CustomerID` column. `Module 2/order-detail.sql`, `Module 2/task2.sql`, and the notebook join on `Orders.CustomerID`.
- No script creates `MenuItems`. `Module 2/task2.sql` joins that table for `CourseName` and `StarterName`.
- `Customers` stores `ContactNumber`. The notebook selects `c.PhoneNumber`.
- `AddValidBooking` inserts `BookingDate`, `TableNumber`, and `CustomerID` only. `BookingID` is `INT NOT NULL` and is not `AUTO_INCREMENT` in `LittleLemon-Final.sql` or `LittleLemonDB.sql`.
- In `LittleLemon.sql`, the bookings foreign key targets `Orders.BookingID`, which is not a primary or unique key in that script.
- In `LittleLemonDB.sql`, `Menu.DessertName` is an `INT`.
- After `SHOW TABLES`, the notebook closes the cursor and the connection. The later cell calls `cursor.execute(join_query)`.

## Coursework context

The Git remote is `simiel/Meta-Database-Engineer-Capstone`. Commit subjects record the course sequence: “Module 1 complete”, “Module 1 update”, “Module 2 excercise 1”, “Module 2 scripts”, “set up python client”, and “Query DB with python client”. Module 1 is the Workbench model and the schema scripts. Module 2 is the SQL under `Module 2/`. Module 3 is `Module 3/test.ipynb`.

## What this demonstrates

The project shows a Little Lemon booking and order model drawn in MySQL Workbench and exported as InnoDB DDL, with primary keys and foreign keys across customers, bookings, orders, staff, delivery status, menu items, and order lines. The Module 2 procedures show an availability check and a transaction that rolls back when a table is already booked, plus add, update, and cancel operations on `Bookings`. The view, join, subquery, and prepared statement show the reporting queries written for that domain. The notebook shows a Python client using `mysql-connector-python` to open a connection, list tables, and hold a customer-order join.
