package com.example.teleexpertise.model.enums;

public enum TypeActeTechnique {
    RADIOGRAPHIE(200.0),
    ECHOGRAPHIE(300.0),
    IRM(1500.0),
    ELECTROCARDIOGRAMME(100.0),
    LASER_DERMATOLOGIQUE(800.0),
    FOND_OEIL(150.0),
    ANALYSE_SANG(250.0),
    ANALYSE_URINE(100.0);

    private final Double prixParDefaut;

    TypeActeTechnique(Double prixParDefaut) {
        this.prixParDefaut = prixParDefaut;
    }

    public Double getPrixParDefaut() {
        return prixParDefaut;
    }
}

