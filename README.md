# The Movie Database assessment

## General:

A simple app that performs a search on the Movie Database according to user input and displays the results fetched from the TMDB API. On user selection, it then displays additional are and information for the selected movie.

The app as an assessment, limited by it's simplicity, is using th MVVM architecture along with other modules to fetch and store data from the internet and display them as list and further information upon selection.

Is written in Swift and using UIKit with Storyboards for it's Views and stores data in a generic memory object.

Has some simple unit testing checking the API, payload and parsing of data and the pagination (fetch consecutive data).

Does not use git (in its delivarable version) to minimize the zip file size. The file also does not contain Build, Derived Data and Intermediates.

No dependency managers were user. All code is written by me and much of it is based on the code repository I have created thoughout the years.

## Classes Description

### Model:

* **Objects**
  * **Search**: Contains the payload from the TMDB response
  * **Movie**: a struct object containing the necessary information for a single movie
  * **Genre** (file): Contains both genre payload (**GenreResponse**) and **Genre** Struct object to be used for naming moving genres
* **DataStore**: A generic memory store for the data been fetched from TMDB API. Under normal conditions, this would have been a SQLite/Realm database or Core Data.
* **DataAPI**: Constructs and returns the API endpoints for each data category:
  * *Movie Search*: Searches for movies given a search term,
  * *Genre*: Fetches all TMDB genres, stores them in memory and uses where necessary,
  * *Image*: Fetches a image type (backdrop or poster) for a given image path.
* **DataManager**: A class containing methods for fetching, parsing and storing data requested from the TMDB APi. Used for search movies, genres and Images. (*Note: Error handling has not been implemented in the assessment. If an error occurs, a debug message will be printed in the log*).

### Domain

The idea behind the Domain is that it may contain controllers for extra business and/or app logic. Given the simplicity of the assessment (and thus the lack of need for further controllers), the Domain contains only a GenreController that simply enumerates a movie's genres and convers the stored genre id into a genre-names string. 

Given that GenreController is used in multiple different parts of the app, it is not placed in a single VM and thus made accessible only to one VC.

### View

View contains several elements that make the app's UI:

* **Storyboards**: The soryboards with the VCs used in the app
* **Components**: Classes and objects that provide common and reusable code. In this case, *UITableView* cells and *cellForRow() UITableView* methods. The idea is to create cell temlplates to be reused multiple times in different controllers throughout the app (again, the assessment is too simple to justify that but I'm just exposing the idea).
* **View Models**: *SearchVM* and *MovieVM* contain methods that control the data flow between the Model (M) and the Views (V). A simple implementation of the MVVM architecture model.
* **ViewControllers**: The actual Views of the app. **SearchVC** and **MovieVC** are UITableViewControllers while *BackVC* and *ContentVC* are generic ViewControllers. BackVC is displayed as UITableView background of the SearchVC and follows it's own routing (thus the separate storyboard)
* **Delegates**: Only one delegate was needed in the assessment, where BackVC is a delegate of SearchVC, used to display/hide UITableView elements when there are no search results.

### System

System sections contains classes that  perform actions related closely to the OS and/or extends/subclasses/enhances iOS SDK classes for the purposes of the app:

* **Network**: A simple networking class fetching data and performing basic checks (A normal app networking module is far more complicated and extended that what is used here)
* **UIImageView extension**: Adding getImage() and swapImage() functions to fetch an image from the internet and perform an animation in replacing a (placeholder) image with another.
* **MDDate**: With *DateFormatter* being an expensive allocation when used for each UItableViewCell, a shared instance initialiing a DateFormatter once with specific parameters is used across the app to cover the needs of all date conversions and formatting from the API date string into the app's desired format.