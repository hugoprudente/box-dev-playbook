# ai

Installs Python packages, optional Ollama models, and **agent skills** from configurable GitHub repos.

## Skills repos

Set `ai_skills_repos` in [default.config.yml](../../default.config.yml) or `config.yml`:

```yaml
ai_skills_repos:
  - repo: JuliusBrussee/caveman
    method: skills
    agents:
      - cursor
    global: true
```

- `method: skills` — `npx skills add <repo> -a <agent> -g`
- `method: npx_installer` — `npx -y github:<repo> <installer_args>`

Requires the **languages** role to install Node.js first (`configure_languages: true`).
