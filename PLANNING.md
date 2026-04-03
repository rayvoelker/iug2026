---
title: "IUG 2026 Presentation Planning"
author: Ray Voelker
conference: IUG 2026
presentations: 2
target_length: "~15 minutes each"
status: planning
last_updated: 2026-04-03
---

# IUG 2026 Presentation Planning

## Overview

Two 15-minute presentations about Datasette at the Cincinnati & Hamilton County
Public Library (CHPL). These build on a history of talks Ray has given since 2017,
evolving from "intro to SQL" through "collection analysis" to now encompassing
the Newsdex newspaper index project.

**Talk 1** is the accessible "what and why" -- Datasette + Collection Analysis.
**Talk 2** is the deeper Newsdex story -- from 1927 index cards to SQLite.

If delivered back-to-back, Talk 1 sets the stage and Talk 2 rewards technical
attendees with a specific, narrative-driven case study.

---

## Presentation 1: Datasette at the Library

**Working Title:** "I Love Datasette: From ILS Snapshots to a $5/Month Analysis Platform"

**Audience:** Library technologists, ILS administrators, data-curious library staff

### What's New Since OH-IUG 2021 / IUG 2022

The previous versions of this talk (OH-IUG 2021, IUG 2022) covered the same
core material. Here's what's changed and what's worth updating:

- **URL changed:** Was `ilsweb.cincinnatilibrary.org/collection-analysis/`,
  now `collection-analysis.cincy.pl`
- **Datasette 1.0 alpha series** -- project has matured significantly
- **New plugins:** datasette-plot (replaces datasette-vega), datasette-comments,
  datasette-extract (LLM-powered)
- **AI/LLM intersection:** Simon Willison's NICAR 2026 workshop used Datasette
  alongside Claude Code -- a compelling new angle
- **Datasette Lite** (WebAssembly) -- zero-infrastructure option didn't exist
  in 2021/2022
- **The Newsdex project** is now a concrete second case study to reference

### Proven Structure (from OH-IUG 2021 / IUG 2022)

The three-part structure worked well and should be kept:

1. **Collection Analysis Platform Overview** (What is Datasette?)
2. **Collection Snapshot Creation** (How we extract from Sierra)
3. **The Analysis!** (Live demos with Datasette)

### Key Slides That Worked (Reuse/Update)

From the OH-IUG 2021 and IUG 2022 talks:

- **"Things I Love about Datasette"** -- great audience connection point:
  - Written in Python / Available via pip
  - Easy and intuitive to use
  - Well-documented
  - Useful, large, and growing plugin library
  - Built-in API... Using SQL!
  - Open source + supportive developer
  - Flexible deployment / "CHEAP" hosting options
- **Simon's recommended videos** (update with newer ones if available)
- **Datasette tutorials link** (datasette.io/tutorials)
- **DigitalOcean $5/month droplet** -- the "CHEAP" branding is memorable
- **ILS Underground hosting guide** (ils-underground.github.io)
- **Live demo iframes** -- these were the heart of both talks
- **SQL query examples** -- location analysis, faceting, named parameters
- **Canned queries** -- REST API-like interface for non-SQL users
- **Plugin demos** -- datasette-vega charts, datasette-cluster-map for branch locations
- **Closing "please let me know" slide** -- warm, inviting tone

### Demo Ideas (Pick 3-4)

1. Browse item table, show scale (millions of rows)
2. Facet by location to see item counts per branch
3. Facet by format (Book, DVD, Large Print, etc.)
4. Filter to single branch + facet by format = collection composition
5. Date faceting on last_checkin_date for activity patterns
6. Custom SQL: "items at [branch] not checked out in 3+ years"
7. CSV export from any view
8. JSON API (.json suffix)
9. Cross-database comparison of two date-stamped snapshots
10. Subject search using named parameters (e.g., `subject_like=dystopia`)

### Key URLs

- Live instance: https://collection-analysis.cincy.pl/
- Source code: https://github.com/cincinnatilibrary/collection-analysis
- Hosting guide: https://ils-underground.github.io/python_datasette_vps.html
- PyOhio 2021 Thunder Talk: https://www.pyohio.org/2021/program/talks/i-datasette-an-open-source-multi-tool-for-exploring-and-publishing-data/
- IUG 2022 slides: https://rayvoelker.github.io/iug2022/

---

## Presentation 2: From Index Cards to SQLite (Newsdex)

**Working Title:** "From Index Cards to SQLite: Liberating a Century of Cincinnati News with Datasette"

**Audience:** Library technologists, digital preservation / local history enthusiasts,
MARC/metadata specialists

### The Narrative Arc

This talk has a much stronger storytelling element than Talk 1. The arc:

1. **1927:** Chalmers Hadley's vision -- "news reports of major local happenings
   would be matters of history some day"
2. **1927-1992:** 65 years of hand-typed index cards by generations of librarians
3. **1992:** Cards digitized into the ILS as "Newsdex"
4. **Present:** MARC records extracted, converted via Python/pymarc, loaded into
   SQLite, served through Datasette
5. **Future:** Datasette Lite, LLM-powered search, geocoding, linking to
   digitized full-text

### CHPL Blog Post (Feature Prominently)

https://chpl.org/blogs/post/newsdex-upgrade/

This is the primary source for the Newsdex narrative. Contains:
- History starting in 1927
- Quote from Chalmers Hadley
- Photo of Hadley
- Photo of the physical card catalog
- Screenshot of a Newsdex search result ("1937 flood" example)
- Video tutorial on basic Newsdex searching

### The Technical Pipeline

```
MARC Export (.mrc) --> pymarc (Python) --> Field Mapping & Cleanup --> SQLite --> Datasette
```

Key notebooks in the GitHub repo:
- `notes_and_mappings.ipynb` -- MARC field to column mapping (the "translation layer")
- `newsdex-convert.ipynb` -- Record conversion logic
- `marc-to-sqlite.ipynb` -- Loads structured data into SQLite

### MARC Field Mapping (The Heart of Talk 2)

| MARC Field | Subfield | Becomes...         | Notes                                          |
|------------|----------|--------------------|-------------------------------------------------|
| 245        | $a       | `title`            | Article title                                   |
| 260        | $b       | `newspaper`        | Publication name                                |
| 260        | $c       | `date`             | Needs normalization!                            |
| 300        | $a       | `page`, `column`,  | Parse "7:2 pic" --> page=7, col=2, image=true   |
|            |          | `has_image`        |                                                 |
| 650        | $a       | `subjects` (JSON)  | Repeatable -- one record may have many subjects |
| 100        | $a       | `author`           | When available                                  |
| 008        | pos 7-10 | `year`             | Fixed-length date for sorting/faceting          |

### Newspapers Covered

Cincinnati Enquirer, Cincinnati Post, Cincinnati Herald, Cincinnati Magazine,
Business Courier, Downtowner. Selected coverage reaching back to the early 1800s.

### Key URLs

- Newsdex (live search): https://newsdex.cincinnatilibrary.org/
- Newsdex GitHub repo: https://github.com/cincinnatilibrary/newsdex
- CHPL Blog Post: https://chpl.org/blogs/post/newsdex-upgrade/
- CHPL Genealogy & Local History: https://chpl.org/genealogy-history/

---

## Prior Presentation History

Ray has been presenting at IUG and related conferences since 2017, with a clear
evolution from SQL basics toward data liberation via Datasette.

### Timeline

| Year | Event          | Title / Topic                                              | Format      | Location                                               |
|------|----------------|------------------------------------------------------------|-------------|--------------------------------------------------------|
| 2017 | OH-IUG         | "Intro to SQL and Now What"                                | Reveal.js   | `~/Documents/ohiug-2017-master/`                       |
| 2019 | IUG            | Sierra SQL: Data Extraction, Caching, Geocoding            | Reveal.js   | `~/Documents/2019-iug/`                                |
| 2019 | IUG (training) | "How to SQL (Sierra)" Parts 1 & 2 (w/ Goldstein, Shirley) | PDF         | `~/Documents/iug2019-sql/`                             |
| 2020 | NEIUG          | FOSS Data Analysis Solutions (Python, Pandas, Altair)      | Jupyter     | `~/Documents/NEIUG-2020/`                              |
| 2021 | PyOhio         | "I Heart Datasette" Thunder Talk                           | Video+Slides| `~/ray_voelker_i-heart-datasette_pyohio2021_thunder_talk.mp4` |
| 2021 | OH-IUG         | "Collection Analysis for $5 a Month. CHEAP!"              | PDF/Slides  | `~/Documents/Ray Voelker - OH-IUG 2021 - ...pdf`      |
| 2022 | IUG            | "Collection Analysis for $5 a Month. CHEAP!" (expanded)   | Reveal.js   | `~/Documents/iug2022/`                                 |
| 2022 | WILIUG         | "HOWTO SQL: Sierra" (w/ bundled Datasette app!)            | Reveal.js   | `~/Documents/WILIUG-2022/`                             |
| 2023 | IUG            | Lightning Talk: Sierra REST API + Python automation        | HTML+Colab  | `~/Documents/iug2023/`                                 |
| 2024 | IUG            | Sierra ILS Utils, Neural Search                            | Jupyter     | `~/Documents/rvoelker-iug2024/`                        |

### Key Evolution Points

- **2017-2019:** Teaching SQL fundamentals to the Sierra community
- **2020:** Introduced Python ecosystem (Pandas, Altair, Jupyter) for data analysis
- **2021:** Pivoted to Datasette as the primary platform -- PyOhio was the debut,
  OH-IUG was the first IUG-audience version
- **2022:** Expanded the talk with live iframe demos, SQL examples, plugin showcases
  (vega charts, cluster maps). WILIUG version notably bundled a working Datasette
  app with a test Sierra database
- **2023-2024:** Branched into Sierra REST API automation and neural search

### Presentation Style & Preferences

- **Framework:** Consistently uses Reveal.js for HTML-based presentations
- **Live demos:** Heavily demo-oriented -- embeds Datasette as iframes in slides
- **Branding:** Custom "MADFONT" for the "CHEAP" styling, CHPL and conference logos
- **Tone:** Enthusiastic, practical, "let me show you how cool this is"
- **Closing:** Warm invitation to connect and share -- "let me know if you come up
  with any cool queries, love Datasette as much as I do, or want to use this at
  your library!"

---

## Existing Assets to Reuse

### Images & Logos (known locations)

- `~/Documents/iug2022/img/iug_connections_crop.jpg` -- IUG logo
- `~/Documents/iug2022/img/CHPL_Brandmark_Primary.png` -- CHPL logo
- `~/Documents/iug2022/img/datasette.io.png` -- Datasette website screenshot
- `~/Documents/iug2022/img/datasette-custom-sql.png` -- SQL interface screenshot
- `~/Pictures/iug-2022-collection-analysis-cheap.png` -- Talk screenshot
- `~/Pictures/datasette-custom-sql.png` -- SQL query interface
- `~/Pictures/ohiug-logo.png` -- OH-IUG logo
- `~/datasette_presentation_assets/` -- Blender files, thumbnails, title assets

### Videos

- `~/ray_voelker_i-heart-datasette_pyohio2021_thunder_talk.mp4` (260 MB) -- PyOhio 2021
- `~/Collection Analysis for $5 a Month. CHEAP!  -- OH-IUG 2021.mkv` (97.6 MB)
- `~/Collection Analysis for $5 a Month. CHEAP!  -- OH-IUG 2021_fixed_audio.mkv` (90.8 MB)

### Code & Notebooks

- `~/collection-analysis.cincy.pl_gen_db.ipynb` -- Production DB generation workflow
- `~/Documents/IUG_2023_lightning_talk.ipynb` -- Sierra API automation
- `~/Documents/NEIUG-2020/sierra_sql_examples.ipynb` -- Python/Pandas/Altair examples

---

## Datasette Ecosystem (Current State for 2026 Talk)

### Core Tools
- **Datasette** -- datasette.io -- exploring and publishing data on SQLite
- **sqlite-utils** -- Python library & CLI for SQLite database manipulation
- **Datasette Lite** -- lite.datasette.io -- runs entirely in browser via WebAssembly

### Notable Plugins to Highlight
- **datasette-plot** -- successor to datasette-vega for charts
- **datasette-comments** -- collaborative annotation on data rows
- **datasette-extract** -- LLM-powered structured data extraction
- **datasette-cluster-map** -- geographic plotting with Leaflet (used in IUG 2022)
- **datasette-search-all** -- search across all tables

### What's New Since Last Talk
- Datasette 1.0 alpha series
- datasette-showboat -- coding agent integration
- Simon Willison's NICAR 2026 workshop: coding agents + Datasette
- The `llm` CLI tool pairs with Datasette for AI-powered data exploration
- Over 100 plugins now available

---

## About CHPL (Context Slide Material)

- One of the busiest public library systems in the US
- ~9.6 million volumes (13th largest, 2nd largest public library collection)
- 41 locations across Hamilton County
- Over 21 million items circulated annually (pre-pandemic)
- Downtown Main Library: 4M+ items/year (most of any single location in the US)
- Runs Sierra ILS (Innovative Interfaces / Clarivate)

---

## Architecture Reference

### Collection Analysis Pipeline
```
Sierra ILS --> PostgreSQL (Sierra DB) --> Python Scripts (sqlite-utils) --> SQLite --> Datasette
```
- Automated with scheduled jobs (daily updates, weekly full rebuilds)
- Multiple date-stamped snapshots served simultaneously
- Hosted on $5/month DigitalOcean droplet with Apache reverse proxy + Let's Encrypt

### Newsdex Pipeline
```
MARC Export (.mrc) --> pymarc --> Jupyter Notebooks (field mapping) --> sqlite-utils --> SQLite --> Datasette
```
- Jupyter notebooks serve as both code AND documentation
- Key challenge: mapping decades of inconsistent MARC cataloging practices

### Datasette Startup (from IUG 2022)
```bash
venv/bin/datasette \
    --metadata=metadata.yaml \
    -i collection-2024-01-04.db \
    -i collection-2023-01-06.db \
    --crossdb \
    --setting hash_urls 1 \
    --setting default_page_size 100 \
    --setting sql_time_limit_ms 30000 \
    --setting allow_facet true \
    --setting num_sql_threads 20 \
    --setting base_url /home/ \
    --static static:static/ \
    --port 8010
```

---

## SQL Examples Worth Reusing

### Location Analysis (from IUG 2022)
```sql
select
  item.location_code,
  l.location_name,
  l.branch_name,
  count(*) as count_items,
  'https://collection-analysis.cincy.pl/current_collection/'
  || 'item_view?location_code__exact='
  || item.location_code as items_link
from
  item
  join location_view as l on l.location_code = item.location_code
where branch_name = :branch_name
group by 1, 2, 3
```

### Subject Search with Named Parameters (from IUG 2022)
```sql
where
(
  select value
  from json_each(bib.indexed_subjects)
) like '%' || :subject_like || '%'
```

---

## Contact & Presence

- GitHub: https://github.com/rayvoelker
- Presentations page: https://rayvoelker.github.io/
- CHPL GitHub orgs: https://github.com/cincinnatilibrary / https://github.com/plch
- Email: ray.voelker@gmail.com / ray.voelker@cincinnatilibrary.org

---

## Open Questions / Decisions Needed

- [ ] Presentation framework: Reveal.js again? Or try something new?
- [ ] Live demo vs. screenshots? (WiFi reliability at venue)
- [ ] How much overlap between Talk 1 and Talk 2? (If audience attends both)
- [ ] Should Talk 2 include a live Datasette instance with actual Newsdex data?
- [ ] Which Simon Willison videos to recommend (update from 2022 list)?
- [ ] Include the AI/LLM angle prominently or keep it brief?
- [ ] Datasette Lite demo -- worth doing live?
