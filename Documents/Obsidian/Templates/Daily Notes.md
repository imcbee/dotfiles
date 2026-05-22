---
type: daily-notes
tags: [daily-notes, <%tp.date.now("YYYY")%>-quarter-<%tp.date.now("Q")%>]
date: <% tp.config.target_file.basename %>
created: <% tp.date.now("YYYY-MM-DD") %>
aliases:
  - <%tp.date.now("dddd Do MMMM YYYY")%>
  - <%tp.date.now("ddd Do MMM YYYY")%>
---
---
# <% tp.config.target_file.basename %>  Notes
 << [[<% tp.date.now("YYYY-MM-DD", -1) %>]] | [[<% tp.date.now("YYYY-MM-DD", 1) %>]] >>

--vod 

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
table state, priority, start_date, url
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
[[John Urban|John]]:
- 
[[James Ferro|James]]:
- 
[[Dillion McLaughlin|Dillion]]:
- 
[[Patton Nelson]]:
- 
[[Tarek Shah]]:
- 
[[Ian McBee]]:
- 

### Round 2s
- 

## [[ATOMS "Standup of Standups"]]
- 

### Second Rounds & Program Updates
- 

---
