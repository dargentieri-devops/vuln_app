package it.devops.vulnapp;



import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import it.devops.vulnapp.model.Account;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.util.List;


@RestController
public class Controller {
    private static final String DB_PASSWORD = "SuperSecret123"; // Hardcoded password

    private final AccountRepository accountRepository;

    public Controller(AccountRepository accountRepository) {
        this.accountRepository = accountRepository;
    }

    @GetMapping("/name")
    public ResponseEntity<String> getAppName() {
        return ResponseEntity.ok(this.DB_PASSWORD);
    }

    @GetMapping("/accounts")
    public String getUsers() {
        System.out.println("sono entrato");
        List<Account> accounts = accountRepository.findAll();
        Gson gson = new Gson();
        return gson.toJson(accounts);
    }
}
