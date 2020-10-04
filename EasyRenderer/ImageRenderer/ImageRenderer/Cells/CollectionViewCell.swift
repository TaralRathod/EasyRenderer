//
//  CollectionViewCell.swift
//  ImageRenderer
//
//  Created by Taral Rathod on 04/10/20.
//

import UIKit
import EasyRenderer

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: EasyRendererImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func awakeFromNib() {
        
    }

    func setupUI(photo: DisplayPhotoInfo) {
        self.cancelButton.isHidden = false
        let title = photo.title ?? ""
        nameLabel.text = title

        guard let  url = photo.url else {print("url is nil"); return}
        let placeholderImage = #imageLiteral(resourceName: "placeholder")
        imageView.getImageFor(url: url, placeholder: placeholderImage) { (image, error) in
            if error != nil {
                print ("Unable to load image due to \(String(describing: error?.localizedDescription))")
                DispatchQueue.main.async {
                    self.cancelButton.isHidden = true
                }
            } else {
                DispatchQueue.main.async {
                    self.cancelButton.isHidden = true
                }
            }
        }
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        imageView.cancelDownload()
    }
}
