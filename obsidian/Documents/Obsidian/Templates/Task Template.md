---
type: task
name: "{{title}}"
aliases: ["{{title}}"]
start_date: "{{date}}"
created: "{{date}}"
project: OMS
completed: false
tags:
  - OMS-TASK
---

# {{title}}

_Project:_ [[OMS]]/[[OMS-CORE]]. This task was created on [[{{date}}]].

## Notes

---

## Reference Links

```dataview
table without id file.inlinks
where file.name = this.file.name
sort file.name ASC
```
