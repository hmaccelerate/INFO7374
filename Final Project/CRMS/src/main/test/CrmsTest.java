import com.alibaba.fastjson.JSONObject;
import com.amazingfour.common.utils.StringUtils;
import com.amazingfour.crms.domain.CloudFile;
import com.amazingfour.crms.service.CloudFileService;
import com.amazingfour.crms.service.UserService;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.client.RestTemplate;

import java.io.*;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-context.xml")
public class CrmsTest {

    @Autowired
    private UserService userService;
    @Autowired
    private CloudFileService cloudFileService;

    static Logger logger=Logger.getLogger(CrmsTest.class.getName());
    @Test
    public void testUUid() {
        String uuId = UUID.randomUUID().toString().replace("-", "");
        System.out.println(uuId);
    }



    @Test
    public void testFindByRoleName() {
        String roleName = "firstassessor";
        List<Integer> userIdList = userService.findByRoleName(roleName);
        List<String> idList = new ArrayList<String>();
        for (Integer num : userIdList) {
            idList.add(num.toString());
            System.out.println(num);
        }

    }

    @Test
    public void testFileState() {
        CloudFile cloudFile = new CloudFile();
        cloudFile.setFileId(Long.parseLong("28"));
        String state = "2";
        Byte state2 = Byte.parseByte(state);
        cloudFile.setFileState(state2);
        cloudFileService.update(cloudFile);
    }

    @Test
    public void testLog4j(){
        logger.info("ceshi");
    }




    @Test
    public void testUrltoString() throws IOException {
//        String url ="http://pq2nu4y3t.bkt.clouddn.com/o_1d8ociq5v16t51l1h1a69a6sekp9.doc";
        String url="http://pq2nu4y3t.bkt.clouddn.com/o_1d8u5jiuc9dg1rn85u33nl1p0j9.txt";
//        read the content from url
        URL website = null;
        try {
            website = new URL(url);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        URLConnection connection = website.openConnection();
        InputStreamReader s=new InputStreamReader(
                connection.getInputStream());

        BufferedReader in = new BufferedReader(
                new InputStreamReader(
                        connection.getInputStream()));

        StringBuilder response = new StringBuilder();
        String inputLine;

        while ((inputLine = in.readLine()) != null)
            response.append(inputLine);

        in.close();
        System.out.println(response.toString());
    }

    @Test
    public void testDocumenttoString(){
        String url="http://pq2nu4y3t.bkt.clouddn.com/o_1d8ociq5v16t51l1h1a69a6sekp9.doc";
        String s=StringUtils.documentToString(url);
        JSONObject obj = new JSONObject();
        obj.put("content", s);
        System.out.println(obj.toString());

    }

    @Test
    public void testRestfulAPI(){
        String url="http://pq2nu4y3t.bkt.clouddn.com/o_1d8ociq5v16t51l1h1a69a6sekp9.doc";
        String s=StringUtils.documentToString(url);
        JSONObject obj = new JSONObject();
        obj.put("content", s);
        RestTemplate restTemplate = new RestTemplate();
        String postURL="http://127.0.0.1:5000/nlp/classify";
        URI uri = URI.create(postURL);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<String> entity = new HttpEntity<String>(obj.toString(),headers);
        String ans = restTemplate.postForObject(uri, entity, String.class);
        System.out.println("ans"+ans);

    }

    @Test
    public void testNLP(){

    }


}
