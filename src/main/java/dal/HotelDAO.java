package dal;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import model.Hotel;
import utils.JPAUtil;

public class HotelDAO {

    public List<Hotel> search(String city, Double min, Double max,
            String sort, int page, int pageSize
    ) {

        EntityManager em = JPAUtil.getEntityManager();

        String jpql = "SELECT DISTINCT h FROM Hotel h JOIN h.rooms r WHERE 1=1";

        if (city != null && !city.isEmpty()) {
            jpql += " AND h.city.name LIKE :city";
        }

        if (min != null && max != null) {
            jpql += " AND r.price BETWEEN :min AND :max";
        }

        if ("priceAsc".equals(sort)) {
            jpql += " ORDER BY r.price ASC";
        } else if ("priceDesc".equals(sort)) {
            jpql += " ORDER BY r.price DESC";
        }

        TypedQuery<Hotel> query = em.createQuery(jpql, Hotel.class);

        if (city != null && !city.isEmpty()) {
            query.setParameter("city", "%" + city + "%");
        }

        if (min != null && max != null) {
            query.setParameter("min", min);
            query.setParameter("max", max);
        }

        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);

        List<Hotel> list = query.getResultList();
        em.close();

        return list;
    }

    public long countHotels() {
        EntityManager em = JPAUtil.getEntityManager();
        long count = em.createQuery("SELECT COUNT(h) FROM Hotel h", Long.class)
                .getSingleResult();
        em.close();
        return count;
    }

    public int countSearch(String city, Double min, Double max) {

        EntityManager em = JPAUtil.getEntityManager();

        String jpql = "SELECT COUNT(DISTINCT h) FROM Hotel h JOIN h.rooms r WHERE 1=1";

        if (city != null && !city.isEmpty()) {
            jpql += " AND h.city.name LIKE :city";
        }

        if (min != null && max != null) {
            jpql += " AND r.price BETWEEN :min AND :max";
        }

        TypedQuery<Long> query = em.createQuery(jpql, Long.class);

        if (city != null && !city.isEmpty()) {
            query.setParameter("city", "%" + city + "%");
        }

        if (min != null && max != null) {
            query.setParameter("min", min);
            query.setParameter("max", max);
        }

        int count = query.getSingleResult().intValue();

        em.close();
        return count;
    }

    public List<Hotel> getAllHotel() {
        EntityManager em = JPAUtil.getEntityManager();
        List<Hotel> list = em.createQuery("Select h From Hotel h", Hotel.class).getResultList();
        em.close();
        return list;
    }

    public Hotel findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();

        Hotel hotel = em.createQuery(
                "SELECT h FROM Hotel h LEFT JOIN FETCH h.rooms WHERE h.id = :id",
                Hotel.class)
                .setParameter("id", id)
                .getSingleResult();

        em.close();

        return hotel;
    }

    public void addHotel(Hotel hotel) {

        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();

        em.persist(hotel);

        em.getTransaction().commit();

        em.close();
    }

    public void updateHotel(Hotel hotel) {

        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();

        em.merge(hotel);

        em.getTransaction().commit();

        em.close();
    }

    public void deleteHotel(int id) {

        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();

        Hotel h = em.find(Hotel.class, id);

        if (h != null) {
            em.remove(h);
        }

        em.getTransaction().commit();

        em.close();
    }

}
