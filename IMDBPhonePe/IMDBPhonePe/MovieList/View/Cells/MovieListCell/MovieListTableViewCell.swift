//
//  MovieListTableViewCell.swift
//  IMDBPhonePe
//
//  Created by Ravneet Arora on 23/09/23.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var playlist: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(movie: Movie) {
        self.name.text = movie.name
        self.rating.text = "Rating - \(movie.rating ?? 0)"
        if let url = URL(string: "\(URLList.imageBaseURL)/\(movie.imageURL ?? "")") {
            loadImage(imageUrl: url)
        }
    }
    
    func loadImage(imageUrl: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.moviePoster.image =  image
                }
            }
        }
        
    }
}
