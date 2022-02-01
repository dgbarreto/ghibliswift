//
//  MovieCollectionViewController.swift
//  ghibli
//
//  Created by Danilo Barreto on 13/01/22.
//

import Foundation
import UIKit

class MovieCollectionViewController : UIViewController, UICollectionViewDataSource{
    var movies : Array<Movie> = []
    @IBOutlet weak var moviesDeck: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        movies = [ Movie(id: "", title: "", image: "", description: ""), Movie(id: "", title: "", image: "", description: ""), Movie(id: "", title: "", image: "", description: "")]

            Task{
                await loadData()
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MovieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCell
        let movieItem = movies[indexPath.row]

//        cell.AlbumImage?.image = UIImage(named: "cover.jpg")
        guard let url = URL(string: movieItem.image) else { return UICollectionViewCell() }
        
        downloadImage(from: url, imageView: cell.AlbumImage!)
        cell.Title?.text = movieItem.title
        cell.movieDetails = movieItem
        return cell
    }
    
    func loadData() async{
        guard let url = URL(string: "https://ghibliapi.herokuapp.com/films") else {
            print("URL inválida")
            return
        }
        
        do{
            let(data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Array<Movie>.self, from: data){
                DispatchQueue.main.async {
                    self.movies = decodedResponse
                    self.moviesDeck?.reloadData()
                }
            }
        } catch {
            print("Chamada de API inválida")
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, imageView image: UIImageView){
        getData(from: url){
            data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                image.image = UIImage(data: data)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieCell = sender as! MovieCell
        let destinationVC = segue.destination as! MovieDetailViewController
        destinationVC.movieDetails = movieCell.movieDetails
        destinationVC.image = movieCell.AlbumImage?.image
    }
}
