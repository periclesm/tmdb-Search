# The Movie Database Search

## General:

An app performing a search on the Movie Database according to user input and displays results from the TMDB API. Then, on user selection, it shows additional information for the selected movie.

Is written in Swift and using UIKit with Storyboards for it's views and stores data in a generic memory object.

Has some simple unit testing checking the API, payload and parsing of data and the pagination (fetch consecutive data).


## Classes Description

### Model:

* **Objects**
  * *SearchResponse* and *GenreResponse*: Contains the payload from the TMDB response.
  * *Movie*: a struct object containing the necessary information for a single movie.
  * *Genre*: Contains the **Genre** Struct object to be used for naming moving genres.
* **DataStore**: A generic memory store for the data been fetched from TMDB API. On a larger app, this would have been a SQLite/Realm database or Core Data.
* **DataAPI**: Constructs and returns the API endpoints for each data category:
  * *Movie Search*: Searches for movies given a search term,
  * *Genre*: Fetches all TMDB genres, stores them in memory and uses where necessary,
  * *Image*: Fetches an image type (backdrop or poster) for a given image path.
* **DataManager**: A class containing methods for fetching, parsing and storing data requested from the TMDB API. Used for search movies, genres and images. (*Note: Error handling has not been implemented in the assessment. If an error occurs, a debug message will be printed in the log*).

### View

View contains several elements that make the app's UI:

* **Storyboards**: The storyboards with the VCs used in the app.
* **Components**: Classes and objects that provide common and reusable code. In this case, *UITableView* cells and *cellForRow() UITableView* methods. The idea is to create cell templates to be reused multiple times in different controllers throughout the app (again, the assessment is too simple to justify that but I'm just exposing the idea).
* **View Models**: *SearchVM* and *MovieVM* contain methods that control the data flow between the Model (M) and the Views (V). A simple implementation of the MVVM architecture model.
* **ViewControllers**: The actual Views of the app. **SearchVC** and **MovieVC** are UITableViewControllers while **BackVC** and **ContentVC** are generic ViewControllers. BackVC is displayed as UITableView background of the SearchVC and follows it's own routing (thus the separate storyboard)
* **Delegates**: Only one delegate was needed in the assessment, where BackVC is a delegate of SearchVC, used to display/hide UITableView elements when there are no search results.

### System

System section contains classes performing actions related closely to the OS and/or extending/subclassing/sharing iOS SDK classes for the purposes of the app:

* **Network**: A simple networking class fetching data and performing basic checks.
* **UIImageView extension**: Adding *getImage*() and *swapImage*() functions to fetch an image from the internet and perform an animation in replacing a (placeholder) image with another.
* **MDDate**: With *DateFormatter* being an expensive allocation when used for each UITableViewCell, a shared instance initialiing a DateFormatter once with specific parameters is used across the app to cover the needs of all date conversions and formatting from the API date string into the app's desired format.
