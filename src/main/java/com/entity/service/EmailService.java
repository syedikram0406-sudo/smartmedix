package com.entity.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendOTP(String to, String otp) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("syedikram0406@gmail.com");
        message.setTo(to);
        message.setSubject("Your SmartMedix Registration OTP");
        message.setText("Dear User,\n\n" +
                "Your One-Time Password (OTP) for registration is: " + otp + "\n\n" +
                "Please use this code to complete your registration.\n\n" +
                "Regards,\nSmartMedix Team");
        mailSender.send(message);
    }
}
