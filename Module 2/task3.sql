-- Subquery to Find Menu Items Ordered More Than Twice
SELECT Menu.ItemName
FROM Menu
WHERE Menu.MenuItemID IN (
    SELECT OrderItems.MenuItemID
    FROM OrderItems
    JOIN Orders ON OrderItems.OrderID = Orders.OrderID
    WHERE Orders.Quantity > 2
);
