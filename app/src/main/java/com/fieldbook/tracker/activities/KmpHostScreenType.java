package com.fieldbook.tracker.activities;

public enum KmpHostScreenType {
    CONFIG("config");

    private final String value;

    KmpHostScreenType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static KmpHostScreenType fromValue(String value) {
        for (KmpHostScreenType type : values()) {
            if (type.value.equalsIgnoreCase(value)) {
                return type;
            }
        }
        return CONFIG;
    }
}

