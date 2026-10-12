#Analisa Peforma Kantor Cabang
#Tujuan: mengidentifikasi cabang dengan rating tertinggi, namun rating transaksi terendah
SELECT
  branch_id,
  branch_name,
  kota,
  provinsi,
  rating_cabang,
  AVG(rating_transaksi) AS rata_rata_rating_transaksi
FROM kimia_farma.tabel_analisa
WHERE rating_cabang IS NOT NULL
  AND rating_transaksi IS NOT NULL
GROUP BY
  branch_id,
  branch_name,
  kota,
  provinsi,
  rating_cabang
ORDER BY
  rating_cabang DESC,
  rata_rata_rating_transaksi ASC
LIMIT 5;