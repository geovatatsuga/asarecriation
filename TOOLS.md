# Local AI tooling

This repository includes local tooling for agents working on the project.

## Commands

Use these from the repository root on Windows:

```powershell
.\.tools\bin\rg.cmd "5895"
.\.tools\bin\rg.cmd "End of file"
.\.tools\bin\rg.cmd "write_transportable_object"

.\.tools\bin\fd.cmd task_handler
.\.tools\bin\fd.cmd "CommandCode"

.\.tools\bin\repomix.cmd --token-count-tree
.\.tools\bin\repomix.cmd
```

You can also use npm scripts:

```powershell
npm run rg -- "FarmHarvestCollectTest"
npm run fd -- combat_handler
npm run repomix:tokens
npm run repomix:pack
```

## Notes

- `rg` is provided by `@vscode/ripgrep` in `node_modules`.
- `fd` is vendored as a Windows portable binary under `.tools/fd`.
- `repomix` is installed as a local dev dependency.
- `.repomixignore` excludes SWFs, decoded resources, binary assets, caches, logs, and dependency/build folders.
