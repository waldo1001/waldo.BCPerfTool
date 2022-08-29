TODO: 

Demos

TODO: IncludedFields


TempTable vs Real table
For example, I will have a customer PTE where they'll collate information into tables, then transact on those lines - things like incoming files that create Sales/Purchase Documents.  They will have a buffer header table and buffer lines.   They *should* be marked Temporary, as they're only records needed during the transaction processing.  They complained of speed problems, and it turns out, it was real tables.  Much much slower.
So, I know there are partners out there that don't use TableType temporary and should.  For a talk, I'd make a routine that generates 1k, 5k, 25k records into a real table and a temporary, and just show the comparison between the two.  I'd probably also show a slide showing the read difference if doing a basic looping operation through them.
TODO: Subscribers



Questions AJ:
- Docker / Hetzer - aanbieden van omgevingen

