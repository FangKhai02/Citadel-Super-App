package com.citadel.super_app;

import android.os.Build;
import android.os.Bundle;
import android.view.View;
import android.view.WindowManager;

import androidx.annotation.NonNull;
import androidx.core.view.WindowCompat;

import com.citadel.super_app.modal.Inbox;
import com.citadel.super_app.modal.InboxItem;
import com.citadel.super_app.modal.InboxMessageItem;
import com.citadel.super_app.service.NotificationServiceExtension;
import com.citadel.super_app.utils.Constant;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterFragmentActivity {
    public static final String CHANNEL_INBOX = "com.citadel.super_app.inbox";
    public static MethodChannel methodChannelInbox;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Configure window for proper edge-to-edge handling
        // This ensures consistent behavior across Android versions
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);

            // For Android 11+ (API 30+), use modern window insets controller
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                // Let Flutter handle the insets, don't let system bars push content
                WindowCompat.setDecorFitsSystemWindows(getWindow(), true);
            }

            // Ensure proper system bar behavior
            View decorView = getWindow().getDecorView();
            int flags = decorView.getSystemUiVisibility();

            // Keep system bars visible and ensure they don't overlay content
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                flags |= View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
                flags |= View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR;
            }

            decorView.setSystemUiVisibility(flags);
        }
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        methodChannelInbox = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL_INBOX);
        methodChannelInbox.setMethodCallHandler(this::methodCallInboxHandler);
    }

    void methodCallInboxHandler(MethodCall methodCall, MethodChannel.Result result) {
        final String method = methodCall.method;
        switch (method) {
            case Constant.getPublicInboxNotification:
                getPublicInboxNotification(result);
                break;
            case Constant.deletePublicInboxNotification:
                deletePublicInboxNotification(result);
                break;
        }
    }

    void getPublicInboxNotification(MethodChannel.Result result) {
        List<InboxMessageItem> retrievedInboxList = new ArrayList<>();
        final Inbox publicInbox = Inbox.get(getApplicationContext());
        final InboxItem inboxItem = publicInbox.findInbox(getApplicationContext());

        if (inboxItem != null) {
            retrievedInboxList.addAll(inboxItem.getMessageList());
        }

        if (!retrievedInboxList.isEmpty()) {
            String inboxItemListJson = new Gson().toJson(retrievedInboxList);
            result.success(inboxItemListJson);
        } else {
            result.success(null);
        }
    }

    void deletePublicInboxNotification(MethodChannel.Result result) {
        final Inbox publicInbox = Inbox.get(getApplicationContext());
        final InboxItem inboxItem = publicInbox.findInbox(getApplicationContext());

        if (inboxItem != null) {
            inboxItem.getMessageList().clear();
            publicInbox.save(getApplicationContext(), inboxItem);
        }

        result.success(null);
    }

}
