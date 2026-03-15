package dal;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import model.City;
import utils.JPAUtil;

public class CityDAO  {

    public List<City> searchCity(String keyword) {

        EntityManager em = JPAUtil.getEntityManager();

        String jpql = "SELECT c FROM City c WHERE LOWER(c.name) LIKE LOWER(:keyword)";

        TypedQuery<City> query = em.createQuery(jpql, City.class);
        query.setParameter("keyword", "%" + keyword + "%");

        return query.getResultList();
    }
}