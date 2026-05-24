CREATE TABLE Yonetmen (
    yonetmen_id NUMBER PRIMARY KEY,
    ad VARCHAR2(50) NOT NULL,
    soyad VARCHAR2(50) NOT NULL,
    dogum_tarihi DATE NOT NULL,
    ulke VARCHAR2(50) NOT NULL
);

CREATE TABLE Film (
    film_id NUMBER PRIMARY KEY,
    film_adi VARCHAR2(150) NOT NULL,
    cikis_yili NUMBER NOT NULL,
    sure NUMBER NOT NULL,
    yonetmen_id NUMBER NOT NULL,
    FOREIGN KEY (yonetmen_id) REFERENCES Yonetmen(yonetmen_id)
);

CREATE TABLE Tur (
    tur_id NUMBER PRIMARY KEY,
    tur_adi VARCHAR2(50) NOT NULL
);

CREATE TABLE Oyuncu (
    oyuncu_id NUMBER PRIMARY KEY,
    ad VARCHAR2(50) NOT NULL,
    soyad VARCHAR2(50) NOT NULL,
    dogum_tarihi DATE NOT NULL,
    ulke VARCHAR2(50) NOT NULL
);

CREATE TABLE Kullanici (
    kullanici_id NUMBER PRIMARY KEY,
    ad VARCHAR2(50) NOT NULL,
    soyad VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    sifre VARCHAR2(50) NOT NULL
);

CREATE TABLE Degerlendirme (
    degerlendirme_id NUMBER PRIMARY KEY,
    kullanici_id NUMBER NOT NULL,
    film_id NUMBER NOT NULL,
    puan NUMBER NOT NULL,
    CONSTRAINT fk_deg_kullanici
        FOREIGN KEY (kullanici_id) REFERENCES Kullanici(kullanici_id),
    CONSTRAINT fk_deg_film
        FOREIGN KEY (film_id) REFERENCES Film(film_id),
    CONSTRAINT chk_deg_puan
        CHECK (puan BETWEEN 1 AND 10),
    CONSTRAINT unq_deg_kullanici_film
        UNIQUE (kullanici_id, film_id)
);

CREATE TABLE Film_Tur (
    film_id NUMBER NOT NULL,
    tur_id NUMBER NOT NULL,
    PRIMARY KEY (film_id, tur_id),
    CONSTRAINT fk_filmtur_film
        FOREIGN KEY (film_id) REFERENCES Film(film_id),
    CONSTRAINT fk_filmtur_tur
        FOREIGN KEY (tur_id) REFERENCES Tur(tur_id)
);

CREATE TABLE Film_Oyuncu (
    film_id NUMBER NOT NULL,
    oyuncu_id NUMBER NOT NULL,
    PRIMARY KEY (film_id, oyuncu_id),
    CONSTRAINT fk_filmoyuncu_film
        FOREIGN KEY (film_id) REFERENCES Film(film_id),
    CONSTRAINT fk_filmoyuncu_oyuncu
        FOREIGN KEY (oyuncu_id) REFERENCES Oyuncu(oyuncu_id)
);

