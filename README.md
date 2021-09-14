# PlantBit
The FitBit for Plants

PlantBit is a 24 hour hackathon project that implements a plant health monitoring system integrated with regulation tools implemented for Google Mini or remotely through an iPhone app. Multiple metrics of the plant's environment including temperature, soil moisture, and light levels are recorded and accessible through interfaces on the Google Mini and iPhone app, upon which the user can use to determine the length of photoperiods as well as watering cycles. 

--- 

## Tech stack 
As a team with four members, the work was split into four components. 

First, an arduino was connected to the plant to monitor various metrics on the plant's health and environment. 

Second, a central database was constructed using Firebase to store the information in a way that was easily accessed and stored. As an "online" system, one challenge was to create the database so that it would only store all information in a working day, then translate only the most relevant data each day to long term storage.

Third, an interface for Google Mini to access the data as well as control the arduino was created. As we were all new to working with Google Mini, coming up with effective voice interfaces was a challenge, as well as connecting the backend logic to do what we wanted correctly. 

Finally, a remote iPhone app was created with a similar purpose as the Google Mini, just as a separate interface. We were all new to working with Swift as well, so figuring out how to create an app interface that did what we wanted to was a challenge, as was the backend logic. 

