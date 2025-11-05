package com.ems.util;

public class ColorUtils {
    
    public static String generateRandomColor(String seed) {
        if (seed == null) seed = "default";
        
        int hash = 0;
        for (int i = 0; i < seed.length(); i++) {
            hash = seed.charAt(i) + ((hash << 5) - hash);
        }
        
        int hue = Math.abs(hash) % 360;
        
        return hslToRgb(hue / 360.0, 0.7, 0.5);
    }
    
    private static String hslToRgb(double h, double s, double l) {
        double r, g, b;
        
        if (s == 0) {
            r = g = b = l; // achromatic
        } else {
            double q = l < 0.5 ? l * (1 + s) : l + s - l * s;
            double p = 2 * l - q;
            r = hueToRgb(p, q, h + 1.0/3);
            g = hueToRgb(p, q, h);
            b = hueToRgb(p, q, h - 1.0/3);
        }
        
        int red = (int) (r * 255);
        int green = (int) (g * 255);
        int blue = (int) (b * 255);
        
        return String.format("#%02x%02x%02x", red, green, blue);
    }
    
    private static double hueToRgb(double p, double q, double t) {
        if (t < 0) t += 1;
        if (t > 1) t -= 1;
        if (t < 1.0/6) return p + (q - p) * 6 * t;
        if (t < 1.0/2) return q;
        if (t < 2.0/3) return p + (q - p) * (2.0/3 - t) * 6;
        return p;
    }
    
    public static String generateInitials(String fullName, String username) {
        if (fullName != null && !fullName.trim().isEmpty()) {
            String[] nameParts = fullName.split(" ");
            if (nameParts.length > 0) {
                String initials = nameParts[0].substring(0, 1).toUpperCase();
                if (nameParts.length > 1) {
                    initials += nameParts[nameParts.length - 1].substring(0, 1).toUpperCase();
                }
                return initials;
            }
        }
        
        if (username != null && !username.trim().isEmpty()) {
            return username.substring(0, 1).toUpperCase();
        }
        
        return "A";
    }
}