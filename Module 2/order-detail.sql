PREPARE GetOrderDetail FROM 
    'SELECT OrderID, Quantity, TotalCost 
     FROM Orders 
     WHERE CustomerID = ?';

SET @id = 1;  -- Example value for CustomerID

EXECUTE GetOrderDetail USING @id;

DEALLOCATE PREPARE GetOrderDetail;
