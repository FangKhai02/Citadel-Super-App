package com.citadel.super_app.modal;

import java.util.ArrayList;
import java.util.List;

public class InboxItem {
    String inboxName;
    List<InboxMessageItem> messageList;

    public String getInboxName() {
        return inboxName;
    }

    public InboxItem setInboxName(String inboxName) {
        this.inboxName = inboxName;
        return this;
    }

    public List<InboxMessageItem> getMessageList() {
        if (messageList == null)
            messageList = new ArrayList<>();
        return messageList;
    }

    public InboxItem setMessageList(List<InboxMessageItem> messageList) {
        this.messageList = messageList;
        return this;
    }

    public InboxMessageItem getMessageById(String notificationId) {
        InboxMessageItem selectedInboxMessageItem = null;
        List<InboxMessageItem> itemList = getMessageList();
        for (InboxMessageItem item : itemList) {
            if (item.notificationId.equalsIgnoreCase(notificationId)) {
                selectedInboxMessageItem = item;
                break;
            }
        }
        return selectedInboxMessageItem;
    }

    public void deleteInboxMessageItemByNotificationId(String notificationId) {
        List<InboxMessageItem> inboxItemToDeleteList = new ArrayList<>();
        List<InboxMessageItem> currentInboxList = getMessageList();

        for (InboxMessageItem inboxMessageItem : currentInboxList) {
            if (inboxMessageItem.getNotificationId().equalsIgnoreCase(notificationId)) {
                inboxItemToDeleteList.add(inboxMessageItem);
            }
        }
        currentInboxList.removeAll(inboxItemToDeleteList);
    }
}
