# Catatan Kas Harian

Web statis untuk mencatat pemasukan, pengeluaran, tabungan, dan hutang. Data tersimpan di akun (Supabase), jadi bisa dibuka dari HP dan laptop. Tanpa Supabase, aplikasi tetap jalan tetapi data hanya di browser.

Isi folder:

- `index.html` : seluruh aplikasi
- `config.js` : tempat mengisi URL dan kunci Supabase
- `supabase.sql` : pembuatan tabel dan aturan keamanan
- `manifest.webmanifest`, `icon.svg` : agar bisa dipasang di layar utama HP

## 1. Siapkan Supabase (sekali saja)

1. Daftar di supabase.com, lalu buat proyek baru (paket gratis cukup). Catat kata sandi database-nya.
2. Buka **SQL Editor** > **New query**, tempel isi `supabase.sql`, lalu **Run**.
3. Buka **Authentication**, bagian pengaturan provider **Email**. Untuk pemakaian pribadi, matikan **Confirm email** supaya pendaftaran langsung bisa dipakai tanpa menunggu email konfirmasi. Kalau dibiarkan menyala, pengguna harus mengklik tautan di email dulu.
4. Buka **Project Settings** > **API**. Salin **Project URL** dan kunci **anon / publishable**, lalu tempel ke `config.js`:

```js
window.APP_CONFIG = {
  SUPABASE_URL: "https://xxxxx.supabase.co",
  SUPABASE_ANON_KEY: "eyJ..."
};
```

Kunci anon aman berada di file ini karena data dilindungi aturan keamanan per pengguna. Jangan memakai kunci `service_role`.

## 2. Coba di komputer

Buka `index.html` langsung di browser. Daftar dengan email dan kata sandi (minimal 6 karakter), lalu catat satu entri dan muat ulang halaman. Datanya harus tetap ada.

## 3. Publikasikan ke Vercel

Cara paling mudah lewat GitHub:

1. Buat repositori baru di GitHub dan unggah semua file di folder ini.
2. Di vercel.com pilih **Add New** > **Project**, impor repositori tadi, lalu **Deploy**. Tidak perlu pengaturan build karena ini situs statis.
3. Anda mendapat alamat seperti `nama-proyek.vercel.app`.

Atau lewat terminal, dari dalam folder ini: `npx vercel --prod`.

## 4. Setelah punya alamat Vercel

Di Supabase buka **Authentication** > **URL Configuration**, lalu isi **Site URL** dengan alamat Vercel Anda. Ini dipakai oleh tautan "Lupa kata sandi" di email.

## 5. Pasang di HP

Buka alamat Vercel di HP, masuk, lalu:

- Android (Chrome): menu titik tiga > **Tambahkan ke layar utama**.
- iPhone (Safari): tombol bagikan > **Tambah ke Layar Utama**.

## Hal yang perlu diketahui

- Data tersimpan sebagai satu catatan per akun. Kalau Anda mengubah data di dua perangkat bersamaan, perubahan yang disimpan terakhir yang dipakai. Halaman otomatis memuat data terbaru saat Anda kembali membukanya, jadi pakai satu perangkat dalam satu waktu.
- Proyek Supabase gratis akan dijeda bila tidak dipakai sekitar seminggu. Data tidak hilang, tinggal diaktifkan lagi dari dashboard.
- Anda bisa mengganti isi `index.html` lewat GitHub kapan saja, dan Vercel akan memperbarui situsnya otomatis.
