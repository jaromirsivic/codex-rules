# Audit AGENT.md, 11. září 2026

Zadání: [zpracovaná specifikace](2026-09-11-18-00-53_notes.processed.md), doplněná níže uvedenými rozhodnutími uživatele. Audit a úprava probíhají v existujícím checkoutu. Výjimka umožňující zásah do chráněného bloku platí pouze pro tento úkol. Tento dokument je záznam auditu, nikoli náhrada závazných pravidel. Před věcnou prací obnov celý účinný globální blok pravidel ze zdroje hostitele a ověř obě přesné sentinelové hranice. Nepoužívej tento záznam jako zkrácenou náhradu pravidel.

Výchozí stav: `AGENT.md` bez lokálních změn, nesledovaný adresář `notes/` již existoval. Výchozí SHA-256: `8318F16A023D516B46FA1308CAE8CDB9C158D4E5234D57CF79D0BC2C71D3B968`.

## Strukturovaný audit před úpravou

| Oblast | Nález | Zamýšlená oprava |
|---|---|---|
| Ochrana a předávání | Absolutní zákaz vynechání bloku odporuje následné možnosti předat pouze pokyn k načtení. | Jednoznačně vymezit dvě přípustné formy předání, celý doslovný blok nebo povinné načtení kanonického souboru s ověřením. Zakázat jiné zkrácené náhrady. |
| Autorita | Označení neměnnosti a obecná priorita výslovných uživatelských pokynů nevymezují oprávnění k editaci. | Vyžadovat výslovné oprávnění pro konkrétní zásah do chráněného bloku. Zachovat nadřazenost systémových a vývojářských instrukcí a oprávnění nástrojů. |
| Aktivace a obnova | Duplicita postupu načtení a kontroly, nejasný vztah přesné odpovědi k ostatním stylovým pravidlům. | Jedna definice načtení a kontroly, samostatná podmínka aktivační odpovědi. Přesná hlášení mají přednost před stylem. |
| Souhlas s delegací | Výraz, že souhlas zahrnuje potomky, může být chápán jako neomezené právo dalšího větvení. | Počet, rozsah a mechanismus musí zůstat v uživatelem schválených mezích napříč celým stromem. |
| Preference mechanismu | Preference projektových tasků může zastínit explicitně požadovaný subagentový mechanismus. | Výslovný mechanismus má přednost, preference se uplatní pouze při jeho neurčení. Nedostupný mechanismus vyžaduje schválení náhrady. |
| Časové limity | Nový potomek má vlastní výchozí limit, ale předek může mezitím dosáhnout termínu pro rekurzivní zastavení. Není jasné, který limit platí. | Uživatel během auditu rozhodl, že celý strom má jednu společnou absolutní lhůtu. Koordinátor ji stanoví a každý pozdější potomek ji zdědí. Obnova kontextu nesmí čas vynulovat. |
| Prodloužení | Výchozí okno, jiná délka, pozdní žádost a souhlas bez délky nejsou sjednoceny. | Žádat 30 minut před termínem, při kratším zbývajícím čase ihned. Výslovné prodloužení bez délky znamená 150 minut od schválení. Mlčení neprodlužuje termín. |
| Bezpečné zaparkování | Povinnost získat potvrzení celého stromu nerozlišuje již dokončené potomky. Absolutní hlášení o zastavení může předběhnout práci koordinátora. | Ověřit dokončené i zaparkované potomky a zastavení práce koordinátora v tomto stromu. Nedostupné či neověřené členy výslovně uvést, hlášení nevydat předčasně. |
| Existující kontexty | Doplnění neuvedených hodnot z tabulky může měnit i nastavení, která uživatel u existujícího tasku měnit nechtěl. | Oddělit konfiguraci nového kontextu a požadovanou změnu existujícího. U existujícího zachovat nevyžádaná nastavení. |
| Názvy tasků | Povinné nastavení názvu při tvorbě je v napětí se zákazem přejmenovat existující task, když nástroj přidělí dočasný název. | Jednoznačně zahrnout nastavení a ověření názvu do autorizovaného vytvoření, ostatní přejmenování vyžadují žádost. |
| Projektový kontext | Opakovaná definice prázdné znalostní báze, nejasný rozsah explicitní cesty a konfliktů aliasů. | Sloučit výchozí hodnotu, výslovně upřednostnit uživatelem zadanou znalostní bázi a zachovat pořadí pracovních cest pro vybraný projekt. Při nejednoznačné shodě zastavit pouze závislou práci. |
| Styl | Obecná pravidla pro češtinu a interpunkci mohou kolidovat s přesnými hlášeními či cílovým jazykem artefaktu. | Výslovně podřídit styl povinným literálům a zachování zdrojového textu. |

## Doplnění zadání během auditu

1. Celý delegovaný strom má jednu společnou absolutní lhůtu. Pozdější potomci dědí stejný termín, nikoli nových 150 minut.
2. Uživatel výsledný obsah vývojového `AGENT.md` vloží přes copy/paste do Codex Settings > Personalization. Text proto musí fungovat samostatně jako globální personalizační instrukce i v jiných projektech a prostředích. Pevná cesta k vývojovému repozitáři nesmí být runtime podmínkou.

Druhé rozhodnutí mění původní předpoklad bootstrapu. Výsledná verze rozlišuje vývojový soubor `AGENT.md` a účinné globální instrukce hostitele. Při dostupném globálním souboru vyžaduje jeho celé nové načtení ze skutečného Codex home. Bez přístupného souboru dovoluje úplný globální blok dodaný hostitelem do aktuálního kontextu. Paměť, souhrn, částečná kopie ani projektový soubor nejsou náhrada. Bez úplného zdroje nebo při chybě kontroly se věcná práce zastaví.

Sentinely nadále tvoří přesný první a poslední řádek vývojového souboru. Při běhu ohraničují celý chráněný blok, který může být součástí širší globální instrukční vrstvy. Kontrola odmítá změněné, chybějící, duplicitní či obráceně seřazené hranice a zjevné zkrácení. Samotné sentinely nemohou prokázat autenticitu nebo nezměněný vnitřek bloku. Toto technické omezení je nyní výslovné.

## Rozsah ověření hostitele

Oficiální dokumentace potvrzuje, že osobní instrukce Codexu jsou uložené v globálním `AGENTS.md`. Zdroj: [OpenAI, Personalize ChatGPT](https://learn.chatgpt.com/docs/personalize). Načítání globálního souboru, případného `AGENTS.override.md` a projektových vrstev závisí na konfiguraci hostitele. Samotný název vývojového `AGENT.md` ani sentinely tedy nezajišťují načtení či technické vynucení. Zdroj: [OpenAI, Custom instructions with AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md).

V tomto prostředí existuje `C:\Users\User\.codex\AGENTS.md` a globální `AGENTS.override.md` nebyl nalezen. Kontrola SHA-256 po úpravě potvrdila, že globální soubor stále obsahuje původní verzi. Vývojový soubor s ním není propojen pevným odkazem. Audit upravuje pouze požadovaný vývojový soubor a záznam auditu. Vložení do personalizace provede uživatel podle svého rozhodnutí.

## Významové změny a zachované části

Společný absolutní termín je výslovné nové rozhodnutí uživatele předané koordinátorem během auditu. Výchozí začátek je spuštění prvního potomka, konec po 150 minutách a první žádost po 120 minutách. Nový potomek bez informace o termínu si nesmí přidělit vlastní 150minutovou lhůtu. Vyžádá si společný termín přes rodiče a do potvrzení nezačne věcnou práci ani další delegaci. Jde o bezpečnostní důsledek nového rozhodnutí, nikoli pouze stylistické zkrácení původního fallbacku.

Přesnější pravidla dále výslovně chrání nevyžádaná nastavení existujících kontextů, zakazují vynulování času obnovou kontextu a podmiňují hlášení o zastavení ověřením celého stromu i vlastní práce koordinátora v tomto stromu. Ověřené dokončení potomka se uznává bez jeho opětovného spuštění.

Největší úspora vznikla sjednocením postupu načtení a kontroly, zkrácením opakovaných povinností při předávání limitů a odstraněním duplicitní definice výchozí znalostní báze. Nově potřebné rozlišení globální a vývojové vrstvy část úspory spotřebovalo. Rozsáhlejší pojistky bezpečného zaparkování zůstaly explicitní. Text nadále vyžaduje souhlas pro vytvoření kontextů, změnu mechanismu, worktree i obnovení zaparkované práce.

Beze změny zůstaly obě tabulky včetně všech modelů, úsilí, projektů, aliasů, cest a vstupních dokumentů. Doslovně zůstaly také sentinelové řádky, aktivační odpověď, hlášení o zastavení, kódy názvů tasků, odstavec o sdíleném Git checkoutu, Note Taker, správa Pythonu přes `uv`, čeština a oslovení, zákaz úvodní obecné výplně a hlasové preference.

## Závěrečná kontrola

Kontrola zahrnuje celý výsledný soubor, celý Git diff a následující scénáře. Jde o textový audit pravidel a strukturální kontroly, nikoli o empirickou zkoušku chování nově spuštěných agentů.

| Scénář | Výsledné pravidlo |
|---|---|
| Úvodní pozdrav včetně uvedených variant a různé velikosti písmen | Úplné opětovné přečtení účinného globálního zdroje a kontrola, přesná odpověď pouze při úspěchu. |
| Pozdrav až uvnitř jiné věty nebo jen podobný podřetězec | Bez aktivace. |
| Chybějící, změněné, duplicitní či obrácené sentinelové hranice nebo zkrácený obsah | Zastavení věcné práce, stručné hlášení chyby, žádná aktivační odpověď. |
| Obnova kontextu nebo předání | Obnovení celého účinného globálního bloku a ověření. Čas se neresetuje. |
| Projekt codex-rules není dostupný | Není runtime závislostí, použije se globální vrstva hostitele. |
| Globální soubor není přístupný, ale celý globální blok je v aktuálním kontextu hostitele | Ověření tohoto bloku, bez nepravdivého tvrzení o načtení z disku. |
| Není dostupný celý globální blok ani globální soubor | Zastavení věcné práce a nahlášení omezení. |
| Hostitel používá globální override | Určení skutečně používaného globálního zdroje, bez slepého výběru jiného souboru. |
| Další globální instrukce před a za blokem | Přípustné, přesné sentinely ohraničují chráněný blok. |
| Pouhé přidělení role, zmínka projektu či mlčení | Nevzniká souhlas s delegací. |
| Pozdější potomek spuštěný 149 minut po prvním | Zbývá jedna minuta do společného výchozího termínu. |
| Potomek bez potvrzeného termínu | Vyžádání přes rodiče, do potvrzení bez věcné práce. |
| Souhlas s prodloužením bez délky | Nový společný termín 150 minut od schválení, další žádost po 120 minutách. |
| Zamítnutí nebo vypršení bez odpovědi | Rekurzivní bezpečné zaparkování, bez další nové práce. |
| Nedostupný člen stromu | Výslovné uvedení neověřeného stavu, bez tvrzení, že celý strom stojí. |
| Jen změna úsilí u existujícího tasku | Zachování modelu a jiných nevyžádaných nastavení. |
| Nové pojmenování tasku | Ověřený model a úsilí, předepsaný název v rámci tvorby, ostatní přejmenování jen na žádost. |
| Chybějící projektová cesta nebo vstupní dokument | Nahlášení překážky a pokračování pouze v nezávislé autorizované práci. |
| Chybějící uv | Bez instalace jiným správcem, nahlášení překážky a pokračování nezávislé práce. |

Strukturálně ověřeno: přesný první a poslední sentinel a právě jeden výskyt každé samostatné hranice, doslovná shoda obou tabulek a uvedených nezměněných odstavců s výchozí kopií, absence náhradního znaku Unicode a čistý `git diff --check`. V `AGENT.md` nezůstal odkaz na cestu vývojového repozitáře ani požadavek načíst původní kanonický projektový soubor. Konce řádků sjednoceny na CRLF odpovídající nastavení Git checkoutu. Změněn pouze sledovaný `AGENT.md`, přidán tento audit do již existujícího `notes/`. Původní poznámky ani další soubory nebyly upraveny. Nevznikl worktree, nový agent, commit ani `AGENT2.md`.

| Metrika | Před | Po | Rozdíl |
|---|---:|---:|---:|
| Znaky při jednotném LF | 15 664 | 15 355 | −309, tedy −1,97 % |
| Slova oddělená bílými znaky | 2 325 | 2 219 | −106, tedy −4,56 % |
| Bajty UTF-8 na disku | 15 741 | 15 478 | −263, tedy −1,67 % |

Počet znaků je porovnán po normalizaci CRLF na LF, aby úsporu nezkreslila úprava konců řádků. Nejde o počet modelových tokenů. Výsledný text zůstal kratší i po doplnění nové podpory globální personalizace. Výsledný SHA-256 `AGENT.md`: `620E871025B1E178197BB97D73E456D58AF2B33B0E34BE803231A15543324CDC`.
