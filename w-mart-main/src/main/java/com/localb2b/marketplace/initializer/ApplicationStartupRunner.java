package com.localb2b.marketplace.initializer;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class ApplicationStartupRunner implements CommandLineRunner {

    @Override
    public void run(String... args) {

        System.out.println("W-Mart Started Successfully");

    }

}
