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

--- 

## Implementation and Short Demo 
Since this was a short (24 hour) hackathon, our demo was created to just simulate the control of more extensive components like large plant grow lights and watering systems. Because of these limitations, we used LED lights to simulated each of these operations, and modeled our project so that the LED lights simulated these operations being run. 

The following is a demo of the Google Mini voice interface and how it was used to control the light control managed by the Arduino. 

https://user-images.githubusercontent.com/15336313/133172685-4b316f0a-a8c4-4c88-92c1-fa248ab7f089.mp4

--- 

## Potential Improvements 
As this was just a demo, there is a lot of room for improvements as well as required implementation to make it a fully working product. To start with, we need access to some tools to allow our Arduino to control the larger systems we have in mind. Beyond this, more work is required on both the Google Mini app and the iPhone app, as both are only focused on implementing the required controls, rather than user experience. 

