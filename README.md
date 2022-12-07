Video Link: https://youtu.be/gW0iUTBfbZU 

Say, for instance, a group of three friends make plans to go to the gym together early tomorrow morning. They each live in a different dorm, all about the same distance from the gym, so they plan to all wake up at the same time. However, they have a problem: they all have incredibly poor will power, and none of them can be trusted to reliably wake themselves up that early in the morning. They need a way to hold each other accountable; and this is where Wakey comes in. 

Wakey is an iOS app that functions as follows:
	
All members of a group who plan to wake up together (albeit in different locations) download the app. One user creates a new alarm by designating a wake-up time and giving the alarm a unique code. Other members of the group open the app and join the same alarm by inputting the code set by the alarm creator and pressing the join button. Once this is done, the users’ alarms have been linked and synced, and the next morning, they will all go off at the same time. When this happens, users who wake up can turn off their own alarm, which brings them to a soundboard screen. By pressing buttons on the soundboard, obnoxious sounds will ring out from the phones of all other members of the group who have yet to turn off the alarm. 
	
A few words about how we made the app and how to access its files:

We created this IOS app in Swift using Xcode. We also used JavaScript to create a server that handles the soundboard function, receiving input from users who have woken up, and directing this data to the phones of users who have yet to wake up, producing sound in real time. Finally, we used a Firebase database in order to manage the time and code of the various alarms, and to allow different users to join them. We have submitted a folder with our Swift code, along with our Javascript code that creates and manages the server. Unfortunately, the Firebase database cannot be so easily exported or downloaded, nor can it be so easily accessed by third parties as it exists only on the Google account of one of our group members (We included an example of the database in the submission folder, but because it is constantly updating it is not accurate). However, the app should still be able to be tested by graders (disclaimer: we have not tested it on other Mac computers.) 

In order to test our code, the user would need to have Xcode installed. Once Xcode is installed, open up our Wakey project. The “SocketHandler” file needs to be edited so that the socketURL string (for example it might be "http://172.20.10.5:3000") should reflect the url of the localhost or the url of the network. Accordingly, the file called “server.js” in the Server folder also has to be edited to reflect this change. The two variables “var IP” and “var PORT” should be updated accordingly. The node.js server can be run with the command “node server.js”. After, on Xcode, the project can be built to a specific iPhone emulator on the Mac, or a real iPhone that is connected to the computer. Once the project is built, the app can be run. Access to the Firebase is not required because the code automatically uploads the necessary information to the Firebase.
