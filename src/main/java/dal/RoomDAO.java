/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import model.Room;
import utils.JPAUtil;

/**
 *
 * @author LE HOANG VIET
 */
public class RoomDAO {

    public List<Room> getAllRooms() {
        EntityManager em = JPAUtil.getEntityManager();
        List<Room> list = em.createQuery("Select r from Room r", Room.class).getResultList();
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

    public List<Room> search(String keyword, int page, int pageSize, String sort) {

        EntityManager em = JPAUtil.getEntityManager();

        String jpql = "SELECT r FROM Room r WHERE r.roomType LIKE :kw";

        if ("priceAsc".equals(sort)) {
            jpql += " ORDER BY r.price ASC";
        } else if ("priceDesc".equals(sort)) {
            jpql += " ORDER BY r.price DESC";
        }

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

        String jpql = "SELECT r FROM Room r WHERE r.hotel.id = :hotelId";

        TypedQuery<Room> query = em.createQuery(jpql, Room.class);
        query.setParameter("hotelId", hotelId);

        List<Room> list = query.getResultList();

        em.close();

        return list;
    }
}
