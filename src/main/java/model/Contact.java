package model;
import java.sql.Timestamp;

public class Contact {
    private int id;
    private int userId;
    private String name, phone, subject, messageContent;
    private Timestamp sentAt;
    private int isReplied;
    private String replyContent;

    public Contact(int id, String name, String phone, String subject, String messageContent, Timestamp sentAt, int isReplied) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.subject = subject;
        this.messageContent = messageContent;
        this.sentAt = sentAt;
        this.isReplied = isReplied;
    }

    public Contact(int id, String name, String phone, String subject, String messageContent, Timestamp sentAt, int isReplied, String replyContent) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.subject = subject;
        this.messageContent = messageContent;
        this.sentAt = sentAt;
        this.isReplied = isReplied;
        this.replyContent = replyContent;
    }

    public Contact(int id, int userId, String name, String phone, String subject, String messageContent, Timestamp sentAt, int isReplied) {
        this.id = id;
        this.userId = userId;
        this.name = name;
        this.phone = phone;
        this.subject = subject;
        this.messageContent = messageContent;
        this.sentAt = sentAt;
        this.isReplied = isReplied;
    }

    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getName() { return name; }
    public String getPhone() { return phone; }
    public String getSubject() { return subject; }
    public String getMessageContent() { return messageContent; }
    public Timestamp getSentAt() { return sentAt; }
    public int getIsReplied() { return isReplied; }
    public String getReplyContent() { return replyContent; }
}