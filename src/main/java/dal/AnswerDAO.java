/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import jakarta.persistence.EntityManager;
import model.Answer;
import utils.JPAUtil;

/**
 *
 * @author LE HOANG VIET
 */
public class AnswerDAO {
     public void addAnswer(Answer a) {

        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();
        em.persist(a);
        em.getTransaction().commit();

        em.close();
    }
}
