package com.entity.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "hospitals")
public class Hospital {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String city;

    private String area;
    private String address;
    private String phone;
    private String email;

    private int icuBedsTotal;
    private int icuBedsAvailable;
    private int oxygenBedsTotal;
    private int oxygenBedsAvailable;
    private int generalBedsTotal;
    private int generalBedsAvailable;

    @Column(nullable = false)
    private String status = "Active";

    private LocalDateTime lastUpdated;

    public Hospital() {
        this.lastUpdated = LocalDateTime.now();
    }

    public Hospital(String name, String city, String area, String address, String phone, String email,
                    int icuTotal, int icuAvail, int oxygenTotal, int oxygenAvail, int generalTotal, int generalAvail) {
        this.name = name;
        this.city = city;
        this.area = area;
        this.address = address;
        this.phone = phone;
        this.email = email;
        this.icuBedsTotal = icuTotal;
        this.icuBedsAvailable = icuAvail;
        this.oxygenBedsTotal = oxygenTotal;
        this.oxygenBedsAvailable = oxygenAvail;
        this.generalBedsTotal = generalTotal;
        this.generalBedsAvailable = generalAvail;
        this.lastUpdated = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getArea() { return area; }
    public void setArea(String area) { this.area = area; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public int getIcuBedsTotal() { return icuBedsTotal; }
    public void setIcuBedsTotal(int icuBedsTotal) { this.icuBedsTotal = icuBedsTotal; }

    public int getIcuBedsAvailable() { return icuBedsAvailable; }
    public void setIcuBedsAvailable(int icuBedsAvailable) { this.icuBedsAvailable = icuBedsAvailable; }

    public int getOxygenBedsTotal() { return oxygenBedsTotal; }
    public void setOxygenBedsTotal(int oxygenBedsTotal) { this.oxygenBedsTotal = oxygenBedsTotal; }

    public int getOxygenBedsAvailable() { return oxygenBedsAvailable; }
    public void setOxygenBedsAvailable(int oxygenBedsAvailable) { this.oxygenBedsAvailable = oxygenBedsAvailable; }

    public int getGeneralBedsTotal() { return generalBedsTotal; }
    public void setGeneralBedsTotal(int generalBedsTotal) { this.generalBedsTotal = generalBedsTotal; }

    public int getGeneralBedsAvailable() { return generalBedsAvailable; }
    public void setGeneralBedsAvailable(int generalBedsAvailable) { this.generalBedsAvailable = generalBedsAvailable; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getLastUpdated() { return lastUpdated; }
    public void setLastUpdated(LocalDateTime lastUpdated) { this.lastUpdated = lastUpdated; }

    public int getTotalBedsAvailable() {
        return icuBedsAvailable + oxygenBedsAvailable + generalBedsAvailable;
    }

    public int getTotalBeds() {
        return icuBedsTotal + oxygenBedsTotal + generalBedsTotal;
    }
}
