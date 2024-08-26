DELIMITER //

CREATE PROCEDURE UpdateBooking(
    IN bookingID INT,
    IN newBookingDate DATE
)
BEGIN
    -- Update the BookingDate for the specified BookingID
    UPDATE Bookings
    SET BookingDate = newBookingDate
    WHERE BookingID = bookingID;
    
    -- Output the result
    SELECT 'Booking successfully updated' AS Status;
END //

DELIMITER ;


-- CALL UpdateBooking(3, '2023-10-01');
