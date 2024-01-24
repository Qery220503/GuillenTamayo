<?php

namespace App\Exports\Master;

use App\Models\Productos;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;
use Maatwebsite\Excel\Concerns\WithHeadings;

class ProductoStockExport implements FromCollection, WithHeadings, ShouldAutoSize
{
    public function headings(): array
    {
        return [
            'Código',
            'Nombre Producto',
            'Marca',
            'Categoria',
            'Codigo Varilla',
            'Material',
            'Tipo Aro',
            'Forma Montura',
            'Precio Compra',
            'Precio Venta',
            'Signo Stock (+/-)',
            'Stock',
        ];
    }

    public function collection()
    {
        $data = DB::table('productos')
        ->where("productos.estado", 1)
        ->where("productos.stock", '!=', 0)
        ->join('productos_marcas', 'productos_marcas.id_marca_producto', '=', 'productos.id_marca')
        ->join('productos_categorias', 'productos_categorias.id_producto_categoria', '=', 'productos.id_categoria')
        ->join('productos_material', 'productos_material.id_material', '=', 'productos.id_material')
        ->join('productos_tipo_aro', 'productos_tipo_aro.id_tipo_aro', '=', 'productos.id_tipo_aro')
        ->join('productos_forma_montura', 'productos_forma_montura.id_forma_montura', '=', 'productos.id_forma_montura')
        ->select(
            'codigo_producto',
            'nombre_producto',
            'productos_marcas.marca_producto',
            'productos_categorias.nombre_categoria',
            'codigo_varilla',
            'productos_material.nombre_material',
            'productos_tipo_aro.tipo_aro',
            'productos_forma_montura.forma_montura',
            'precio_compra',
            'precio_venta',
            'stock'
        )->get();
        
        $data_arr = [];
        foreach($data as $key=>$dt){
            array_push($data_arr, array(
                "codigo_producto" => $dt->codigo_producto,
                "nombre_producto" => $dt->nombre_producto,
                "marca_producto" => $dt->marca_producto,
                "nombre_categoria" => $dt->nombre_categoria,
                "codigo_varilla" => $dt->codigo_varilla,
                "nombre_material" => $dt->nombre_material,
                "tipo_aro" => $dt->tipo_aro,
                "forma_montura" => $dt->forma_montura,
                "precio_compra" => $dt->precio_compra,
                "precio_venta" => $dt->precio_venta,
                "stock_signo" => $dt->stock < 0? '-' : '+',
                "stock" => abs($dt->stock),
            ));
        }

        $data_colleciton = collect($data_arr);
        return $data_colleciton;
    }
}