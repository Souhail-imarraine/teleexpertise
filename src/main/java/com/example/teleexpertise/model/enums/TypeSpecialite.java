package com.example.teleexpertise.model.enums;

public enum TypeSpecialite {
    CARDIOLOGIE("Cardiologie"),
    PNEUMOLOGIE("Pneumologie"),
    NEUROLOGIE("Neurologie"),
    GASTRO_ENTEROLOGIE("Gastro-entérologie"),
    ENDOCRINOLOGIE("Endocrinologie"),
    DERMATOLOGIE("Dermatologie"),
    RHUMATOLOGIE("Rhumatologie"),
    PSYCHIATRIE("Psychiatrie"),
    NEPHROLOGIE("Néphrologie"),
    ORTHOPEDIE("Orthopédie"),
    OPHTALMOLOGIE("Ophtalmologie"),
    ORL("ORL"),
    GYNECOLOGIE("Gynécologie"),
    UROLOGIE("Urologie"),
    ONCOLOGIE("Oncologie");

    private final String label;

    TypeSpecialite(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    @Override
    public String toString() {
        return label;
    }

    public static TypeSpecialite fromLabel(String label) {
        for (TypeSpecialite type : values()) {
            if (type.label.equalsIgnoreCase(label)) {
                return type;
            }
        }
        throw new IllegalArgumentException("Spécialité inconnue: " + label);
    }
}
