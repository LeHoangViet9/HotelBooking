package dal;

import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import model.User;
import utils.JPAUtil;

public class UserDAO {

    public User login(String email, String password) {
        try (EntityManager em = JPAUtil.getEntityManager()) {
            java.util.List<User> list = em.createQuery(
                    "SELECT u FROM User u WHERE u.email = :e AND u.password = :p",
                    User.class)
                    .setParameter("e", email)
                    .setParameter("p", password)
                    .setMaxResults(1)
                    .getResultList();
            return list.isEmpty() ? null : list.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void register(User user) {
        try (EntityManager em = JPAUtil.getEntityManager()) {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
        }
    }

    public User findByEmail(String email) {
        try (EntityManager em = JPAUtil.getEntityManager()) {
            java.util.List<User> list = em.createQuery(
                    "SELECT u FROM User u WHERE u.email = :e",
                    User.class)
                    .setParameter("e", email)
                    .setMaxResults(1)
                    .getResultList();
            return list.isEmpty() ? null : list.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public long countUsers() {
        EntityManager em = JPAUtil.getEntityManager();
        long count = em.createQuery("SELECT COUNT(u) FROM User u", Long.class)
                .getSingleResult();
        em.close();
        return count;
    }

    public void update(User user) {

        EntityManager em = JPAUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            em.merge(user);

            em.getTransaction().commit();

        } catch (Exception e) {
            e.printStackTrace();
            em.getTransaction().rollback();
        } finally {
            em.close();
        }
    }

    public void resetPassword(String email, String newPassword) {
        EntityManager em = JPAUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            User user = findByEmail(email);
            user.setPassword(newPassword);

            em.merge(user);

            em.getTransaction().commit();

        } catch (Exception e) {
            em.getTransaction().rollback();
        } finally {
            em.close();
        }
    }
    
}
