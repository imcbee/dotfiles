---
banner: "![[porco rosso_cliff.png]]"
banner_x: 0
banner_y: 0.15269
banner_lock: true
cssclasses:
  - wide-page
---
> [!multi-column] Tasks
> > [!todo] **Tasks**
> > # <u>General Tasks</u>
>> ```tasks
>>not done
>>tags do not include #OMS-TASK
>>path does not include OMS/
>> ```
> > <br>
> > 
> > # <u>OMS-Tasks</u>
>> ```dataview
>>table state, start_date
>>where type = "task" and file.name != "Task Template" and completed = false
>> ```
> > <br>
> > 
> > # <u>Reminders</u>
>>```dataviewjs
>>dv.pagePaths('"OMS/Reminders"').forEach(pagePath => {  
>>	dv.paragraph("![["+pagePath+"]]")  
>>})
>>```

> [!multi-column] Summary
> > [!success |wide-4 min-0] **Contribution**
>>```contributionGraph
>>title: Obsidian Heat Map
>>graphType: default
>>dateRangeValue: 360
>>dateRangeType: LATEST_DAYS
>>startOfWeek: 0
>>showCellRuleIndicators: true
>>titleStyle:
>>  textAlign: left
>>  fontSize: 30px
>>  fontWeight: normal
>>dataSource:
>>  type: PAGE
>>  value: ""
>>  dateField: {}
>>fillTheScreen: false
>>enableMainContainerShadow: true
>>cellStyleRules:
>>  - id: 1724115409974
>>    min: 1
>>    max: "15"
>>    color: "#019131ff"
>>    text: ""
>>  - id: 1724115427584
>>    min: "15"
>>    max: "30"
>>    color: "#18b55dff"
>>    text: ""
>>  - id: 1724115437365
>>    min: "30"
>>    max: "50"
>>    color: "#3be084ff"
>>    text: ""
>>  - id: 1724115462228
>>    min: "50"
>>    max: "1000"
>>    color: "#8afebfff"
>>    text: ""
>>
>>```
> 
> > [!note|wide-2 min-0] **Commands**
>> ```button
>> name Open today's daily note
>> type command
>> action Daily notes: Open today's daily note
>> ```
>>```button
>> name Verse of the Day
>> type command
>> action Bible Reference: Verse Of The Day - Notice (10 seconds)
>> ```
>>```button
>> name Vault Search
>> type command
>> action Omnisearch: Vault Search
>> ```
>>```button
>> name Refresh Vault Index
>> type command
>> action Copilot: Index (refresh) vault
>> ```
>

> [!multi-column] Recent
> > [!info] **Recently Modified**
>> ```dataview
>>TABLE WITHOUT ID link(file.link, title) AS "File", file.mtime AS "Time"
>>  FROM -"Images"
>>SORT file.mtime DESC
>>LIMIT 5
>>```
> 
> > [!info] **Recently Created**
>> ```dataview
>>  TABLE WITHOUT ID link(file.link, title) as "File", file.ctime AS "Time"
>>  FROM -"Images"
>>  SORT file.ctime DESC 
>>  LIMIT 5
>> ```