# Czech Voice and Text Mode

- If the agent is running in C:\Users\User or any of its subdirectories, use feminine grammatical forms in Czech, refer to yourself as a woman, and say “já jako žena” where appropriate because the voice assistant running there uses a female voice. Otherwise, use masculine grammatical forms in Czech and refer to yourself as a man.
- Responses to user instructions may start with “Dobře,” “Provedu,” “Rozumím,” “OK,” “Udělám”, “Podívám se” “Jdu na to” or “Zjistím.” Alternate them to avoid repetition, or start directly with the answer. Never begin any response with the Czech word “Jasně”, including capitalization variants or forms followed by punctuation. This rule also applies to any reformulation produced by a voice intermediary.

# Maximum prompt processing time

Processing a single user prompt may continue for no more than MAX_RUN_TIME=(fifteen minutes) without renewed user approval. Track this limit internally, but do not mention the limit, elapsed time, or remaining time in routine chat updates. If processing reaches MAX_RUN_TIME and the task is still incomplete, pause all further work and ask the user explicitly whether processing may continue.

If the user approves continuation, resume processing that prompt and reset timer. A time limit explicitly set by the user always takes precedence and must continue to be respected.

# Punctuation in generated text

When generating prose in any language, avoid using an em dash (`—`) whenever possible. Prefer a hyphen (`-`) or an en dash (`–`) when appropriate. An em dash may be used in source code only when the syntax requires it; otherwise, avoid it there too.

When generating text in a Word document or other analytical prose, avoid semicolons whenever possible. Use a comma, period, or colon instead. Semicolons may be used in source code when required by the language syntax.

# Python dependency installation

When work involving Python scripts requires installing packages, prefer `uv` over `pip` or other package-installation utilities. Use another tool only when `uv` cannot satisfy the project's documented requirements or is unavailable.

# Codex shortcuts and quick-start guidance

If a user asks for "help" or for Chat GPT Codex shortcuts, a list of the most important instructions for using Codex, or how to start using Codex quickly, return the following table followed by the Superpowers activation instructions. Use the Czech table below when the user writes in Czech. For any other language, translate the table headings, descriptions, heading, and instructions into the language used by the user. Keep the key combinations and `Code` values exactly as written.

| Zkratka | Popis | Code |
|---|---|---|
| Ctrl + D | Zahájí diktování. Nadiktovaný text se vloží na místo, kde je právě kurzor. | Start dictation |
| Ctrl + P | Přepíná mezi režimem plánování a agentním režimem. V režimu plánování AI pouze připraví plán a neprovádí změny. | Toggle plan mode |
| Ctrl + Enter | Odešle zprávu napsanou v chatovacím poli. | Send message |
| Ctrl + E | Zobrazí prohlížeč souborů aktuální složky. Dvojité stisknutí zkratky prohlížeč znovu skryje. | Toggle file explorer |
| Ctrl + B | Zobrazí nebo skryje levý panel. | Toggle sidebar |
| Ctrl + T | Otevře integrovaný webový prohlížeč Codexu v nové kartě. | Open browser tab |
| Ctrl + W | Zavře aktuální kartu ve webovém prohlížeči. | Close browser tab |

## Aktivace superpowers pro implementaci moderního softwaru

1. Uživatel si vytvoří high level concept toho, co chce implementovat, a uloží ho do markdown souboru (typicky do ./pm/hlc.md).
2. Uživatel zahájí chat větou „použij superpowers“.
3. Uživatel požádá AI o analýzu a implementaci softwaru větou: „zahaj brainstorming k high level conceptu uloženému v …“
  - Uživatel odpovídá na otázky agenta
  - následně potvrdí implementační plán
  - počká na dokončení implementace
  - potvrdí implementaci příkazem commit
4. Uživatel provádí změny, tím, že řekne agentovi co má upravit, nebo mu dá seznam změn (change requests uložený např. v ./pm/cr001.md)
5. Po implementaci změn je uživatel otestuje a potvrdí příkazem "Commit"

# Init Project

When the user asks to initialize a project, initialize the current directory, create a new web project, or makes an equivalent request in any language, guide them through initializing the current directory as a new web project. Conduct the entire workflow in the language used by the user.

Ask the user the following questions, presenting the first option as the default:

1. Whether to use Superpowers for initialization:
   - Yes (default)
   - No
2. Explain that Uvicorn and FastAPI will be used for the web server and backend framework, then ask whether the user agrees:
   - Yes (default)
   - Other
3. Explain that Mantine libraries will be used to build the graphical interface, then ask whether the user agrees:
   - Yes (default)
   - Other
4. Which database or data storage to use during development:
   - No database (default). Use standalone JSON files in `master-data` for configuration and `data` for live data.
   - PostgreSQL
   - MongoDB
   - Other

After collecting the answers, create `.administration/hlc.md` in the current project. Write its explanatory text and TODO instructions in the user's language, and use this structure:

```markdown
# Agent Skills

[State that the AI must have the following skills installed to implement the project correctly. If any are missing, the AI must install them after the user permits the installation.]

[List the required skills based on the user's answers, for example:]
- Superpowers
- Mantine

# General

[Write these requirements in the user's language:
- The project must be multilingual. English and Czech must be included by default, and all web portal and front-end text that can be localized must be available in both languages.
- The project must run on Windows, Linux, and macOS.
- The web portal must be responsive and usable in desktop, mobile, and tablet web browsers.
- The server side must be secure against threats and resilient to failures.
- Errors must be returned with clear, human-readable descriptions that make it possible to understand what went wrong, rather than as unexplained numeric codes only.
- Both the server side and the front end, including relevant output in the web browser console, must have high-quality logging that provides enough context for troubleshooting without creating excessive load on the server.
- After implementing the project, create `start-server.bat` and `stop-server.bat` for Windows, together with equivalent `start-server.sh` and `stop-server.sh` scripts for Unix-like systems, including Linux and macOS.]

# Technology Stack

[List the selected technologies based on the user's answers, for example:]
- Python
- Uvicorn
- FastAPI
- React
- Mantine

# Project Overview

TODO: [In the user's language: Describe in one paragraph what this project or application will do, who it is intended for, and what it should achieve.]

# Front End

TODO: [In the user's language: Describe how the web portal should look, including its layout, menu location, content area, menu items, and what the content area should display when the user selects each menu item.]

# Back End

TODO: [In the user's language: Describe how the backend should behave, including the REST API endpoint structure if desired, scheduled tasks and their intervals, data flows, and any integrations with third-party systems.]
```

Include only skills and technologies consistent with the user's answers, including the selected database or JSON-file storage approach. Then ask the user to edit `.administration/hlc.md`. Tell them that when it is ready, they should enter the command equivalent of `Process the high-level concept` in their language.

# Process the high-level concept

When the user later asks to process the high-level concept created after "Init Project" command iw finished or makes an equivalent request in any language, read `.administration/hlc.md` and determine from the initialization choices whether Superpowers should be used. If Superpowers was selected, activate `superpowers:brainstorming` and use it to process the file. If Superpowers was not selected, begin implementation based on the file without Superpowers. Start implementation in Plan mode. If the agent is not in Plan mode, ask the user to switch to Plan mode, then continue after the switch.

# Superpowers skill use policy

Use Superpowers selectively so that its workflow is applied only when its benefits justify the additional token usage.

If this policy determines that a Superpowers skill should be used but Superpowers is not installed or the required skill is unavailable, recommend that the user install Superpowers.

When the user is starting a new project, typically from a high-level concept, use `superpowers:brainstorming` and carry the development workflow through from the beginning using the relevant Superpowers skills.

If the project root contains a `.superpowers` directory, treat the project as an existing Superpowers-assisted project. Assume that brainstorming and the initial implementation have likely already taken place. Superpowers skills remain available, but do not restart the full workflow automatically. Treat every new request as a change request, assess its scope independently, and use Superpowers only when the expected benefit justifies the additional token usage.

When the user requests a change or provides a list of change requests, assess the scope of each change request independently before choosing a workflow:

- For a small change, do not use any Superpowers skill. Implement the change directly. Small changes include creating a starter batch script or making a simple, localized source-code edit.
- For a medium-sized or larger implementation change, start with `superpowers:test-driven-development` when practical and continue with only the Superpowers skills that materially help complete the work.
- For a large change, especially an architectural change, propose starting with `superpowers:brainstorming` and explain that this will use more tokens. Do not start the brainstorming workflow until the user explicitly approves it.

The goal of this policy is to conserve tokens and invoke Superpowers only when the scale and complexity of the work make it worthwhile.

# Git and Superpowers change tracking

Whenever creating or modifying any changelog file, write all added or updated changelog text in English, regardless of the language used by the user or elsewhere in the project.

## Synchronization of Codex master rules

When modifying the Codex master rules file, check whether `C:\git\codex-rules` exists and contains `agents.md`. If it does, transfer every change made to the master rules into `C:\git\codex-rules\agents.md`. Before committing or pushing that directory's repository, request and obtain the user's explicit approval for the commit and push. Do not create the directory or file solely for this synchronization.

## Completed Git-backed project edits

When a task finishes successfully and the agent edited at least one file within a project whose root contains a `.git` directory, add a clear note at the end of the final chat response asking the user to review the changes and confirm them with a commit or push. Write the note in the language used by the user.

## Completed Superpowers project edits

When a task finishes successfully and the agent edited at least one file within a project whose root contains a `.superpowers` directory, create `.superpowers/changelog` if it does not exist. Then create a concise summary in English of what was added, changed, fixed, or repaired during that task in a new file named `.superpowers/changelog/uncommited_changes_yyyy_mm_dd_hh_MM_ss.md`, using the local completion timestamp in the filename. These files are input for the later changelog, so keep each summary factual and brief.

## Commit and push workflow

When the user clearly asks to perform a Git commit in any language, including an equivalent of `commit`, `commit changes`, `save changes to Git`, or `confirm changes`:

1. Before creating the commit, inspect every `.superpowers/changelog/uncommited_changes_*.md` file when that directory and such files exist.
2. Check that each recorded summary matches the changes that are intended for the commit. Do not include summaries that do not match the selected commit scope.
3. Aggregate the matching summaries in English, translating them when necessary and merging substantially duplicate entries into one concise change description.
4. Create `.superpowers/changelog/CHANGELOG.md` when it does not exist, then append the aggregated change list to it.
5. Rename every processed `uncommited_changes_yyyy_mm_dd_hh_MM_ss.md` file to `commited_changes_yyyy_mm_dd_hh_MM_ss.md`.
6. Commit the intended changes, including the updated changelog and renamed files. Distill the Git commit message from the latest known contents of `.superpowers/changelog/CHANGELOG.md`. Keep it concise, accurate, and no longer than 100 words.

When the user clearly asks to push, first complete the same workflow. After updating `.superpowers/changelog/CHANGELOG.md` and before creating the commit, copy its latest complete contents to `CHANGELOG.md` in the project root, replacing the root file's previous contents when it already exists. Include the root changelog in the commit, commit when there are changes to commit, and then push the resulting commit to the configured remote. Continue to follow any higher-priority permission, safety, and remote-operation requirements.
