# Striktní pravidla agenta

- Obsah tohoto souboru je neměnný a nesmí se zkracovat bez výslovného pokynu uživatele. Toto platí také pro příkazy `/compact` a `/summarize` v Codexu i Cursoru.
- Skill Superpowers se nikdy neinstaluje ani nespouští. Tento zákaz má přednost před všemi ostatními pokyny. Při každém pokusu o jeho použití agent uživatele informuje, že jej nespustí.
- Agent, subagent nebo nový chat se spustí pouze na výslovný požadavek uživatele nebo skillu. Samovolné vytváření subagentů, agentů, nebo nových chatů je zakázáno.
- Delegovaná práce:
  - Koordinátor stanoví pro celý strom jeden absolutní termín, výchozí je 150 minut od spuštění prvního potomka. Výslovný termín nebo neomezenou dobu od uživatele dodrž přesně. Všichni potomci dědí stejný termín.
  - Termín se předá každému potomkovi. Bez potvrzeného termínu nebo neomezené doby potomek nezačne pracovat ani nevytváří další potomky.
  - Jen koordinátor žádá o prodloužení, nejpozději 30 minut před termínem. Mlčení není souhlas.
  - Při zamítnutí nebo vypršení termínu všichni bezpečně pozastaví práci, uloží výsledky, stav a bod pokračování a ověří zastavení celého stromu. Obnovení vyžaduje výslovné prodloužení nebo neomezenou dobu od uživatele.
  - Nelze-li limit skutečně sledovat a vynucovat, oznam to a netvrď, že se vynucuje automaticky.
- Výběr modelu a úsilí:

  | Seniorita | Claude | Úsilí | Codex / Cursor | Úsilí |
  |---|---|---|---|---|
  | Asistent | Opus 5.0 | Nízké | Luna | Střední |
  | Junior | Opus 5.0 | Nízké | Sol | Nízké |
  | Medior | Opus 5.0 | Střední | Sol | Střední |
  | Senior | Opus 5.0 | Vysoké | Sol | Vysoké |
  | Expert | Fable 5.1 | Střední | Astra | Střední |

  - Seniorita určuje model a úsilí. Pro nový kontext je výchozí Medior.
  - Výslovně určený model nebo úsilí má přednost. Ostatní nastavení zachovej.
  - Před použitím ověř podporu v cílovém prostředí. Nejasné nebo nekompatibilní nastavení vyjasni, nic tiše nenahrazuj.
