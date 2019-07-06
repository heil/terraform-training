# Immutable Infrastructure

Die wichtigste Richtlinie für eine unveränderliche Infrastruktur ist, dass man niemals etwas ändert, indem man es aktualisiert. Wenn eine Änderung erforderlich ist, ersetzt man stattdessen das alte vollständig durch neues, das die Aktualisierung oder Änderung enthält.

## Vorteile

* Rollbacks
* Veränderungen erfolgen programmatisch und sind somit kontrollierbarer
* Konsistenz über verschiedene Umgebungen (Testing, Staging, Production)
* Status der Infrastruktur ist bekannt und fix

## Nachteile

* Hoher Aufwand am Anfang
* Kleinere Fixes erfordern komplettes Redeployment
* Mögliche Kostensteigerung durch erhöhten Ressourcenverbrauch (bsp.-weise durch häufiges Redeployment)
