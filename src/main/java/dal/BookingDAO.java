/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import jakarta.persistence.EntityManager;
import java.util.List;
import model.Booking;
import model.BookingStatus;
import model.Room;
import utils.JPAUtil;

/**
 *
 * @author LE HOANG VIET
 */
public class BookingDAO {

    public List<Booking> findAll() {
        EntityManager em = JPAUtil.getEntityManager();
        return em.createQuery("SELECT b FROM Booking b", Booking.class)
                .getResultList();
    }

    public void updateStatus(int id, BookingStatus newStatus) {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            Booking booking = em.find(Booking.class, id);

            if (booking == null) {
                em.getTransaction().rollback();
                return;
            }

            Room room = booking.getRoom();
            BookingStatus currentStatus = booking.getStatus();

            // ===== CONFIRM =====
            if (newStatus == BookingStatus.CONFIRMED
                    && currentStatus == BookingStatus.PENDING) {

                if (room.getQuantity() <= 0) {
                    em.getTransaction().rollback();
                    return;
                }

                room.setQuantity(room.getQuantity() - 1);
                booking.setStatus(BookingStatus.CONFIRMED);
            } // ===== CANCEL =====
            else if (newStatus == BookingStatus.CANCELLED
                    && currentStatus == BookingStatus.CONFIRMED) {

                room.setQuantity(room.getQuantity() + 1);
                booking.setStatus(BookingStatus.CANCELLED);
            } // ===== COMPLETED =====
            else if (newStatus == BookingStatus.COMPLETED
                    && currentStatus == BookingStatus.CONFIRMED) {

                booking.setStatus(BookingStatus.COMPLETED);
            }

            em.merge(room);
            em.merge(booking);

            em.getTransaction().commit();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public void save(Booking booking) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();
        em.persist(booking);
        em.getTransaction().commit();
        em.close();
    }

    public List<Booking> findByUser(int userId) {
        EntityManager em = JPAUtil.getEntityManager();

        List<Booking> list = em.createQuery(
                "SELECT b FROM Booking b WHERE b.user.id = :uid AND b.status <> 'CANCELLED'",
                Booking.class)
                .setParameter("uid", userId)
                .getResultList();

        em.close();
        return list;
    }

    public void cancelBooking(int bookingId) {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            Booking booking = em.find(Booking.class, bookingId);

            if (booking != null && booking.getStatus() == BookingStatus.CONFIRMED||
                    booking.getStatus()==BookingStatus.PENDING) {

                Room room = booking.getRoom();
                room.setQuantity(room.getQuantity() + 1);

                booking.setStatus(BookingStatus.CANCELLED);

                em.merge(room);
                em.merge(booking);
            }

            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        } finally {
            em.close();
        }
    }

    // Manage
    public List<Booking> getAll() {
        EntityManager em = JPAUtil.getEntityManager();

        List<Booking> list = em.createQuery(
                "SELECT b FROM Booking b "
                + "JOIN FETCH b.user "
                + "JOIN FETCH b.room r "
                + "JOIN FETCH r.hotel "
                + "ORDER BY b.id DESC",
                Booking.class).getResultList();

        em.close();
        return list;
    }

    public List<Booking> getPaging(int page, int pageSize) {

        EntityManager em = JPAUtil.getEntityManager();

        List<Booking> list = em.createQuery(
                "SELECT b FROM Booking b ORDER BY b.id DESC",
                Booking.class)
                .setFirstResult((page - 1) * pageSize)
                .setMaxResults(pageSize)
                .getResultList();

        em.close();
        return list;
    }

    public List<Booking> filterByStatus(String status) {

        EntityManager em = JPAUtil.getEntityManager();

        List<Booking> list = em.createQuery(
                "SELECT b FROM Booking b WHERE b.status = :status",
                Booking.class)
                .setParameter("status", BookingStatus.valueOf(status))
                .getResultList();

        em.close();
        return list;
    }

    public List<Booking> search(String keyword) {

        EntityManager em = JPAUtil.getEntityManager();

        List<Booking> list = em.createQuery(
                "SELECT b FROM Booking b "
                + "JOIN b.user u "
                + "JOIN b.room r "
                + "JOIN r.hotel h "
                + "WHERE LOWER(u.fullName) LIKE LOWER(:kw) "
                + "OR LOWER(h.name) LIKE LOWER(:kw)",
                Booking.class)
                .setParameter("kw", "%" + keyword + "%")
                .getResultList();

        em.close();
        return list;
    }

    public long countBookings() {
        EntityManager em = JPAUtil.getEntityManager();
        long count = em.createQuery("SELECT COUNT(b) FROM Booking b", Long.class)
                .getSingleResult();
        em.close();
        return count;
    }

    public double totalRevenue() {
        EntityManager em = JPAUtil.getEntityManager();
        Double sum = em.createQuery(
                "SELECT SUM(b.totalPrice) FROM Booking b WHERE b.status = 'CONFIRMED'",
                Double.class)
                .getSingleResult();
        em.close();
        return sum == null ? 0 : sum;
    }
}
