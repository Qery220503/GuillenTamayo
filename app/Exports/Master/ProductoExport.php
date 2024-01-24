<?php

namespace App\Exports\Master;

use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Illuminate\Support\Facades\DB;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class ProductoExport implements FromCollection, WithHeadings, ShouldAutoSize
{
    function __construct() {
    }

    public function headings(): array
    {
        return [
            'ID',
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
            'Stock'
        ];
    }

    public function collection()
    {
        $data = DB::table('productos')
        ->where("productos.estado", 1)
        ->join('productos_marcas', 'productos_marcas.id_marca_producto', '=', 'productos.id_marca')
        ->join('productos_categorias', 'productos_categorias.id_producto_categoria', '=', 'productos.id_categoria')
        ->join('productos_material', 'productos_material.id_material', '=', 'productos.id_material')
        ->join('productos_tipo_aro', 'productos_tipo_aro.id_tipo_aro', '=', 'productos.id_tipo_aro')
        ->join('productos_forma_montura', 'productos_forma_montura.id_forma_montura', '=', 'productos.id_forma_montura')
        ->select('id_producto',
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
        )
        ->get();
        return $data;
    }
}
