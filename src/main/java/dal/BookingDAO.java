package dal;

import jakarta.persistence.EntityManager;
import java.util.List;
import model.Booking;
import model.BookingStatus;
import model.Room;
import utils.JPAUtil;

public class BookingDAO {

    public List<Booking> findAll() {
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
            BookingStatus current = booking.getStatus();

            if (newStatus == BookingStatus.CONFIRMED && current == BookingStatus.PENDING) {
                if (room.getQuantity() <= 0) {
                    em.getTransaction().rollback();
                    return;
                }
                room.setQuantity(room.getQuantity() - 1);
                booking.setStatus(BookingStatus.CONFIRMED);

            } else if (newStatus == BookingStatus.CANCELLED && current == BookingStatus.CONFIRMED) {
                room.setQuantity(room.getQuantity() + 1);
                booking.setStatus(BookingStatus.CANCELLED);

            } else if (newStatus == BookingStatus.COMPLETED && current == BookingStatus.CONFIRMED) {
                // Restore room quantity when stay is completed
                room.setQuantity(room.getQuantity() + 1);
                booking.setStatus(BookingStatus.COMPLETED);
            }

            // Auto-update room status based on quantity
            if (room.getQuantity() <= 0) {
                room.setStatus(model.RoomStatus.FULL);
            } else {
                room.setStatus(model.RoomStatus.AVAILABLE);
            }

            em.merge(room);
            em.merge(booking);
            em.getTransaction().commit();

        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
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
                "SELECT b FROM Booking b "
                + "JOIN FETCH b.room r "
                + "JOIN FETCH r.hotel "
                + "WHERE b.user.id = :uid AND b.status <> :cancelled "
                + "ORDER BY b.id DESC",
                Booking.class)
                .setParameter("uid", userId)
                .setParameter("cancelled", BookingStatus.CANCELLED)
                .getResultList();
        em.close();
        return list;
    }

    public void cancelBooking(int bookingId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Booking booking = em.find(Booking.class, bookingId);
            if (booking != null
                    && (booking.getStatus() == BookingStatus.CONFIRMED
                    || booking.getStatus() == BookingStatus.PENDING)) {

                Room room = booking.getRoom();
                if (booking.getStatus() == BookingStatus.CONFIRMED) {
                    room.setQuantity(room.getQuantity() + 1);
                    em.merge(room);
                }
                booking.setStatus(BookingStatus.CANCELLED);
                em.merge(booking);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

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

    /** Returns the most recent {@code limit} bookings with all associations loaded. */
    public List<Booking> getRecent(int limit) {
        EntityManager em = JPAUtil.getEntityManager();
        List<Booking> list = em.createQuery(
                "SELECT b FROM Booking b "
                + "JOIN FETCH b.user "
                + "JOIN FETCH b.room r "
                + "JOIN FETCH r.hotel "
                + "ORDER BY b.id DESC",
                Booking.class)
                .setMaxResults(limit)
                .getResultList();
        em.close();
        return list;
    }

    public long countByStatus(BookingStatus status) {
        EntityManager em = JPAUtil.getEntityManager();
        long count = em.createQuery(
                "SELECT COUNT(b) FROM Booking b WHERE b.status = :status", Long.class)
                .setParameter("status", status)
                .getSingleResult();
        em.close();
        return count;
    }

    public List<Booking> getPaging(int page, int pageSize) {
        EntityManager em = JPAUtil.getEntityManager();
        List<Booking> list = em.createQuery(
                "SELECT b FROM Booking b "
                + "JOIN FETCH b.user "
                + "JOIN FETCH b.room r "
                + "JOIN FETCH r.hotel "
                + "ORDER BY b.id DESC",
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
                "SELECT b FROM Booking b "
                + "JOIN FETCH b.user "
                + "JOIN FETCH b.room r "
                + "JOIN FETCH r.hotel "
                + "WHERE b.status = :status "
                + "ORDER BY b.id DESC",
                Booking.class)
                .setParameter("status", BookingStatus.valueOf(status))
                .getResultList();
        em.close();
        return list;
    }

    public List<Booking> searchAndFilter(String keyword, String status) {
        EntityManager em = JPAUtil.getEntityManager();
        
        StringBuilder jpql = new StringBuilder(
            "SELECT b FROM Booking b "
            + "JOIN FETCH b.user u "
            + "JOIN FETCH b.room r "
            + "JOIN FETCH r.hotel h "
            + "WHERE 1=1 "
        );

        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasStatus = status != null && !status.trim().isEmpty();

        if (hasKeyword) {
            jpql.append("AND (LOWER(u.fullName) LIKE LOWER(:kw) "
                      + "OR LOWER(h.name) LIKE LOWER(:kw)) ");
        }
        
        if (hasStatus) {
            jpql.append("AND b.status = :status ");
        }
        
        jpql.append("ORDER BY b.id DESC");

        var query = em.createQuery(jpql.toString(), Booking.class);

        if (hasKeyword) {
            query.setParameter("kw", "%" + keyword.trim() + "%");
        }
        
        if (hasStatus) {
            try {
                query.setParameter("status", BookingStatus.valueOf(status.trim().toUpperCase()));
            } catch (IllegalArgumentException e) {
                // If invalid status, don't set parameter and it will likely result in no matches 
                // but to avoid query errors let's set a placeholder or simply remove it.
                // However JPA will throw exception if parameter is missing but declared.
                query.setParameter("status", BookingStatus.PENDING); // Fallback to avoid error
            }
        }

        List<Booking> list = query.getResultList();
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

    /**
     * Returns monthly stats for a given year.
     * Each Object[]: [0]=month(int), [1]=count(long), [2]=revenue(double)
     */
    @SuppressWarnings("unchecked")
    public List<Object[]> getMonthlyRevenue(int year) {
        EntityManager em = JPAUtil.getEntityManager();
        List<Object[]> result = em.createNativeQuery(
                "SELECT MONTH(check_in) AS m, COUNT(*) AS cnt, SUM(total_price) AS rev "
                + "FROM bookings "
                + "WHERE YEAR(check_in) = :year "
                + "  AND status IN ('CONFIRMED','COMPLETED') "
                + "GROUP BY MONTH(check_in) "
                + "ORDER BY MONTH(check_in)")
                .setParameter("year", year)
                .getResultList();
        em.close();
        return result;
    }

    /** Revenue = sum of CONFIRMED + COMPLETED bookings. */
    public double totalRevenue() {
        EntityManager em = JPAUtil.getEntityManager();
        Double sum = em.createQuery(
                "SELECT SUM(b.totalPrice) FROM Booking b "
                + "WHERE b.status = :c OR b.status = :d",
                Double.class)
                .setParameter("c", BookingStatus.CONFIRMED)
                .setParameter("d", BookingStatus.COMPLETED)
                .getSingleResult();
        em.close();
        return sum == null ? 0 : sum;
    }
}
