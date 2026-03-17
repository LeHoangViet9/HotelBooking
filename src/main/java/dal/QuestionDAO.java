/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import jakarta.persistence.EntityManager;
import java.util.List;
import model.Question;
import utils.JPAUtil;

/**
 *
 * @author LE HOANG VIET
 */
public class QuestionDAO {

    public void addQuestion(Question q) {

        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();
        em.persist(q);
        em.getTransaction().commit();

        em.close();
    }

    public List<Question> getAllQuestions() {
        EntityManager em = JPAUtil.getEntityManager();
        List<Question> list = em.createQuery(
                "SELECT DISTINCT q FROM Question q "
                + "LEFT JOIN FETCH q.user "
                + "LEFT JOIN FETCH q.answers a "
                + "LEFT JOIN FETCH a.user "
                + "ORDER BY q.createdAt DESC",
                Question.class)
                .getResultList();
        em.close();
        return list;
    }

    public List<Question> getByHotel(int hotelId) {
        EntityManager em = JPAUtil.getEntityManager();

        List<Question> list = em.createQuery(
                "SELECT DISTINCT q FROM Question q "
                + "LEFT JOIN FETCH q.user "
                + "LEFT JOIN FETCH q.answers a "
                + "LEFT JOIN FETCH a.user "
                + "WHERE q.hotel.id = :hid",
                Question.class)
                .setParameter("hid", hotelId)
                .getResultList();

        em.close();

        return list;
    }

    public Question getById(int id) {

        EntityManager em = JPAUtil.getEntityManager();

        Question q = em.find(Question.class, id);

        em.close();

        return q;
    }
}
