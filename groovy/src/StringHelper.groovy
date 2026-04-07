/**
 * String utility class
 * Code smell: static methods with mutable static state
 */
class StringHelper {
    // Code smell: static mutable state
    static int callCount = 0

    static String truncate(String text, int maxLength) {
        callCount++
        if (!text) return ""
        if (text.length() <= maxLength) return text
        return text.substring(0, maxLength) + "..."
    }

    static String capitalize(String text) {
        if (!text) return ""
        return text.substring(0, 1).toUpperCase() + text.substring(1)
    }

    static String slugify(String text) {
        if (!text) return ""
        return text.toLowerCase()
                .replaceAll(/[^a-z0-9\s-]/, '')
                .replaceAll(/\s+/, '-')
                .replaceAll(/-+/, '-')
                .trim()
    }

    static boolean isEmail(String text) {
        if (!text) return false
        return text ==~ /[\w.+-]+@[\w.-]+\.[a-zA-Z]{2,}/
    }

    static String maskEmail(String email) {
        if (!email || !email.contains('@')) return email
        def parts = email.split('@')
        def username = parts[0]
        def domain = parts[1]
        if (username.length() <= 2) {
            return "**@${domain}"
        }
        return "${username[0]}***${username[-1]}@${domain}"
    }
}