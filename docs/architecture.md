# Arquitectura

## Principios
- Clean Architecture: `presentation`, `domain`, `data`.
- Local-first: ninguna subida de datos por defecto.
- Diseño para evolución: sincronización opcional futura desacoplada.

## Módulos
- Personal Finance: cuentas, transacciones, categorías, presupuestos.
- Investments: activos, operaciones, corporate actions, holdings, PnL.
- Imports: detectores, parsers, mapeo genérico, deduplicación, logging.
- Dashboard: KPIs + gráficos.

## Persistencia
- Drift + SQLite local.
- Preparado para SQLCipher.
- Tabla de `ImportRun` para auditoría.

## Decisiones técnicas
- Riverpod: estado predecible y testeable.
- go_router: navegación declarativa multiplataforma.
- Decimal para importes monetarios.
