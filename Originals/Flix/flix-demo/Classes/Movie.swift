import UIKit

public class Movie {
    var title: String
    var overview: String
    var releaseDate: String
    var backdropUrl: URL?
    var posterUrl: URL?
    let baseUrlString = "https://image.tmdb.org/t/p/w500"
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        releaseDate = dictionary["release_date"] as? String ?? "No release date"
        let backdrop = baseUrlString + (dictionary["backdrop_path"] as! String)
        let poster = baseUrlString + (dictionary["poster_path"] as! String)
        backdropUrl = URL(string: backdrop)
        posterUrl = URL(string: poster)
    }
    
    class func populateMovies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }

}


