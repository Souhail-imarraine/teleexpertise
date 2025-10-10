package com.example.teleexpertise.model;
import java.util.ArrayList;
import java.util.List;
import jakarta.persistence.*;

@Entity
@Table(name = "patients")
public class Patient extends utilisateur {
    @OneToMany(mappedBy="patient", cascade = CascadeType.ALL, orphanRemoval=true, fetch = FetchType.LAZY)
    private List<Consultation> consultations = new ArrayList<>();

}
