package com.amazingfour.crms.domain;

import org.activiti.engine.task.Task;

import java.util.Date;


public class CloudFile {
    private Long fileId;
    private String fileName;
    private String fileUrl;
    private Date fileDate;
    private String fileType;
    private String fileSize;
    private String fileDescript;
    private Byte fileState;
    private Byte shareState;
    private String vframeUrl;
    private String instanceId;
    private String bussinessKey;
    private String label;
    private String tag;
    //临时变量
    private Task task;
    private User user;

    public Long getFileId() {
        return fileId;
    }

    public void setFileId(Long fileId) {
        this.fileId = fileId;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFileUrl() {
        return fileUrl;
    }

    public void setFileUrl(String fileUrl) {
        this.fileUrl = fileUrl;
    }

    public Date getFileDate() {
        return fileDate;
    }

    public String getFileSize() {
        return fileSize;
    }

    public void setFileSize(String fileSize) {
        this.fileSize = fileSize;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public void setFileDate(Date fileDate) {
        this.fileDate = fileDate;
    }

    public String getFileDescript() {
        return fileDescript;
    }

    public void setFileDescript(String fileDescript) {
        this.fileDescript = fileDescript;
    }

    public Byte getFileState() {
        return fileState;
    }

    public void setFileState(Byte fileState) {
        this.fileState = fileState;
    }

    public Byte getShareState() {
        return shareState;
    }

    public void setShareState(Byte shareState) {
        this.shareState = shareState;
    }

    public String getVframeUrl() {
        return vframeUrl;
    }

    public void setVframeUrl(String vframeUrl) {
        this.vframeUrl = vframeUrl;
    }

    public String getInstanceId() {
        return instanceId;
    }

    public void setInstanceId(String instanceId) {
        this.instanceId = instanceId;
    }

    public String getBussinessKey() {
        return bussinessKey;
    }

    public void setBussinessKey(String bussinessKey) {
        this.bussinessKey = bussinessKey;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public Task getTask() {
        return task;
    }

    public void setTask(Task task) {
        this.task = task;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
