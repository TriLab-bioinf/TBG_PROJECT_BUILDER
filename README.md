# build_project_dir.sh

## 1. Description

`build_project_dir.sh` is a helper script for generating a standardized project folder tree following TBG SOP (standard operating procedure) naming conventions.

It creates a project root under `/data/$USER/<PI>/<TICKET>` and populates subdirectories for common project assets (`data_raw`, `data`, `config`, `logs`, `scripts`, `results`, `documents`).

Optional support for language-specific subprojects is included:
- `R` directories (if `-R` is given)
- `python` directories (if `-p` is given)
- `snakemake` directories (if `-s` is given)

It also writes a basic project `README.md` containing the PI and ticket name.

## 2. Installation

No build/install steps are required if you already have the script locally.

1. Ensure the script is executable:

   ```bash
   chmod +x /path/to/build_project_dir.sh
   ```

2. From the script directory (or anywhere in PATH):

   ```bash
   export PATH="$PATH:/home/lorenziha/data/bin/build_project"
   ```

3. Verify with:

   ```bash
   build_project_dir.sh -h
   ```

## 3. Usage

Syntax:

```bash
build_project_dir.sh -P <PI_First_Last> -t <TK_123> [-R] [-p] [-s] [-h]
```

Options:

- `-P`: PI name in `First_Last` format (required)
- `-t`: ticket ID in `TK_123` format (required)
- `-R`: include R-specific subdirectories
- `-p`: include Python-specific subdirectories
- `-s`: include Snakemake-specific subdirectories
- `-h`: print help text

Validation rules:

- `PI` must match `[a-zA-Z]+_[a-zA-Z]+` (e.g. `Alice_Smith`).
- `TICKET` must match `TK_<digits>` case-insensitive (e.g. `TK_123` or `tk_123`).

The script normalizes both values to uppercase internally before creating directories.

Created structure for all runs:
- `/data/$USER/<PI>/<TICKET>`
- `data_raw`, `data`, `config`, `logs`, `scripts`, `results`, and `documents`

Optional extra trees:
- R: `R/data`, `R/scripts`, `R/results`, `R/results/rds_files`, `R/results/tables`, `R/results/plots`
- Python: `python/data`, `python/scripts`, `python/results`, `python/results/tables`, `python/results/plots`
- Snakemake: `snakemake/data`, `snakemake/scripts`, `snakemake/config`, `snakemake/benchmark`, `snakemake/workflow/rules`, `snakemake/workflow/scripts`

## 4. Examples

Create minimal project:

```bash
build_project_dir.sh -P Joe_Doe -t TK_101
```

Create project with R and Python support:

```bash
build_project_dir.sh -P Jane_Doe -t TK_202 -R -p
```

Create project with Snakemake support:

```bash
build_project_dir.sh -P Alex_Black -t TK_303 -s
```

Display help:

```bash
build_project_dir.sh -h
```

