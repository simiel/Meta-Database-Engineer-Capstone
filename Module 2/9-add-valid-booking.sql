DELIMITER //

CREATE PROCEDURE AddValidBooking(IN bookingDate DATE, IN tableNumber INT, IN customerID INT)
BEGIN
    DECLARE bookingCount INT;

    START TRANSACTION;

    -- Check if the table is already booked on the specified date
    SELECT COUNT(*) INTO bookingCount
    FROM Bookings
    WHERE BookingDate = bookingDate
      AND TableNumber = tableNumber;

    IF bookingCount > 0 THEN
        -- Rollback transaction if table is already booked
        ROLLBACK;
        SELECT 'Table is already booked, booking cancelled' AS Status;
    ELSE
        -- Insert new booking record and commit transaction
        INSERT INTO Bookings (BookingDate, TableNumber, CustomerID)
        VALUES (bookingDate, tableNumber, customerID);
        COMMIT;
        SELECT 'Booking successfully added' AS Status;
    END IF;
END //

DELIMITER ;


-- CALL AddValidBooking('2022-10-14', 5, 2);
