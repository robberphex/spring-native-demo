package com.example.demo;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

@RestController
class ExampleController {
    private String currentZone;

    @PostConstruct
    private void init() {
        try {
            HttpClient client = HttpClientBuilder.create().build();
            HttpResponse response = client.execute(new HttpGet("http://myip.ipip.net"));
            currentZone = EntityUtils.toString(response.getEntity());
        } catch (Exception e) {
            e.printStackTrace();
            currentZone = e.getMessage();
        }
    }

    @GetMapping("/b")
    public String a(HttpServletRequest request) {
        //return "B[" + request.getLocalAddr() + "]" + " -> " +
        //    restTemplate.getForObject("http://sc-C/c", String.class);
        return "B[" + request.getLocalAddr() + "]\n";
    }

    @GetMapping("/b-get-zone")
    public String getZone(HttpServletRequest request) {
        return "B[" + currentZone + "]\n";
    }
}
