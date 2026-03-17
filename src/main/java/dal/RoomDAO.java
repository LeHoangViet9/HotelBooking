package dal;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import model.Room;
import model.RoomStatus;
import utils.JPAUtil;

public class RoomDAO {

    public List<Room> getAllRooms() {
        EntityManager em = JPAUtil.getEntityManager();
        List<Room> list = em.createQuery(
                "SELECT r FROM Room r JOIN FETCH r.hotel ORDER BY r.hotel.id, r.id", Room.class)
                .getResultList();
        em.close();
        return list;
    }

    public Room findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        Room room = em.find(Room.class, id);
        em.close();
        return room;
    }

    public void update(Room room) {
        EntityManager em = JPAUtil.getEntityManager();
        em.getTransaction().begin();
        em.merge(room);
        em.getTransaction().commit();
        em.close();
    }

    public void addRoom(Room room) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            // Auto-set status based on quantity
            if (room.getQuantity() <= 0) {
                room.setStatus(RoomStatus.FULL);
            } else {
                room.setStatus(RoomStatus.AVAILABLE);
            }
            em.persist(room);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public void updateRoom(Room room) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            // Auto-set status based on quantity
            if (room.getQuantity() <= 0) {
                room.setStatus(RoomStatus.FULL);
            } else if (room.getStatus() == RoomStatus.FULL) {
                room.setStatus(RoomStatus.AVAILABLE);
            }
            em.merge(room);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public void deleteRoom(int id) throws Exception {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            // Xóa các booking (hoạt động giống giỏ hàng) liên đới tới phòng này trước để tránh lỗi Khóa ngoại (Foreign Key)
            em.createQuery("DELETE FROM Booking b WHERE b.room.id = :roomId")
              .setParameter("roomId", id)
              .executeUpdate();

            Room room = em.find(Room.class, id);
            if (room != null) {
                // Remove the room from the hotel's list to manage both sides of the bi-directional relationship
                if (room.getHotel() != null && room.getHotel().getRooms() != null) {
                    room.getHotel().getRooms().remove(room);
                }
                em.remove(room);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            System.err.println("======== ERROR DELETING ROOM " + id + " ========");
            e.printStackTrace();
            System.err.println("==============================================");
            throw e; // Ném lỗi ra ngoài thay vì nuốt
        } finally {
            em.close();
        }
    }

    public List<Room> search(String keyword, int page, int pageSize, String sort) {
        EntityManager em = JPAUtil.getEntityManager();
        String jpql = "SELECT r FROM Room r WHERE r.roomType LIKE :kw";
        if ("priceAsc".equals(sort)) jpql += " ORDER BY r.price ASC";
        else if ("priceDesc".equals(sort)) jpql += " ORDER BY r.price DESC";
        TypedQuery<Room> query = em.createQuery(jpql, Room.class);
        query.setParameter("kw", "%" + keyword + "%");
        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);
        List<Room> list = query.getResultList();
        em.close();
        return list;
    }

    public List<Room> getRoomsByHotelId(int hotelId) {
        EntityManager em = JPAUtil.getEntityManager();
        List<Room> list = em.createQuery(
                "SELECT r FROM Room r WHERE r.hotel.id = :hotelId ORDER BY r.price ASC",
                Room.class)
                .setParameter("hotelId", hotelId)
                .getResultList();
        em.close();
        return list;
    }

    public double getMaxPrice() {
        EntityManager em = JPAUtil.getEntityManager();
        Double max = em.createQuery("SELECT MAX(r.price) FROM Room r", Double.class).getSingleResult();
        em.close();
        return max != null ? max : 0.0;
    }

    public double getMinPrice() {
        EntityManager em = JPAUtil.getEntityManager();
        Double min = em.createQuery("SELECT MIN(r.price) FROM Room r", Double.class).getSingleResult();
        em.close();
        return min != null ? min : 0.0;
    }
}
