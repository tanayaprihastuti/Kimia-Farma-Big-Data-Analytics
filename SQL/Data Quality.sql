#Pemeriksaan Kualitas Data

# 1. Ringkasan data transaksi
# Tujuan: mengetahui jumlah transaksi, cabang, dan produk yang tercatat.
SELECT
  COUNT(*) AS total_baris,
  COUNT(DISTINCT transaction_id) AS transaksi_unik,
  COUNT(DISTINCT branch_id) AS jumlah_cabang,
  COUNT(DISTINCT product_id) AS jumlah_produk
FROM kimia_farma.kf_final_transaction;

# 2. Rentang tanggal transaksi
# Tujuan: mengetahui periode data yang tersedia untuk analisis tren.
SELECT
  MIN(date) AS tanggal_awal,
  MAX(date) AS tanggal_akhir
FROM kimia_farma.kf_final_transaction;

# 3. Pemeriksaan ID transaksi
# Tujuan: menemukan ID transaksi yang muncul lebih dari satu kali.
SELECT
  transaction_id,
  COUNT(*) AS jumlah_baris
FROM kimia_farma.kf_final_transaction
WHERE transaction_id IS NOT NULL
GROUP BY transaction_id
HAVING COUNT(*) > 1;

#4. Pemeriksaan data produk
#Tujuan: memastikan ID produk unik dan nama produk tersedia.
SELECT
  COUNT(*) AS total_baris,
  COUNT(DISTINCT product_id) AS produk_unik,
  COUNTIF(product_id IS NULL) AS id_produk_kosong,
  COUNTIF(product_name IS NULL) AS nama_produk_kosong
FROM kimia_farma.kf_product;


#5. Pemeriksaan data kantor cabang
#Tujuan: memastikan ID cabang unik dan informasi wilayah tersedia.
SELECT
  COUNT(*) AS total_baris,
  COUNT(DISTINCT branch_id) AS cabang_unik,
  COUNTIF(branch_id IS NULL) AS id_cabang_kosong,
  COUNTIF(branch_name IS NULL) AS nama_cabang_kosong,
  COUNTIF(provinsi IS NULL) AS provinsi_kosong
FROM kimia_farma.kf_kantor_cabang;

#6. Pemeriksaan kecocokan ID cabang
#Tujuan: memastikan setiap transaksi memiliki ID cabang yang terdaftar pada tabel kantor cabang
SELECT
  COUNT(*) AS transaksi_tanpa_cabang
FROM kimia_farma.kf_final_transaction AS t
LEFT JOIN kimia_farma.kf_kantor_cabang AS c
  ON t.branch_id = c.branch_id
WHERE c.branch_id IS NULL;

#7. Pemeriksaan kecocokan ID produk
#Tujuan: memastikan transaksi memiliki pasangan pada tabel produk.
SELECT
  COUNT(*) AS transaksi_tanpa_produk
FROM kimia_farma.kf_final_transaction AS t
LEFT JOIN kimia_farma.kf_product AS p
  ON t.product_id = p.product_id
WHERE p.product_id IS NULL;

#8. Pemeriksaan catatan inventory
#Tujuan: mengetahui apakah satu kombinasi cabang dan produk memiliki beberapa catatan sebelum tabel inventory digabungkan.
SELECT
  branch_id,
  product_id,
  COUNT(*) AS jumlah_catatan
FROM kimia_farma.kf_inventory
GROUP BY branch_id, product_id
HAVING COUNT(*) > 1
ORDER BY jumlah_catatan DESC;
