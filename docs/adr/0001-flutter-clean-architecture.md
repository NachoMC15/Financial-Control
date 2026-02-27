# ADR 0001: Flutter + Clean Architecture

## Estado
Aceptado

## Contexto
Se necesita app multiplataforma móvil + escritorio, local-first, con evolución a módulos avanzados de importación y análisis financiero.

## Decisión
Usar Flutter (Dart) con capas `presentation/domain/data`, Riverpod para estado, go_router para navegación y Drift para persistencia local.

## Consecuencias
- Base sólida para crecer a Open Banking y sincronización opcional.
- Mayor esfuerzo inicial de estructura, menor deuda técnica a medio plazo.
