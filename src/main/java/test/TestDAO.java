package test;

import dal.ReviewDAO;
import dal.BookingDAO;
import model.Booking;

public class TestDAO {
    public static void main(String[] args) {
        BookingDAO bookingDAO = new BookingDAO();
        ReviewDAO reviewDAO = new ReviewDAO();
        System.out.println("All bookings: ");
        for (Booking b : bookingDAO.findAll()) {
            System.out.println("ID: " + b.getId() + ", User: " + b.getUser().getId() + 
                               ", Hotel: " + b.getRoom().getHotel().getId() + 
                               ", Status: " + b.getStatus());
            boolean hasC = reviewDAO.hasCompletedBooking(b.getUser().getId(), b.getRoom().getHotel().getId());
            System.out.println("  hasCompletedBooking: " + hasC);
        }
        System.exit(0);
    }
}
