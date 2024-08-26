DELIMITER //

CREATE PROCEDURE CancelBooking(
    IN bookingID INT
)
BEGIN
    -- Delete the booking record with the specified BookingID
    DELETE FROM Bookings
    WHERE BookingID = bookingID;
    
    -- Output the result
    SELECT 'Booking successfully canceled' AS Status;
END //

DELIMITER ;


-- CALL CancelBooking(2);
