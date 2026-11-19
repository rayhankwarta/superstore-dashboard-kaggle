# 📊 Analisis Penjualan & Kebocoran Profit Ritel (Superstore End-to-End BI Project)

![Tools](https://img.shields.io/badge/Python-Pandas-blue?logo=python&logoColor=white)
![Database](https://img.shields.io/badge/PostgreSQL-pgAdmin_4-336791?logo=postgresql&logoColor=white)
![BI Tool](https://img.shields.io/badge/Power_BI-DAX_%26_Star_Schema-F2C811?logo=powerbi&logoColor=black)

## 📌 Latar Belakang & Masalah Bisnis
Selama periode 2014 hingga 2017, Superstore mencatatkan total penjualan sebesar **$2,30 juta** dari **5.009 pesanan unik**, dengan total laba bersih **$286,41 ribu** (**margin profit 12,47%**). Meskipun tren pendapatan terlihat tumbuh dan selalu melonjak menjelang akhir tahun, terdapat masalah serius di balik angka tersebut: **18,71% dari seluruh transaksi (1.870 item pesanan) justru mengalami kerugian**, yang menyebabkan kebocoran laba (*profit leakage*) sebesar **$156,12 ribu**.

**Tujuan Proyek:**  
Proyek ini dibangun untuk mensimulasikan alur kerja *Business Intelligence Analyst* secara menyeluruh (*end-to-end*)—mulai dari audit kualitas data mentah, pemodelan kueri analitik di PostgreSQL, hingga perancangan *dashboard* interaktif di Power BI. Fokus utamanya adalah menemukan akar penyebab kerugian, mengevaluasi batas aman pemberian diskon, dan merumuskan rekomendasi bisnis yang dapat langsung dieksekusi oleh manajemen.

---

## 🛠️ Alur Kerja & Tech Stack yang Digunakan

```text
[Data Mentah CSV (9.994 baris)] 
       │
       ▼  1. Audit Data, Pembersihan & Feature Engineering (Python / Pandas)
[Data Bersih CSV (9.993 baris)] 
       │
       ▼  2. Penyimpanan Relasional & Kueri Analitik (PostgreSQL / pgAdmin 4)
[Data Mart & Segmentasi Pelanggan RFM] 
       │
       ▼  3. Pemodelan Star Schema, DAX Measures & Visualisasi (Power BI Desktop)
[Dashboard Interaktif 2 Halaman: Executive Overview & Profit Leakage]
