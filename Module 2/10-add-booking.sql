DELIMITER //

CREATE PROCEDURE AddBooking(
    IN bookingID INT,
    IN customerID INT,
    IN bookingDate DATE,
    IN tableNumber INT
)
BEGIN
    -- Insert a new record into the Bookings table
    INSERT INTO Bookings (BookingID, CustomerID, BookingDate, TableNumber)
    VALUES (bookingID, customerID, bookingDate, tableNumber);
    
    -- Output the result
    SELECT 'Booking successfully added' AS Status;
END //

DELIMITER ;


-- CALL AddBooking(5, 3, '2023-09-15', 4);
