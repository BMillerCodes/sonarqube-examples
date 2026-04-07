package com.example.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Logging utility helper.
 * Code smell: utility class with static methods that could be a logging framework
 */
public class LoggerUtil {
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    public static String formatLog(String level, String message) {
        return String.format("[%s] [%s] %s", LocalDateTime.now().format(FORMATTER), level, message);
    }

    public static String info(String message) {
        return formatLog("INFO", message);
    }

    public static String warn(String message) {
        return formatLog("WARN", message);
    }

    public static String error(String message) {
        return formatLog("ERROR", message);
    }

    public static String error(String message, Throwable t) {
        return formatLog("ERROR", message + " - Exception: " + t.getMessage());
    }

    public static void logInfo(String message) {
        System.out.println(info(message));
    }

    public static void logWarn(String message) {
        System.out.println(warn(message));
    }

    public static void logError(String message) {
        System.err.println(error(message));
    }

    public static void logError(String message, Throwable t) {
        System.err.println(error(message, t));
    }
}