<?php 
   require 'vendor/autoload.php';
   $app = new Slim\App([
      'settings'=>[
         'displayErrorDetails'=>true
      ]
   ]);
   $container = $app->getContainer();

   $container['db'] = function(){
      return new Mysqli('localhost','root','','magang_ewarung');
   };
   
   // getStokWarung - untuk menampilkan data di produk warung
   $app->get('/api/pdtunas/stok-warung',function($request, $response, $params){
      $id_warung = $_GET['w'];
      $query = $this->db->query("SELECT p.id as product_id, p.product_name as nama_produk, s.stock as sisa_stok FROM stok_warung s INNER JOIN warung w ON w.id = s.warung INNER JOIN products p ON p.id = s.product WHERE s.warung = $id_warung");
      $stocks = $query->fetch_all(MYSQLI_ASSOC);
      return $response->withJson($stocks);
   });

   // getKatalog - untuk menampilkan data di katalog
   $app->get('/api/pdtunas/katalog',function($request,$response, $params){
      if(isset($_GET['id'])){
         $id = $_GET['id'];
         $query = $this->db->query("SELECT p.id as id, p.product_name as nama_produk, c.category as kategori, p.buy_price as harga_beli, p.sell_price as harga_jual, p.stock as stok, p.satuan as satuan, p.is_ready as is_ready, p.photo as photo FROM products p INNER JOIN categories c ON c.id = p.id WHERE p.id = ".$id);
      }else{
         $query = $this->db->query("SELECT p.id as id, p.product_name as nama_produk, c.category as kategori, p.buy_price as harga_beli, p.sell_price as harga_jual, p.stock as stok, p.satuan as satuan, p.is_ready as is_ready, p.photo as photo FROM products p INNER JOIN categories c ON c.id = p.id");
      }
      $products = $query->fetch_all(MYSQLI_ASSOC);
      return $response->withJson($products);
   });
   
   //getNotifikasi - untuk menampilkan data di notifikasi
   $app->get('/api/pdtunas/notifikasi',function($request,$response,$params){
      $id_warung = $_GET['w'];
      $query = $this->db->query("SELECT r.id as id, r.is_stocked as is_stocked, COUNT(s.request) as request,COUNT(s.is_accepted) as is_accepted, DATE_FORMAT(date,'%d %b %Y') as tanggal FROM requests r INNER JOIN stock_request s ON r.id = s.request WHERE r.warung = $id_warung GROUP BY s.request");
      $notif = $query->fetch_all(MYSQLI_ASSOC);
      return $response->withJson($notif);
   });

   // getDetailNotifikasi - untuk menampilkan detail di dalam notifikasi
   $app->get('/api/pdtunas/detail-notifikasi',function($request,$response,$params){
      $req = $_GET['req'];
      $query = $this->db->query("SELECT s.id as id, p.product_name as nama_produk, s.stock as stok, s.is_accepted as is_accepted, s.alasan as alasan FROM stock_request s INNER JOIN products p ON s.product = p.id WHERE s.request = $req");
      $katalog = $query->fetch_all(MYSQLI_ASSOC);
      return $response->withJson($katalog);
   });

   // getKategori - untuk menampilkan seluruh kategori produk
   $app->get('/api/pdtunas/kategori',function($request,$response,$params){
      $query = $this->db->query("SELECT id, category as kategori FROM categories");
      $kategori = $query->fetch_all(MYSQLI_ASSOC);
      return $response->withJson($kategori);
   });

   // getListWarung
   $app->get('/api/pdtunas/warung',function($request,$response,$params){
      $query = $this->db->query("SELECT w.id as id, w.name as nama_warung, COUNT(s.product) as jumlah_produk FROM warung w LEFT JOIN stok_warung s ON w.id = s.warung GROUP BY s.warung");
      $warung = $query->fetch_all(MYSQLI_ASSOC);
      return $response->withJson($warung);
   });

   // getListProdukWarung
   $app->get('/api/pdtunas/produk-warung',function($request,$response,$params){
      $id_warung = $_GET['w'];
      $query = $this->db->query("SELECT p.id as id, p.product_name as nama_produk FROM stok_warung s INNER JOIN products p ON s.product = p.id WHERE s.warung = $id_warung");
      $produkWarung = $query->fetch_all(MYSQLI_ASSOC);
      return $response->withJson($produkWarung);
   });
   
   $app->run();
?>