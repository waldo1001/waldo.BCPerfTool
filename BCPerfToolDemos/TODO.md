TODO: 

Demos

Demo SetAutoCalcFields / CalcFields in loop


CU Size
How much impact does CU size have?


RecRef/FieldRef
Current state of RecordRef and FieldRef vs. Record performance?


Subscribers
I would suggest performance implications of event subscribers. For example, this MS article recommends to use single instance codeunits for subscribers:
https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/performance/performance-developer
Is the overhead of subscribers allocation/deallocation really that big?


TableExtensions
TODO: thoroughly test the impact of installing the next, and uninstalling (if any).
Prepare demo with 0, 2, 4, 6 and 7 table extensions