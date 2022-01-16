# Countries
## Take home project for adesso Turkey.
This project was a fun experiment for me to recall my UIKit skills since I've been using SwiftUI for quite some time lately. I tried to follow MVVM architecture with the help of delegation pattern. I didn't use storyboards except the launch screen. Every screen is created programmatically with the help of auto layout. I added loading indicators, a simple label for handling empty state, pull-to-refresh functionality, swipe getures, a fine button animation, safari view controller and some more good stuff like these. Do not hesitate to fork it, clone it and play around with it!

>When I thought I finished the project something went wrong and removed the project from the local repo. Thanks to Git and GitHub I was able to use copy of my project but there was an another issue: I accidently ignored the important part of the project while I first initialized Git so project didn't work when I cloned the remote repo and tried to run it. I created a new local repo and carried the old project inside the new project. So excuse me for bad commits in this project. If you want to see the old project and its commits I'll be happy to help.

### Usage
First, you need to create an account and get a key from [here](https://rapidapi.com/wirefreethought/api/geodb-cities). I created a constants file and ignored it for hiding my personal api key. In order to run the project successfully you need to create something like this below.
```
enum K {
    static let BASE_URL = "wft-geo-db.p.rapidapi.com/v1"
    static let API_KEY = "pJnObC09yXmshSQlCdrincRoV6skp"
}
```
Also do not forget to install [SDWebImage](https://github.com/SDWebImage/SDWebImage) and [SDWebImageSVGCoder](https://github.com/SDWebImage/SDWebImageSVGCoder) so that you can download SVG flag images from the network and show them to the user. 

---

### Home Screen
1. Users can add a country to the saved list. ✅
2. Users can remove a country from the saved list. ✅
3. User can go to the detail card by selecting a country. ✅

### Detail Screen
1. User needs to be able to see country flag on top of the screen. ✅
2. User needs to be able to see country code. ✅
3. User should be navigated to **Wikidata** by clicking *"For More Information"* button. ✅
4. User should be able to add the country to saved list and remove the country from saved list. ✅
5. Favorite button’s color should be changed according to whether it’s in saved list or not. ✅

### Saved Screen
1. User should be able to see saved countries. ✅
2. User can go to the detail screen from here. ✅
3. User needs to be able to remove the country from saved list. ✅

---

### General rules
- Third party libraries are allowed. (CocoaPods, SPM or Carthage) ✅ 
- You need to upload the project to your github page. ✅
- You have 5 days to deliver us the project after getting this document. ✅
- Project name should be “Countries”. ✅
- Project is expected to be implemented with Xcode 13. ✅

### Nice to haves
- Unit tests are optional but you can get extra points. 🏳️
- It would be good to have a README file. Having any documentation is awesome! ✅
