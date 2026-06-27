---
type: meeting
created: "{{date}}"
date: "{{date}}"
name: "{{title}}"
aliases: ["{{title}}"]
project: OMS
occurrence:
optional:
day:
tags:
  - meeting
---

# {{title}}

## Purpose

_Project:_ OMS
_Date:_ [[{{date}}]]

## Attendees

```dataview
list
where type="person"
```

## Reference Links

```dataview
table without id file.inlinks
where file.name = this.file.name
sort file.name ASC
```
