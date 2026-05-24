-- 1. Tüm filmleri yönetmen bilgileriyle listeleme
SELECT 
    f.film_id,
    f.film_adi,
    f.cikis_yili,
    f.sure,
    y.ad || ' ' || y.soyad AS yonetmen
FROM Film f
JOIN Yonetmen y ON f.yonetmen_id = y.yonetmen_id
ORDER BY f.cikis_yili DESC;


-- 2. Filmleri türleriyle birlikte listeleme
SELECT 
    f.film_adi,
    f.cikis_yili,
    f.sure,
    t.tur_adi
FROM Film f
JOIN Film_Tur ft ON f.film_id = ft.film_id
JOIN Tur t ON ft.tur_id = t.tur_id
ORDER BY f.film_adi;


-- 3. Filmlerin ortalama puanlarını listeleme
SELECT 
    f.film_adi,
    ROUND(AVG(d.puan), 2) AS ortalama_puan
FROM Film f
JOIN Degerlendirme d ON f.film_id = d.film_id
GROUP BY f.film_adi
ORDER BY ortalama_puan DESC;


-- 4. Ortalama puanı 8 ve üzeri olan filmler
SELECT 
    f.film_adi,
    ROUND(AVG(d.puan), 2) AS ortalama_puan
FROM Film f
JOIN Degerlendirme d ON f.film_id = d.film_id
GROUP BY f.film_adi
HAVING AVG(d.puan) >= 8
ORDER BY ortalama_puan DESC;


-- 5. Aksiyon türündeki filmleri listeleme
SELECT 
    f.film_adi,
    f.cikis_yili,
    f.sure,
    t.tur_adi
FROM Film f
JOIN Film_Tur ft ON f.film_id = ft.film_id
JOIN Tur t ON ft.tur_id = t.tur_id
WHERE t.tur_adi = 'Aksiyon'
ORDER BY f.cikis_yili DESC;


-- 6. 2000 ile 2020 arasında çıkan, süresi 90-120 dakika olan filmler
SELECT 
    f.film_adi,
    f.cikis_yili,
    f.sure
FROM Film f
WHERE f.cikis_yili BETWEEN 2000 AND 2020
  AND f.sure BETWEEN 90 AND 120
ORDER BY f.cikis_yili;


-- 7. Oyuncuların oynadığı filmleri listeleme
SELECT 
    o.ad || ' ' || o.soyad AS oyuncu,
    f.film_adi
FROM Oyuncu o
JOIN Film_Oyuncu fo ON o.oyuncu_id = fo.oyuncu_id
JOIN Film f ON fo.film_id = f.film_id
ORDER BY oyuncu;


-- 8. Her yönetmenin kaç film yönettiğini listeleme
SELECT 
    y.ad || ' ' || y.soyad AS yonetmen,
    COUNT(f.film_id) AS film_sayisi
FROM Yonetmen y
JOIN Film f ON y.yonetmen_id = f.yonetmen_id
GROUP BY y.ad, y.soyad
ORDER BY film_sayisi DESC;


-- 9. En uzun 10 filmi listeleme
SELECT 
    film_adi,
    cikis_yili,
    sure
FROM Film
ORDER BY sure DESC
FETCH FIRST 10 ROWS ONLY;


-- 10. Kullanıcıların verdiği puanları film adıyla listeleme
SELECT 
    k.ad || ' ' || k.soyad AS kullanici,
    f.film_adi,
    d.puan
FROM Kullanici k
JOIN Degerlendirme d ON k.kullanici_id = d.kullanici_id
JOIN Film f ON d.film_id = f.film_id
ORDER BY d.puan DESC;


-- 11. Her türde kaç film olduğunu listeleme
SELECT 
    t.tur_adi,
    COUNT(f.film_id) AS film_sayisi
FROM Tur t
JOIN Film_Tur ft ON t.tur_id = ft.tur_id
JOIN Film f ON ft.film_id = f.film_id
GROUP BY t.tur_adi
ORDER BY film_sayisi DESC;


-- 12. Ortalama puanı genel ortalamanın üzerinde olan filmler
SELECT 
    f.film_adi,
    ROUND(AVG(d.puan), 2) AS ortalama_puan
FROM Film f
JOIN Degerlendirme d ON f.film_id = d.film_id
GROUP BY f.film_adi
HAVING AVG(d.puan) > (
    SELECT AVG(puan)
    FROM Degerlendirme
)
ORDER BY ortalama_puan DESC;


-- 13. Hiç değerlendirme almayan filmleri listeleme
SELECT 
    f.film_adi,
    f.cikis_yili
FROM Film f
LEFT JOIN Degerlendirme d ON f.film_id = d.film_id
WHERE d.degerlendirme_id IS NULL;


-- 14. Christopher Nolan filmlerini listeleme
SELECT 
    f.film_adi,
    f.cikis_yili,
    f.sure
FROM Film f
JOIN Yonetmen y ON f.yonetmen_id = y.yonetmen_id
WHERE y.ad = 'Christopher'
  AND y.soyad = 'Nolan'
ORDER BY f.cikis_yili;


-- 15. Film, tür, yönetmen ve ortalama puan bilgilerini birlikte listeleme
SELECT 
    f.film_adi,
    f.cikis_yili,
    f.sure,
    y.ad || ' ' || y.soyad AS yonetmen,
    t.tur_adi,
    ROUND(AVG(d.puan), 2) AS ortalama_puan
FROM Film f
JOIN Yonetmen y ON f.yonetmen_id = y.yonetmen_id
JOIN Film_Tur ft ON f.film_id = ft.film_id
JOIN Tur t ON ft.tur_id = t.tur_id
LEFT JOIN Degerlendirme d ON f.film_id = d.film_id
GROUP BY 
    f.film_adi,
    f.cikis_yili,
    f.sure,
    y.ad,
    y.soyad,
    t.tur_adi
ORDER BY ortalama_puan DESC;