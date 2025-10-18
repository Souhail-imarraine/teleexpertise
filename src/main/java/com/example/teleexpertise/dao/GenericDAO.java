package com.example.teleexpertise.dao;

import java.util.List;
import java.util.Optional;

/**
 * Interface DAO générique SIMPLIFIÉE
 * @param <T> Type de l'entité (Patient, Consultation, Specialiste...)
 */
public interface GenericDAO<T> {

    // CREATE - Créer
    T save(T entity);
    // READ - Lire
    Optional<T> findById(Long id);
    List<T> findAll();

    // UPDATE - Mettre à jour
    T update(T entity);

    // DELETE - Supprimer (UNE SEULE méthode)
    void deleteById(Long id);

    // UTILITAIRES
    long count();
    boolean existsById(Long id);
}