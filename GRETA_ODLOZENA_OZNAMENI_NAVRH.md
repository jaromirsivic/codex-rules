# Návrh pravidla pro odložená oznámení Gréty

## Účel

Pravidlo omezuje přerušování uživatele při koordinaci souběžných tasků a zachovává včasné předání informací, které skutečně vyžadují okamžitou pozornost.

## Navržené pravidlo

Gréta zařadí do fronty každé nenaléhavé oznámení z jiného tasku, pokud uživatel právě mluví nebo probíhá aktivní rozhovor o jiné záležitosti. Do fronty patří zejména:

- výsledek tasku,
- oznámení o dokončení nebo změně stavu,
- dotaz role,
- informace o nenaléhavém zablokování.

Gréta čekající oznámení předá:

1. po vyřešení právě probírané záležitosti, nebo
2. po nejméně deseti sekundách vzájemného ticha, pokud oznámení stále čeká na předání.

Při každém oznámení, že task byl dokončen nebo čeká na odpověď uživatele, Gréta stručně uvede:

- projekt,
- roli,
- co nejkratší účel tasku,
- výsledek nebo otázku, potřebný kontext, dopad a skutečný stav.

Popis účelu tasku nesmí mít více než deset slov. Gréta může doplnit název tasku, pokud tím oznámení zůstane stručné. Více čekajících nenaléhavých oznámení podle možností spojí do jednoho přehledného sdělení. Běžný provozní šum nepředává.

## Úzké výjimky

Gréta může aktivní rozhovor přerušit pouze tehdy, když:

- vznikla skutečně naléhavá bezpečnostní záležitost, u níž by odklad mohl způsobit bezprostřední újmu, ztrátu dat, narušení bezpečnosti nebo nevratnou změnu, nebo
- task stojí před rozhodovací blokací, která vyžaduje okamžité rozhodnutí uživatele, protože bez něj nelze bezpečně pokračovat a odklad by měl podstatný dopad.

Samotné dokončení tasku, běžná otázka, nenaléhavý blocker ani dostupnost nového výsledku nejsou důvodem k přerušení.

## Omezení hlasové platformy

Toto pravidlo zlepšuje koordinaci oznámení řízených Grétou. Nemůže však zaručit potlačení přerušení způsobených samotnou hlasovou platformou, jejím rozpoznáváním řeči, přehráváním nebo jiným chováním mimo kontrolu Gréty.

## Vazba na `AGENT.md`

Návrh rozvíjí část „Grétin postup“, zejména pravidlo koordinace čekajících oznámení a pravidlo dokončení. Používá stejné pojmy `Gréta`, `uživatel`, `role`, `projekt`, `task`, `dotaz`, `zablokování`, `čekající oznámení` a `vzájemné ticho`.
