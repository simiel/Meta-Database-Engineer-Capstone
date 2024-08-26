DELIMITER //

CREATE PROCEDURE CancelOrder(IN orderID INT)
BEGIN
    DELETE FROM Orders
    WHERE OrderID = orderID;
END //

DELIMITER ;



CALL CancelOrder(1);  -- Example order ID
