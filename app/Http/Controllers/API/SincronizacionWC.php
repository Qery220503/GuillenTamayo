<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use PDOException;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Automattic\WooCommerce\Client;
use App\Models\Productos;
use Facade\FlareClient\Http\Response as HttpResponse;
use Illuminate\Support\Arr;

class SincronizacionWC extends Controller
{
  // Sincronizar productos de WooCommerce

  public function testfnc()
  {
    echo "it works";
  }

  public function index()
  {

    // Obtiene productos de la Base de datos en Laragon
    // Estado para eliminación
    $datos = Productos::with('marca')->where("estado", 1)->get();

    //dd($datos);

    $woocommerce = new Client(
      'https://guillentamayo.com/tienda2',
      'ck_5ce8b3bd0f70e55db591fea3533e9dde2144cbda',
      'cs_689555e727f789e3bea778294139b9aece970787',
      [
        'wp_api' => true,
        'version' => 'wc/v3',
      ]
    );
    // Obtiene productos de WooCommerce
    //$consulta = $woocommerce->get( 'products', array('per_page'=>5) );
    // dd($consulta);

    // Del sistema a WC
    // Crear productos en sistema y pasarlos a WC
    // Pendiente upd 1-> hasta que el producto se sincronice
    $productos = Productos::with('marca')->where("pendiente_upd", 1)->get();
    //dd($productos);

    foreach ($productos as $p) {
      // echo "<p>".json_encode($p)."</p>";

      $params = [
        'sku' => trim($p->codigo_producto)
      ];

      $params = Arr::add($params, 'sku', $params);

      // echo "<p>".$params."</p>";
      // $val = Arr::get($params, 'sku');
      // echo $val;

      //dd($params);

      $validar = $woocommerce->get('products', $params);

      // no imprime nada si no hay productos con esos sku en WC
      // echo Arr::get($validar, 'sku');

      $categorias_arr = [];

      $genero = trim(strtoupper(strtolower($p->genero)));
      $categoria = trim(strtoupper(strtolower($p->id_categoria)));
      $material = trim(strtoupper(strtolower($p->id_material)));

      $marca = ($p->marca['sincronizar'] == 1) ? trim(strtoupper(strtolower($p->id_marca))) : 'OTROS';
      //$marca = trim(strtoupper(strtolower($p->id_marca)));
      $aro = trim(strtoupper(strtolower($p->id_tipo_aro)));

      $c_genero = $this->getCategoria($genero);
      $c_categoria = $this->getCategoria($categoria);
      $c_material = $this->getCategoria($material);
      $c_marca = $this->getCategoria($marca);
      $c_aro = $this->getCategoria($aro);

      $t_genero = ['id' => $this->getEtiqueta($genero),];
      $t_categoria = ['id' => $this->getEtiqueta($categoria),];
      $t_material = ['id' => $this->getEtiqueta($material),];
      $t_marca = ['id' => $this->getEtiqueta($marca),];
      $t_aro = ['id' => $this->getEtiqueta($aro),];

      if ($c_genero) {
        $categorias_arr[] = array("id" => $c_genero);
      } elseif ($c_categoria) {
        $categorias_arr[] = array("id" => $c_categoria);
      } elseif ($c_material) {
        $categorias_arr[] = array("id" => $c_material);
      } elseif ($c_marca) {
        $categorias_arr[] = array("id" => $c_marca);
      } elseif ($c_aro) {
        $categorias_arr[] = array("id" => $c_aro);
      }

      if ($p->producto_reto == 1) {
        $categorias_arr[] = array("id" => 168);
        $reto_tag = ['id' => 1195,];
      } else {
        $reto_tag = ['id' => 0,];
      }

      if ($validar == null) {
        $arr_productos = array(
          "type" => "simple",
          "name" => $p->nombre_producto,
          "description" => $p->codigo_producto,
          "sku" => $p->codigo_producto,
          "regular_price" => $p->precio_venta,
          "manage_stock" => True,
          "stock_quantity" => $p->stock,
          "has_variations" => 0,
          "categories" => $categorias_arr,
          "short_description" => '<img class="alignnone wp-image-6535" src="https://guillentamayo.com/tienda/wp-content/uploads/2020/12/medidas-monturas-02-300x94-1.png" alt="" width="102" height="32" />  Diagonal aro: '
            . $p->diagonal .
            '
                    <img class="alignnone wp-image-6537" src="https://guillentamayo.com/tienda/wp-content/uploads/2020/12/medidas-monturas-03-1-300x110-1.png" alt="" width="101" height="37" />  Puente: '
            . $p->puente .
            '
                    <img class="alignnone wp-image-6534" src="https://guillentamayo.com/tienda/wp-content/uploads/2020/12/medidas-monturas-01-300x97-1.png" alt="" width="102" height="33" />  Largo varilla: '
            . $p->varilla . '',
          "tags" => [$t_genero, $t_categoria, $t_material, $t_marca, $reto_tag, $t_aro,],
        );

        $wc_product = $woocommerce->post('products', $arr_productos);

        // print_r($wc_product);

        if (isset($wc_product->id)) {
          try {
            $producto = Productos::findOrFail($p->id_producto);
            $producto->update(["pendiente_upd" => 0]);
            return response()->json($producto, 200);
          } catch (PDOException $e) {
            return response()->json($e->getMessage(), 500);
          }
        }
      } else {
        $data = [
          'regular_price' => $p->precio_venta,
          'stock_quantity' => $p->stock,
          'categories' => $categorias_arr,
          "tags" => [$t_genero, $t_categoria, $t_material, $t_marca, $reto_tag, $t_aro,],
        ];

        $wc_update = $woocommerce->put('products/' . $validar[0]->id, $data);
        if (isset($wc_update->id)) {
          try {
            $producto = Productos::findOrFail($p->id_producto);
            $producto->update(["pendiente_upd" => 0]);
            return response()->json($producto, 200);
          } catch (PDOException $e) {
            return response()->json($e->getMessage(), 500);
          }
        }
      }
    }
  }

  public function sincUniqueProd($id)
  {

    $auth = auth('sanctum')->user();

    // Obtiene productos de la Base de datos en Laragon
    // Estado para eliminación
    $datos = Productos::with('marca')->where("id_producto", $id)->get();

    $woocommerce = new Client(
      'https://guillentamayo.com/tienda2',
      'ck_5ce8b3bd0f70e55db591fea3533e9dde2144cbda',
      'cs_689555e727f789e3bea778294139b9aece970787',
      [
        'wp_api' => true,
        'version' => 'wc/v3',
      ]
    );

    $datos->toArray();

    $pendiente_upd_status = $datos[0]->pendiente_upd;

    // sin pendiente_upd


    /* $sku = $datos[0]->codigo_producto;
        print_r($sku);

        $validar = $woocommerce->get('product', $sku); */

    $params = [
      'sku' => trim($datos[0]->codigo_producto)
    ];

    $params = Arr::add($params, 'sku', $params);

    // echo "<p>".$params."</p>";
    // $val = Arr::get($params, 'sku');
    // echo $val;

    $validar = $woocommerce->get('products', $params);

    $categorias_arr = [];

    $genero = trim(strtoupper(strtolower($datos[0]->genero)));
    $categoria = trim(strtoupper(strtolower($datos[0]->id_categoria)));
    $material = trim(strtoupper(strtolower($datos[0]->id_material)));
    $marca = trim(strtoupper(strtolower($datos[0]->id_marca)));
    $aro = trim(strtoupper(strtolower($datos[0]->id_tipo_aro)));

    $c_genero = $this->getCategoria($genero);
    $c_categoria = $this->getCategoria($categoria);
    $c_material = $this->getCategoria($material);
    $c_marca = $this->getCategoria($marca);
    $c_aro = $this->getCategoria($aro);

    $t_genero = ['id' => $this->getEtiqueta($genero),];
    $t_categoria = ['id' => $this->getEtiqueta($categoria),];
    $t_material = ['id' => $this->getEtiqueta($material),];
    $t_marca = ['id' => $this->getEtiqueta($marca),];
    $t_aro = ['id' => $this->getEtiqueta($aro),];

    if ($c_genero) {
      $categorias_arr[] = array("id" => $c_genero);
    } elseif ($c_categoria) {
      $categorias_arr[] = array("id" => $c_categoria);
    } elseif ($c_material) {
      $categorias_arr[] = array("id" => $c_material);
    } elseif ($c_marca) {
      $categorias_arr[] = array("id" => $c_marca);
    } elseif ($c_aro) {
      $categorias_arr[] = array("id" => $c_aro);
    }

    if ($datos[0]->producto_reto == 1) {
      $categorias_arr[] = array("id" => 168);
      $reto_tag = ['id' => 1195,];
    } else {
      $reto_tag = ['id' => 0,];
    }

    if ($validar == null) {
      $arr_productos = array(
        "type" => "simple",
        "name" => $datos[0]->nombre_producto,
        "description" => $datos[0]->codigo_producto,
        "sku" => $datos[0]->codigo_producto,
        "regular_price" => $datos[0]->precio_venta,
        "manage_stock" => True,
        "stock_quantity" => $datos[0]->stock,
        "has_variations" => 0,
        "categories" => $categorias_arr,
        "short_description" => '<img class="alignnone wp-image-6535" src="https://guillentamayo.com/tienda/wp-content/uploads/2020/12/medidas-monturas-02-300x94-1.png" alt="" width="102" height="32" />  Diagonal aro: '
          . $datos[0]->diagonal .
          '
                <img class="alignnone wp-image-6537" src="https://guillentamayo.com/tienda/wp-content/uploads/2020/12/medidas-monturas-03-1-300x110-1.png" alt="" width="101" height="37" />  Puente: '
          . $datos[0]->puente .
          '
                <img class="alignnone wp-image-6534" src="https://guillentamayo.com/tienda/wp-content/uploads/2020/12/medidas-monturas-01-300x97-1.png" alt="" width="102" height="33" />  Largo varilla: '
          . $datos[0]->varilla . '',
        "tags" => [$t_genero, $t_categoria, $t_material, $t_marca, $reto_tag, $t_aro,],
      );

      $wc_product = $woocommerce->post('products', $arr_productos);

      // print_r($wc_product);

      if (isset($wc_product->id)) {
        try {
          $producto = Productos::findOrFail($datos[0]->id_producto);
          $producto->update(["pendiente_upd" => 0]);
          return response()->json($producto, 200);
        } catch (PDOException $e) {
          return response()->json($e->getMessage(), 500);
        }
      } else {
        return response()->json("Error", 500);
      }
    } else {
      $data = [
        'regular_price' => $datos[0]->precio_venta,
        'stock_quantity' => $datos[0]->stock,
        'categories' => $categorias_arr,
        "tags" => [$t_genero, $t_categoria, $t_material, $t_marca, $reto_tag, $t_aro,],
      ];

      $wc_update = $woocommerce->put('products/' . $validar[0]->id, $data);
      if (isset($wc_update->id)) {
        try {
          $producto = Productos::findOrFail($datos[0]->id_producto);
          $producto->update(["pendiente_upd" => 0]);
          return response()->json($producto, 200);
        } catch (PDOException $e) {
          return response()->json($e->getMessage(), 500);
        }
      }
    }
  }

  private function getCategoria($nombre)
  {
    $categorias = array(
      "MONTURA DE SEGURIDAD" => 1251,
      "MONTURA DEPORTIVA" => 1206,
      "MONTURA OFTALMICA" => 1173,
      "MONTURA DALTONISMO" => 1269,
      "MONTURA GLAUCOMA" => 1256,
      "MONTURA SOLAR" => 1203,
      "OFERTAS DEL MES" => 1193,
      "NIÑO" => 1177,
      "NIÑA" => 1161,
      "VARÓN" => 1182,
      "VARON" => 1182,
      "DAMA" => 1211,
      "UNISEX" => 1245,
      "ARO COMPLETO" => 1157,
      "AL AIRE" => 1179,
      "SEMI AL AIRE" => 1197,
      "PLAQUETAS" => 1415,
      "SOBRELENTES" => 1416,
      "ALARGADO" => 1417,
      "CUADRADO" => 1418,
      "OVALADO" => 1419,
      "REDONDO" => 1420,
      "TRIANGULAR" => 1421,
      "ESPEJADO" => 1422,
      "POLARIZADO" => 1208,
      "ACTIVA" => 1282,
      "ACTIVE" => 1188,
      "ACTUAL" => 1214,
      "ADIDAS" => 1222,
      "AIR MAG" => 1252,
      "ALPI" => 1229,
      "ANGELINA BONDONE" => 1232,
      "ARGOS" => 1248,
      "ARNETTE" => 1227,
      "BELLAGIO" => 1196,
      "BELLUNO" => 1192,
      "BRUCKEN" => 1244,
      "CALVIN KLEIN" => 1263,
      "CANDIES" => 1218,
      "CAROLINA HERRERA" => 1254,
      "CARRERA" => 1230,
      "CATERPILLAR" => 1219,
      "CENTRO STYLE" => 1191,
      "CONVERSE" => 1221,
      "DONNA KARAN" => 1250,
      "DRAGON" => 1260,
      "CHUFANG" => 1296,
      "EMPORIO ARMANI" => 1216,
      "EUROPTICS" => 1235,
      "EXPRESS" => 1238,
      "EZZIO BRAZZINI" => 1265,
      "FERRETTI" => 1237,
      "GANT" => 1286,
      "GIORDI" => 1283,
      "GO FLEX" => 1240,
      "GUESS" => 1233,
      "HELLO KITTY" => 1171,
      "HENKO" => 1274,
      "HUGO BOSS" => 1239,
      "KENZIA" => 1264,
      "LAPO" => 1271,
      "LEVENT KIDS" => 1275,
      "MISSONI" => 1276,
      "MIYAGI EYEWEAR" => 1236,
      "MONDI" => 1241,
      "MOSCHINO" => 1279,
      "NANO VISTA" => 1159,
      "NAUTICA" => 1225,
      "NEW YORK" => 1176,
      "NIKE" => 1259,
      "NINE WEST" => 1262,
      "OAKLEY" => 1284,
      "OPAL" => 1242,
      "OSIRIS" => 1243,
      "PENTAX" => 1267,
      "PIERRE CARDIN" => 1231,
      "POLAROID" => 1207,
      "PUMA" => 1234,
      "PV OPTICS" => 1281,
      "QUALITY" => 1247,
      "QUEST" => 1261,
      "RAY BAN" => 1201,
      "REEBOK" => 1249,
      "SMART" => 1266,
      "ROXY" => 1212,
      "SPY" => 1277,
      "SPOLETO" => 1220,
      "SWAROSKI" => 1287,
      "TATTOO" => 1181,
      "TONY HAWK" => 1414,
      "URBAN CHAOS" => 1190,
      "VALENTINA FERRUCCI" => 1246,
      "ANDRE MORETI" => 1413,
      "DRWN" => 1401,
      "JOHNSON & JOHNSON" => 1402,
      "KENETH COLE" => 1403,
      "LACOSTE" => 1404,
      "LIZEMBLEM" => 1405,
      "LUCKY BRAND" => 1406,
      "MYTHO" => 1407,
      "Pepe Jeans" => 1408,
      "POLAR SPORTS" => 1409,
      "PV TM" => 1410,
      "TOMMY HILFIGER" => 1411,
      "TOYOKA SEGURIDAD" => 1412,
      "VORTEX" => 1291,
      "XOX" => 1290
    );

    if (array_key_exists($nombre, $categorias)) {
      return $categorias[$nombre];
    } else {
      return false;
    }
  }

  private function getEtiqueta($etiqueta)
  {
    $tags_ids = array(
      "MONTURA DE SEGURIDAD" => 1268,
      "MONTURA DEPORTIVA" => 1209,
      "MONTURA OFTALMICA" => 1164,
      "MONTURA DALTONISMO" => 1270,
      "MONTURA GLAUCOMA" => 1257,
      "MONTURA SOLAR" => 1204,
      "OFERTAS DEL MES" => 1195,
      "NIÑO" => 1178,
      "NIÑA" => 1166,
      "VARÓN" => 1187,
      "VARON" => 1187,
      "DAMA" => 1213,
      "UNISEX" => 1424,
      "ARO COMPLETO" => 1163,
      "AL AIRE" => 1183,
      "SEMI AL AIRE" => 1199,
      "PLAQUETAS" => 1184,
      "SOBRELENTES" => 1224,
      "ALARGADO" => 1167,
      "CUADRADO" => 1168,
      "OVALADO" => 1169,
      "REDONDO" => 1175,
      "TRIANGULAR" => 1170,
      "ESPEJADO" => 1205,
      "POLARIZADO" => 1210,
      "ACTIVA" => 1312,
      "ACTIVE" => 1313,
      "ACTUAL" => 1314,
      "ADIDAS" => 1315,
      "AIR MAG" => 1311,
      "ALPI" => 1316,
      "ANGELINA BONDONE" => 1317,
      "ARGOS" => 1318,
      "ARNETTE" => 1319,
      "BELLAGIO" => 1320,
      "BELLUNO" => 1321,
      "BRUCKEN" => 1322,
      "CALVIN KLEIN" => 1323,
      "CANDIES" => 1324,
      "CAROLINA HERRERA" => 1325,
      "CARRERA" => 1326,
      "CATERPILLAR" => 1327,
      "CENTRO STYLE" => 1328,
      "CONVERSE" => 1330,
      "DONNA KARAN" => 1331,
      "DRAGON" => 1332,
      "CHUFANG" => 1329,
      "EMPORIO ARMANI" => 1344,
      "EUROPTICS" => 1334,
      "EXPRESS" => 1338,
      "EZZIO BRAZZINI" => 1343,
      "FERRETTI" => 1340,
      "GANT" => 1341,
      "GIORDI" => 1342,
      "GO FLEX" => 1347,
      "GUESS" => 1348,
      "HELLO KITTY" => 1349,
      "HENKO" => 1350,
      "HUGO BOSS" => 1352,
      "KENZIA" => 1353,
      "LAPO" => 1354,
      "LEVENT KIDS" => 1355,
      "MISSONI" => 1356,
      "MIYAGI EYEWEAR" => 1357,
      "MONDI" => 1358,
      "MOSCHINO" => 1359,
      "NANO VISTA" => 1360,
      "Nano" => 1360,
      "NAUTICA" => 1361,
      "NEW YORK" => 1362,
      "NIKE" => 1363,
      "NINE WEST" => 1364,
      "OAKLEY" => 1365,
      "OPAL" => 1345,
      "OSIRIS" => 1346,
      "PENTAX" => 1366,
      "PIERRE CARDIN" => 1367,
      "POLAROID" => 1368,
      "PUMA" => 1369,
      "PV OPTICS" => 1370,
      "QUALITY" => 1371,
      "QUEST" => 1372,
      "RAY BAN" => 1373,
      "REEBOK" => 1374,
      "SMART" => 1376,
      "ROXY" => 1375,
      "SPY" => 1378,
      "SPOLETO" => 1377,
      "SWAROSKI" => 1379,
      "TATTOO" => 1380,
      "TONY HAWK" => 1278,
      "URBAN CHAOS" => 1381,
      "VALENTINA FERRUCCI" => 1385,
      "ANDRE MORETI" => 1388,
      "DRWN" => 1389,
      "JOHNSON & JOHNSON" => 1390,
      "KENETH COLE" => 1391,
      "LACOSTE" => 1392,
      "LIZEMBLEM" => 1393,
      "LUCKY BRAND" => 1394,
      "MYTHO" => 1395,
      "Pepe Jeans" => 1396,
      "POLAR SPORTS" => 1397,
      "PV TM" => 1398,
      "TOMMY HILFIGER" => 1399,
      "TOYOKA SEGURIDAD" => 1400,
      "VORTEX" => 1386,
      "XOX" => 1387
    );

    if (array_key_exists($etiqueta, $tags_ids)) {
      return $tags_ids[$etiqueta];
    } else {
      return 0;
    }
  }
}
