package com.portwise.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.Map;

@RestController
public class HomeController {

    @GetMapping({"/", "/api/v1"})
    public ResponseEntity<Map<String, Object>> root() {
        Map<String, Object> resp = new LinkedHashMap<>();
        resp.put("application", "PORTWISE — Integrated Port Logistics Management System API");
        resp.put("status", "UP");
        resp.put("version", "1.0.0");
        resp.put("swaggerUi", "/swagger-ui/index.html");
        resp.put("apiDocs", "/api-docs");
        resp.put("health", "/actuator/health");
        return ResponseEntity.ok(resp);
    }
}
