#Pembuatan Tabel Analisis

CREATE OR REPLACE TABLE kimia_farma.tabel_analisa AS

WITH data_lengkap AS (
  SELECT
    t.transaction_id,
    t.date,
    t.branch_id,
    c.branch_name,
    c.kota,
    c.provinsi,
    c.rating AS rating_cabang,
    t.customer_name,
    t.product_id,
    p.product_name,
    t.price AS actual_price,
    t.discount_percentage,

    CASE
      WHEN t.price <= 50000 THEN 0.10
      WHEN t.price <= 100000 THEN 0.15
      WHEN t.price <= 300000 THEN 0.20
      WHEN t.price <= 500000 THEN 0.25
      ELSE 0.30
    END AS persentase_gross_laba,

    t.rating AS rating_transaksi

  FROM kimia_farma.kf_final_transaction AS t
  LEFT JOIN kimia_farma.kf_kantor_cabang AS c
    ON t.branch_id = c.branch_id
  LEFT JOIN kimia_farma.kf_product AS p
    ON t.product_id = p.product_id
)

SELECT
  transaction_id,
  date,
  EXTRACT(YEAR FROM date) AS year,
  EXTRACT(MONTH FROM date) AS month,
  branch_id,
  branch_name,
  kota,
  provinsi,
  rating_cabang,
  customer_name,
  product_id,
  product_name,
  actual_price,
  discount_percentage,
  persentase_gross_laba,
  actual_price * (1 - discount_percentage) AS nett_sales,
  actual_price
    * (1 - discount_percentage)
    * persentase_gross_laba AS nett_profit,
  rating_transaksi
FROM data_lengkap;

#Memeriksa jumlah baris dan id transaksi unik setelah penggabungan.
SELECT
  COUNT(*) AS jumlah_baris_analisis,
  COUNT(DISTINCT transaction_id) AS jumlah_transaksi_unik
FROM kimia_farma.tabel_analisa;

#Memeriksa kelengkapan kolom penting setelah penggabungan.
SELECT
  COUNTIF(date IS NULL) AS tanggal_kosong,
  COUNTIF(branch_name IS NULL) AS nama_cabang_kosong,
  COUNTIF(provinsi IS NULL) AS provinsi_kosong,
  COUNTIF(product_name IS NULL) AS nama_produk_kosong,
  COUNTIF(nett_sales IS NULL) AS nett_sales_kosong,
  COUNTIF(nett_profit IS NULL) AS nett_profit_kosong
FROM kimia_farma.tabel_analisa;
