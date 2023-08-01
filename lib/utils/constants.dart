import 'package:flutter/material.dart';
import 'package:marketplace/main.dart';

final String BASE_URL = Config.baseUrl;
final String ADS_KEY = Config.adsKey;

final String API_URL = "$BASE_URL/api/v1";
final String API_ADS_KEY = ADS_KEY;
final String STORAGE_URL = "$BASE_URL/storage";
final String TOOLBOX_URL = "https://v2toolbox.panenpanen.id";
final String IMG_BLANK_URL = "$BASE_URL/images/blank.png";

const WEB_URL_DOMAIN = 'https://panenpanen.id';
const WP_URL_PATH_ID = 'mitra';
const PLAYSTORE =
    "https://play.google.com/store/apps/details?id=com.panenpanen.marketplace";
const INDIBIZ_PAY_URL = "https://mysooltan.co.id/produk/sooltanpay";

/// size in milimeters
const A4_PAPER_SIZE = Size(210, 297);

// For Custom AppBar Title
final String masjid = "Ekomad Masjid";
final String desa = "Ekomad Desa";

final String indibizPay =
    "Indibiz Pay merupakan Aplikasi Usaha yang memiliki berbagai fitur seperti Pembayaran QRIS Gratis yang sudah terintegrasi dengan Bank Indonesia, Top Up & Tagihan untuk tambahan penghasilan dan Produk Toko Aplikasi kasir untuk pencatatan transaksi penjualan tokomu.Dengan sooltanPay UMKM bisa jadi lebih praktis dalam menyediakan alternatif pembayaran, mendapatan tambahan penghasilan & efisiensi operasional bisnis sehari-hari.";
final String indibizWifi =
    "Layanan Internet wifi dedicated untuk kebutuhan bisnis dengan kecepatan mencapai 100 Mbps dan menggunakan 100% Fiber. Wifi Station cocok bagi pelaku bisnis yang berbadan usaha , berbadan hukum atau usaha Mikro yang membutuhkan layanan internet";
final String indibizNet =
    "Penyediaan internet dan layanan komunikasi untuk kebutuhan bisnismu! IndiBiz Net memberikan paket internet cepat dan stabil, mencakup paket TV interaktif (UseeTV) dan telepon dengan harga terjangkau.";

final String others = "";

final String desc_masjid =
    "Aplikasi yang menghubungkan jaringan potensial dengan Masjid sehingga Jamaah dan Masjid dapat saling bertukar informasi dan memudahkan Manajemen Masjid.";

final String desc_desa =
    "Aplikasi untuk membantu digitalisasi administrasi di desa dan memudahkan masyarakat dalam membuat pengaduan ke petugas desa.";
