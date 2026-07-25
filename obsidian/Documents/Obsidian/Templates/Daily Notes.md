---
type: daily-notes
tags: [daily-notes, "{{year}}-quarter-{{quarter}}"]
date: "{{title}}"
created: "{{date}}"
aliases:
  - "{{long_alias}}"
  - "{{short_alias}}"
---

# {{title}} Notes

<< [[{{yesterday}}]] | [[{{tomorrow}}]] >>

{{vod}}

---

## Tasks

### General Tasks

```tasks
not done
tags do not include #OMS-TASK
path does not include OMS/
```

### ATOMS-Tasks

```dataview
table start_date
where type = "task" and file.name != "Task Template" and completed = false
```

## Articles to Read

```dataview
table read
where type="read" and read=false
```

## [[Reminders]]

```dataviewjs
dv.pagePaths('"OMS/Reminders"').forEach( line => {
 dv.paragraph("![["+line+"]]")
})
```

## [[MARS-OMS Running Questions]]

```dataviewjs
dv.pagePaths('"OMS/MARS-OMS Running Questions"').forEach( line => {
 dv.paragraph("![["+line+"]]")
})
```

---

## Standups

### [[OMS Core Daily Standup]] [[API-TEAM-2]]

| Person                         | Round 1 | Round 2 |
| ------------------------------ | ------- | ------- |
| [[John Urban]]                 |         |         |
| [[James Ferro\|James]]         |         |         |
| [[Dillon McLaughlin\|Dillion]] |         |         |
| [[Patton Nelson]]              |         |         |
| [[Tarek Shah]]                 |         |         |
| [[James Ayres]]                |         |         |
| [[Ian McBee]]                  |         |         |

### [[ATOMS "Standup of Standups"]]

-

### Second Rounds & Program Updates

---
