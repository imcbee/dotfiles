---
type: task
name: <% tp.file.title %>
aliases: []
start_date: <% tp.date.now() %>
created: <% tp.date.now() %>
project: OMS
tags:
  - OMS-TASK
  - OMS
  - OMS-CORE
---
# <% tp.file.title %>
## Description
*Project:* [[OMS]]/[[OMS-CORE]]. This task was created on [[<% tp.date.now() %>]].
*Issue:* 



### Sub-tasks
-

### Updates
- 

## Resources
- 

---
## Reference Links
```dataview
table without id file.inlinks
where file.name = this.file.name
sort file.name ASC
```
