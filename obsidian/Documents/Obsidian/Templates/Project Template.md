---
type: project
created: "{{date}}"
name: "{{title}}"
aliases: []
tags:
  - { { title } }
  - OMS
---

---

# {{title}}

## About

## Teams

```dataview
list
where type="person" and team="<% tp.file.title %>"
```

## Reference Links

```dataview
table without id file.inlinks
where file.name = this.file.name
sort file.name ASC
```
