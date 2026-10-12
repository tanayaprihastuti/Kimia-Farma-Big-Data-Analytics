#Analisa Peforma Provinsi

#Top 10 provinsi berdasarkan jumlah transaksi.
SELECT
  provinsi,
  COUNT(DISTINCT transaction_id) AS total_transaksi,
  SUM(nett_sales) AS total_nett_sales,
  SUM(nett_profit) AS total_nett_profit
FROM kimia_farma.tabel_analisa
WHERE provinsi IS NOT NULL
GROUP BY provinsi
ORDER BY total_transaksi DESC
LIMIT 10;

#Top 10 Peringkat provinsi berdasarkan nett sales.
SELECT
  provinsi,
  COUNT(DISTINCT transaction_id) AS total_transaksi,
  SUM(nett_sales) AS total_nett_sales,
  SUM(nett_profit) AS total_nett_profit
FROM kimia_farma.tabel_analisa
WHERE provinsi IS NOT NULL
GROUP BY provinsi
ORDER BY total_nett_sales DESC
LIMIT 10;

#Top 10 cabang dengan transaksi terbanyak beserta provinsinya.
SELECT
  branch_id,
  branch_name,
  kota,
  provinsi,
  COUNT(DISTINCT transaction_id) AS total_transaksi,
  SUM(nett_sales) AS total_nett_sales,
  SUM(nett_profit) AS total_nett_profit
FROM kimia_farma.tabel_analisa
WHERE branch_id IS NOT NULL
GROUP BY
  branch_id,
  branch_name,
  kota,
  provinsi
ORDER BY total_transaksi DESC
LIMIT 10;

#Top 10 cabang dengan nett sales terbesar beserta provinsinya.
SELECT
  branch_id,
  branch_name,
  kota,
  provinsi,
  COUNT(DISTINCT transaction_id) AS total_transaksi,
  SUM(nett_sales) AS total_nett_sales,
  SUM(nett_profit) AS total_nett_profit
FROM kimia_farma.tabel_analisa
WHERE branch_id IS NOT NULL
GROUP BY
  branch_id,
  branch_name,
  kota,
  provinsi
ORDER BY total_nett_sales DESC
LIMIT 10;