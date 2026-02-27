# Financial Control

Aplicación **local-first** multiplataforma (Flutter) para control integral de finanzas personales e inversiones.

## Estructura del repositorio

- `apps/financial_control`: app Flutter (móvil + escritorio).
- `docs`: documentación técnica, arquitectura y ADRs.
- `samples`: archivos reales de ejemplo para importación (Bankinter/MyInvestor).

## Estado actual

- Base de UI y navegación multiplataforma completada.
- Importación orientada a tus archivos reales:
  - `samples/Movimientos_bankinter hasta 27 febrero 2026.xlsx`
  - `samples/cartera_acciones_hasta_27febrero2026.csv`
  - `samples/cartera_fondos_hasta_27febrero2026.csv`
  - `samples/depositos comisiones y demás.csv`
- Parser con detección por proveedor, fechas `dd/MM/yyyy` y `yyyy-MM-dd`, importes con coma decimal, deduplicación por hash.

## Cómo ejecutar

> Requiere Flutter SDK 3.22+ instalado y en PATH.

```bash
cd apps/financial_control
flutter pub get
flutter run -d linux    # o windows/macos/android/ios/chrome
```

## ¿Funciona?

Sí a nivel de lógica de importación y estructura base del proyecto. En este entorno de desarrollo no hay Flutter instalado, por lo que la ejecución visual debe hacerse localmente en tu equipo con los comandos anteriores.

## Cómo cargar tus 4 archivos

1. Abre la sección **Importar**.
2. Selecciona varios archivos (CSV/XLSX) en lote.
3. El importador detecta automáticamente:
   - **Bankinter XLSX** por cabecera `Fecha contable, Fecha valor, Descripción, Importe, Saldo, Divisa`.
   - **MyInvestor CSV** de acciones/fondos por columnas `Operación, Liquidación, Mercado, ISIN, Títulos/NOMINAL, Divisa, Precio Neto, Importe neto`.
   - **MyInvestor CSV** de depósitos/intereses por `Date, Type, ISIN, Name, Shares, Amount, Currency`.
4. Se normalizan tipos (trade/interés/depósito/movimiento bancario) y se calcula hash por fila para deduplicación.

Detalles: `docs/import-guide.md`.

## Roadmap inmediato

- Persistencia SQLCipher con clave en Keychain/Keystore.
- Asistente visual completo de mapeo para CSV genérico.
- Registro y resumen UI de runs de importación.
- TWR/MWR y reportes fiscales avanzados.
