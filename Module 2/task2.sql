-- Extract Information Using JOINs
SELECT 
    Customers.CustomerID,
    CONCAT(Customers.FirstName, ' ', Customers.LastName) AS FullName,
    Orders.OrderID,
    Orders.TotalCost AS Cost,
    Menu.ItemName AS MenuName,
    MenuItems.CourseName,
    MenuItems.StarterName
FROM 
    Customers
JOIN 
    Orders ON Customers.CustomerID = Orders.CustomerID
JOIN 
    OrderItems ON Orders.OrderID = OrderItems.OrderID
JOIN 
    Menu ON OrderItems.MenuItemID = Menu.MenuItemID
JOIN 
    MenuItems ON Menu.MenuItemID = MenuItems.MenuItemID
WHERE 
    Orders.TotalCost > 150
ORDER BY 
    Orders.TotalCost ASC;
