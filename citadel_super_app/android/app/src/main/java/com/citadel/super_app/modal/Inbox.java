package com.citadel.super_app.modal;

import android.content.Context;

import com.citadel.super_app.utils.Constant;
import com.citadel.super_app.utils.Utils;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.List;

public class Inbox {
    List<InboxItem> inbox;

    public List<InboxItem> getInboxList() {
        if (inbox == null)
            inbox = new ArrayList<>();

        return inbox;
    }

    public InboxItem getPublicInbox() {
        return findInbox(Constant.publicInbox);
    }

    public InboxItem findInbox(Context context) {
        return findInbox(getInboxName(context));
    }

    public InboxItem findInbox(String name) {
        for (InboxItem item : getInboxList()) {
            if (item.getInboxName().equals(name))
                return item;
        }
        return null;
    }

    public void save(Context context) {
        save(context, null);
    }

    public void save(Context context, InboxItem item) {
        if (item != null) {
            for (int i = 0; i < getInboxList().size(); ++i)
                if (inbox.get(i).getInboxName().equals(item.getInboxName()))
                    inbox.remove(i);

            inbox.add(item);
        }

        Utils.Insert(context, "data", new Gson().toJson(this));
    }

    public static String getUniqueId(Context context) {
        String id = Utils.Get(context, Constant.inboxKey, true);
        if (id == null) {
            id = "public";
        }
        return id;
    }

    public static String getInboxName(Context context) {
        return "inbox-" + getUniqueId(context);
    }

    public static Inbox get(Context context) {
        String inboxString = Utils.Get(context, "data", false);
        Inbox inbox = new Gson().fromJson(inboxString, Inbox.class);

        if (inbox == null) {
            inbox = new Inbox();
            inbox.save(context);
        }

        return inbox;
    }
}
