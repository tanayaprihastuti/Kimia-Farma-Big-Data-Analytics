#Analisa peforma produk

#Top 10 produk berdasarkan nett profit terbesar
SELECT
  product_id,
  product_name,
  COUNT(DISTINCT transaction_id) AS total_transaksi,
  SUM(nett_sales) AS total_nett_sales,
  SUM(nett_profit) AS total_nett_profit
FROM kimia_farma.tabel_analisa
WHERE product_id IS NOT NULL
GROUP BY
  product_id,
  product_name
ORDER BY total_nett_profit DESC
LIMIT 10;
