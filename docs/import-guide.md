# Guía de importación CSV/XLSX

## Archivos validados en este repositorio

- `samples/Movimientos_bankinter hasta 27 febrero 2026.xlsx`
- `samples/cartera_acciones_hasta_27febrero2026.csv`
- `samples/cartera_fondos_hasta_27febrero2026.csv`
- `samples/depositos comisiones y demás.csv`

## Detección automática de formato

### 1) Bankinter (XLSX)
Se detecta y parsea la hoja `Movimientos` con estructura:
`Fecha contable | Fecha valor | Descripción | Importe | Saldo | Divisa`.

- Se ignoran filas de cabecera y filtros iniciales.
- Cada fila se normaliza como `bankTransaction`.

### 2) MyInvestor cartera acciones/fondos (CSV)
Cabeceras esperadas:
`Operación;Liquidación;Operación;Mercado;Operación;ISIN;Valor;Títulos/NOMINAL;Divisa;Precio Neto;Importe neto`

- Las cabeceras repetidas `Operación` se deduplican internamente (`Operación`, `Operación#2`, `Operación#3`).
- Tipo normalizado:
  - `COMPRA`/`SUSCRIPCION` -> `investmentTrade`
  - `VENTA`/`REEMBOLSO` -> `investmentTrade`

### 3) MyInvestor depósitos/intereses (CSV)
Cabeceras esperadas:
`Date;Type;ISIN;Name;Shares;Amount;Currency`

- Tipo normalizado:
  - `Intereses` -> `interest`
  - `Depósito` -> `deposit`

## Normalizaciones clave

- Delimitador automático `;` o `,`.
- Fechas soportadas: `dd/MM/yyyy`, `yyyy-MM-dd`.
- Importes soportados: `1.234,56` y `1234.56`.
- Hash de deduplicación por fila normalizada (`__rawHash`).

## Supuestos aplicados sobre tus ficheros

1. En los CSV de cartera de MyInvestor, la columna de tipo real de operación viene en la tercera `Operación`.
2. `Importe neto` se usa como importe de efectivo principal para operaciones.
3. En Bankinter XLSX, el primer bloque de datos empieza después de la fila de cabeceras de extracto.
4. Cuando falta divisa en genérico, se usa `EUR` por defecto.

## Si algo no cuadra

- Comparar importes netos y títulos con tu extracto original.
- Si detectas diferencias, exporta una muestra mínima y añade reglas al parser de proveedor.
