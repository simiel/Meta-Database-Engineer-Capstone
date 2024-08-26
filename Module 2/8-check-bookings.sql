DELIMITER //

CREATE PROCEDURE CheckBooking(IN bookingDate DATE, IN tableNumber INT)
BEGIN
    DECLARE bookingCount INT;

    -- Count the number of bookings for the specified table on the specified date
    SELECT COUNT(*) INTO bookingCount
    FROM Bookings
    WHERE BookingDate = bookingDate
      AND TableNumber = tableNumber;

    -- Output the result
    IF bookingCount > 0 THEN
        SELECT 'Table is already booked' AS BookingStatus;
    ELSE
        SELECT 'Table is available' AS BookingStatus;
    END IF;
END //

DELIMITER ;


-- CALL CheckBooking('2022-10-10', 5);
