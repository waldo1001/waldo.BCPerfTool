# WALDO.BCPERFTOOL
## Resources

Webinar: Demo of app during BC Techdays 2022: 
https://www.youtube.com/watch?v=E3ADZsisFbE

Webinar: The less familiar performance tooling
https://www.youtube.com/watch?v=_V0hepCRrkA


## Installation
To run all the demo examples
1. Create a docker container expected in launch.json or add your own configuration to each launch.json or change the settings in the powershellscripts in folder BCPerfToolDemos_Scripts.
2. Publish each app to target container manually or via ps scripts in folder BCPerfToolDemos_Scripts.
3. Demo data is installed via job queue. If not job queue is activated in your container then run the job queue transactions in the foreground or run the following codeunits manually:
    - InstallBigTableWPT.Codeunit.al
    - InstallBigExtTable1WPT.Codeunit.al
    - InstallBigExtTable2WPT.Codeunit.al
    - InstallBigExtTable3WPT.Codeunit.al
    - InstallBigExtTable4WPT.Codeunit.al


    
