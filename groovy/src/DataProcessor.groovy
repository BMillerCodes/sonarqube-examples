/**
 * Data processor for transforming data
 * Code smell: empty catch blocks
 */
class DataProcessor {
    /**
     * Process a list of items with a transformation closure
     */
    static List process(List items, Closure transform) {
        // Code smell: empty catch block
        try {
            return items.collect(transform)
        } catch (Exception e) {
            // Code smell: empty catch block - silently fails
        }
    }

    /**
     * Filter items based on a predicate
     */
    static List filter(List items, Closure predicate) {
        try {
            return items.findAll(predicate)
        } catch (Exception e) {
            // Code smell: empty catch block
            return []
        }
    }

    /**
     * Group items by a key function
     */
    static Map groupBy(List items, Closure keyFunction) {
        try {
            return items.groupBy(keyFunction)
        } catch (Exception e) {
            // Code smell: empty catch block
            return [:]
        }
    }

    /**
     * Aggregate items using a reduce function
     */
    static Object aggregate(List items, Closure reduce, Object initial) {
        try {
            return items.reduce(initial, reduce)
        } catch (Exception e) {
            // Code smell: empty catch block
            return initial
        }
    }
}

/**
 * Cache manager with TTL support
 * Code smell: empty catch blocks, unused variables
 */
class CacheManager {
    def cache = [:]
    int maxSize = 100

    // Code smell: unused variable
    String backend = "memory"

    void put(String key, Object value, int ttlSeconds = 300) {
        try {
            def expiresAt = System.currentTimeMillis() + (ttlSeconds * 1000)
            cache[key] = [value: value, expiresAt: expiresAt]

            // Evict oldest if over max size
            if (cache.size() > maxSize) {
                def oldestKey = cache.keySet()[0]
                cache.remove(oldestKey)
            }
        } catch (Exception e) {
            // Code smell: empty catch block
        }
    }

    Object get(String key) {
        try {
            def entry = cache[key]
            if (!entry) return null

            if (System.currentTimeMillis() > entry.expiresAt) {
                cache.remove(key)
                return null
            }

            return entry.value
        } catch (Exception e) {
            // Code smell: empty catch block
            return null
        }
    }

    void clear() {
        cache.clear()
    }

    int size() {
        return cache.size()
    }
}