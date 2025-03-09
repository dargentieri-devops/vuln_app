package it.devops.vulnapp;
import org.springframework.data.jpa.repository.JpaRepository;
import it.devops.vulnapp.model.Account;

public interface AccountRepository extends JpaRepository<Account, Long> {
}

