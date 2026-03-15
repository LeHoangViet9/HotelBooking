/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 *
 * @author LE HOANG VIET
 */
public class JPAUtil {

    private static final EntityManagerFactory emf
            = Persistence.createEntityManagerFactory("HotelJPA");

    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
}
