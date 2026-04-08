package com.citadel.backend.utils;

import org.apache.commons.pool2.impl.GenericObjectPoolConfig;
import redis.clients.jedis.*;
import redis.clients.jedis.commands.JedisCommands;

import java.time.Duration;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class RedisUtil {
    static JedisPool pool;

    static String redisHost = System.getProperty("REDIS_HOST") == null ? SpringUtil.getMessage("redis.host") : System.getProperty("REDIS_HOST");
    static String password = SpringUtil.getMessage("redis.password");
    static JedisCluster cluster;

    public static JedisCommands getConnection() {
        if (redisHost.contains("cluster")) { // cluster
            if (cluster == null) {
                Set<HostAndPort> jedisClusterNodes = new HashSet<HostAndPort>();
                jedisClusterNodes.add(new HostAndPort(redisHost, 6379));

                int timeout = 10000;
                GenericObjectPoolConfig poolConfig = new GenericObjectPoolConfig();
                poolConfig.setTestWhileIdle(true);
                poolConfig.setMinEvictableIdleTime(Duration.ofMillis(60000L));
                poolConfig.setTimeBetweenEvictionRuns(Duration.ofMillis(30000L));
                poolConfig.setNumTestsPerEvictionRun(-1);

                poolConfig.setMaxTotal(200);
                poolConfig.setMaxIdle(50);
                poolConfig.setMaxWaitMillis(1000 * 100);
                poolConfig.setTestOnBorrow(false);
                cluster = new JedisCluster(jedisClusterNodes, timeout, poolConfig);
            }
            return cluster;
        } else { // single
            if (pool == null) {
                JedisPoolConfig poolConfig = new JedisPoolConfig();
                poolConfig.setMaxTotal(30);
                pool = new JedisPool(poolConfig, redisHost, 6379);
            }
            Jedis jedis = pool.getResource();
            if (StringUtil.isNotBlank(password)) {
                jedis.auth(password);
            }
            return jedis;
        }
    }

    public static void closeConnection(JedisCommands jedis) {
        if (jedis instanceof Jedis)
            ((Jedis) jedis).close();
    }

    public static String get(String key) {
        try {
            JedisCommands jedis = getConnection();
            String value = jedis.get(key);
            closeConnection(jedis);
            return value;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<String> getList(String listKey) {
        List<String> list = new ArrayList<>();
        try {
            JedisCommands jedis = getConnection();
            list = jedis.lrange(listKey, 0, -1);
            closeConnection(jedis);
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void addToList(String listKey, String value, Integer ttl) {
        try {
            JedisCommands jedis = getConnection();
            jedis.rpush(listKey, value);
            jedis.expire(listKey, ttl);
            closeConnection(jedis);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void removeFromList(String listKey, String value) {
        try {
            JedisCommands jedis = getConnection();
            jedis.lrem(listKey, 1, value);
            closeConnection(jedis);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void del(String key) {
        try {
            JedisCommands jedis = getConnection();
            jedis.del(key);
            closeConnection(jedis);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void set(String key, String value) {
        try {
            JedisCommands jedis = getConnection();
            jedis.set(key, value);
            closeConnection(jedis);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void set(String key, String value, Integer ttl) {
        try {
            JedisCommands jedis = getConnection();
            jedis.setex(key, ttl, value);
            closeConnection(jedis);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void expire(String key, int ttl) {
        try {
            JedisCommands jedis = getConnection();
            jedis.expire(key, ttl);
            closeConnection(jedis);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static boolean exists(String key) {
        try {
            JedisCommands jedis = getConnection();
            boolean exist = jedis.exists(key);
            closeConnection(jedis);
            return exist;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void clearByPattern(String pattern) {
        pattern = pattern + "*";
        try {
            for (ConnectionPool jedis2 : cluster.getClusterNodes().values()) {
                try (Jedis j = new Jedis(jedis2.getResource())) {
                    // Single node scan from earlier example
                    Set<String> result = j.keys(pattern);
                    System.out.println(pattern);
                    if (result != null) {
                        for (String key : result) {
                            System.out.println("Clearing cache: " + key);
                            j.del(key);
                        }
                    }
                    closeConnection(j);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
