package com.citadel.super_app.service;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;

import com.citadel.super_app.MainActivity;
import com.citadel.super_app.modal.Inbox;
import com.citadel.super_app.modal.InboxItem;
import com.citadel.super_app.modal.InboxMessageItem;
import com.citadel.super_app.utils.Constant;
import com.onesignal.notifications.IDisplayableMutableNotification;
import com.onesignal.notifications.INotificationReceivedEvent;
import com.onesignal.notifications.INotificationServiceExtension;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;

public class NotificationServiceExtension implements INotificationServiceExtension {
    private static final String TAG = "CITADEL:NotificationExt";

    @Override
    public void onNotificationReceived(@NonNull INotificationReceivedEvent event) {
        IDisplayableMutableNotification notification = event.getNotification();
        JSONObject data = notification.getAdditionalData();
        Log.e(TAG, "Received Notification Data: " + data);

         if (data != null && data.length() == 0) {

            InboxMessageItem message = new InboxMessageItem()
                    .setNotificationId(notification.getNotificationId())
                    .setTitle(notification.getTitle())
                    .setMessage(notification.getBody())
                    .setImageUrl(notification.getBigPicture())
                    .setDate(System.currentTimeMillis())
                    .setLaunchUrl(notification.getLaunchURL());

            storeToInbox(event.getContext(), message);
            getInbox();
        }

        event.getNotification().display();
    }

    void getInbox() {
        try {
            if (MainActivity.methodChannelInbox != null) {
                Handler handler = new Handler(Looper.getMainLooper());
                handler.post(() -> MainActivity.methodChannelInbox.invokeMethod(Constant.getPublicInboxNotification, null));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void storeToInbox(Context context, InboxMessageItem message) {
        Inbox inbox = Inbox.get(context);

        InboxItem inboxItem = inbox.findInbox(context);
        if (inboxItem == null) {
            inboxItem = new InboxItem().setInboxName("inbox-" + Inbox.getUniqueId(context));
            inbox.getInboxList().add(inboxItem);
        }
        Log.d(TAG, "storeToInbox: " + inboxItem.getInboxName());

        boolean sameMessageExist = false;
        List<InboxMessageItem> inboxMessageItemList = inboxItem.getMessageList();
        for (InboxMessageItem inboxMessageItem : inboxMessageItemList) {
            if (inboxMessageItem.getNotificationId().equalsIgnoreCase(message.getNotificationId())) {
                sameMessageExist = true;
                break;
            }
        }

        if (!sameMessageExist) {
            inboxMessageItemList.add(message);
        }

        inbox.save(context);
    }
}
