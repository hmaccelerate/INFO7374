package com.amazingfour.common.utils;

import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;

import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;


public class StringUtils {
    public static boolean isEmpty(String text) {
        return text == null || text.trim().equals("") ? true : false;
    }

    public static String documentToString(String url){
        String content=null;
        try {

            URL website = null;
            try {
                website = new URL(url);
            } catch (MalformedURLException e) {
                e.printStackTrace();
            }
            URLConnection connection = website.openConnection();
            XWPFDocument xdoc = new XWPFDocument(OPCPackage.open(connection.getInputStream()));
            XWPFWordExtractor extractor = new XWPFWordExtractor(xdoc);
             content = extractor.getText();
            System.out.println(extractor.getText());
        } catch(Exception ex) {
            ex.printStackTrace();
        }
        return content;

    }



}

