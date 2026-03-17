package dal;

import jakarta.persistence.EntityManager;
import java.util.List;
import model.Hotel;
import model.Review;
import utils.JPAUtil;

public class ReviewDAO {

    public void addReview(Review review) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(review);

            // Recalculate and update hotel average rating
            Double avg = em.createQuery(
                    "SELECT AVG(CAST(r.rating AS double)) FROM Review r WHERE r.hotel.id = :hid",
                    Double.class)
                    .setParameter("hid", review.getHotel().getId())
                    .getSingleResult();

            if (avg != null) {
                Hotel hotel = em.find(Hotel.class, review.getHotel().getId());
                if (hotel != null) {
                    hotel.setRating(Math.round(avg * 10.0) / 10.0);
                    em.merge(hotel);
                }
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<Review> getByHotel(int hotelId) {
        EntityManager em = JPAUtil.getEntityManager();
        List<Review> list = em.createQuery(
                "SELECT r FROM Review r JOIN FETCH r.user WHERE r.hotel.id = :hid ORDER BY r.createdAt DESC",
                Review.class)
                .setParameter("hid", hotelId)
                .getResultList();
        em.close();
        return list;
    }

    /** Kiểm tra user đã đánh giá khách sạn này chưa */
    public boolean hasReviewed(int userId, int hotelId) {
        EntityManager em = JPAUtil.getEntityManager();
        long count = em.createQuery(
                "SELECT COUNT(r) FROM Review r WHERE r.user.id = :uid AND r.hotel.id = :hid",
                Long.class)
                .setParameter("uid", userId)
                .setParameter("hid", hotelId)
                .getSingleResult();
        em.close();
        return count > 0;
    }

    /** Kiểm tra user có booking COMPLETED ở khách sạn này không */
    public boolean hasCompletedBooking(int userId, int hotelId) {
        EntityManager em = JPAUtil.getEntityManager();
        long count = em.createQuery(
                "SELECT COUNT(b) FROM Booking b "
                + "WHERE b.user.id = :uid "
                + "AND b.room.hotel.id = :hid "
                + "AND b.status = :status",
                Long.class)
                .setParameter("uid", userId)
                .setParameter("hid", hotelId)
                .setParameter("status", model.BookingStatus.COMPLETED)
                .getSingleResult();
        em.close();
        return count > 0;
    }

    public double getAverageRating(int hotelId) {
        EntityManager em = JPAUtil.getEntityManager();
        Double avg = em.createQuery(
                "SELECT AVG(CAST(r.rating AS double)) FROM Review r WHERE r.hotel.id = :hid",
                Double.class)
                .setParameter("hid", hotelId)
                .getSingleResult();
        em.close();
        return avg == null ? 0.0 : avg;
    }

    public long countByHotel(int hotelId) {
        EntityManager em = JPAUtil.getEntityManager();
        long count = em.createQuery(
                "SELECT COUNT(r) FROM Review r WHERE r.hotel.id = :hid", Long.class)
                .setParameter("hid", hotelId)
                .getSingleResult();
        em.close();
        return count;
    }
}
