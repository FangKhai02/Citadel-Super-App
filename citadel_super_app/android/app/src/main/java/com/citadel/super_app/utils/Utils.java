package com.citadel.super_app.utils;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

import java.util.Map;

public class Utils {

    private static final String Key = "FlutterSharedPreferences";

    private static Map<String, String> header;

    public static void Insert (Context context, String preferenceName, String key, String value)
    {
        Editor editor = context.getSharedPreferences(preferenceName, Context.MODE_PRIVATE)
                .edit();

        editor.putString(key, value);

        editor.apply();
    }

    public static void Insert (Context context, String key, String value)
    {
        Editor editor = context.getSharedPreferences(Key, Context.MODE_PRIVATE)
                .edit();

        editor.putString(key, value);

        editor.apply();
    }

    public static void Insert (Context context, String key, long value)
    {
        Editor editor = context.getSharedPreferences(Key, Context.MODE_PRIVATE)
                .edit();

        editor.putLong(key, value);

        editor.apply();
    }

    public static void Insert (Context context, String key, int value)
    {
        Editor editor = context.getSharedPreferences(Key, Context.MODE_PRIVATE)
                .edit();

        editor.putInt(key, value);

        editor.apply();
    }

    public static void Insert (Context context, String key, boolean value)
    {
        Editor editor = context.getSharedPreferences(Key, Context.MODE_PRIVATE)
                .edit();

        editor.putBoolean(key, value);

        editor.apply();
    }

    public static void Delete (Context context, String key)
    {
        context.getSharedPreferences(Key, Context.MODE_PRIVATE).edit().remove(key).apply();
    }

    public static String Get (Context context, String key, boolean returnNull)
    {
        SharedPreferences retrieveuserdata = context.getSharedPreferences(Key,
                Context.MODE_PRIVATE);

        return retrieveuserdata.getString(key, returnNull ? null : "");
    }

    public static long GetLong (Context context, String key)
    {
        SharedPreferences retrieveuserdata = context.getSharedPreferences(Key,
                Context.MODE_PRIVATE);

        return retrieveuserdata.getLong(key, 0);
    }

    public static int GetInt (Context context, String key)
    {
        SharedPreferences retrieveuserdata = context.getSharedPreferences(Key,
                Context.MODE_PRIVATE);

        return retrieveuserdata.getInt(key, -1);
    }

    public static SharedPreferences GetSharedPreference (Context context)
    {
        return context.getSharedPreferences(Key, Context.MODE_PRIVATE);
    }

    public static void Delete (Context context)
    {
        SharedPreferences retrieveuserdata = context.getSharedPreferences(Key,
                Context.MODE_PRIVATE);

        retrieveuserdata.edit().clear().apply();
    }

}
