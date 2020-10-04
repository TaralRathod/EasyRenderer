//
//  ViewModel.swift
//  ImageRenderer
//
//  Created by Taral Rathod on 04/10/20.
//

import Foundation

struct DisplayPhotoInfo {
    var url: String?
    var title: String?
}

protocol ViewModelProtocol {
    func dataFetchedSuccessfully(photosInfo: [DisplayPhotoInfo])
    func fetchedWithError()
}

class ViewModel: ViewModelProtocol {

    var delegate: ViewModelProtocol?
    var photoList: [DisplayPhotoInfo] = [DisplayPhotoInfo]()

    public init(delegate: ViewModelProtocol) {
        self.delegate = delegate
    }

    public func getPhotoFeeds() {
        let urlString = String(format: NetworkConstants.baseURL, arguments: [FlickerMethods.getRecents.rawValue, FlickerConstants.apiKey])
        guard let url = URL(string: urlString) else {print("URL is Not valid"); return}
        DataTaskManager().executeRequest(For: url) { (model, error) in
            if error == nil {
                guard let model = model else {print("Invalid Model"); return}
                self.createDisplayInfoFrom(model: model)
                self.dataFetchedSuccessfully(photosInfo: self.photoList)
            } else {
                self.fetchedWithError()
            }
        }
    }

    public func getPhotoSearchResults(searchString: String) {
        let urlString = String(format: NetworkConstants.baseURL, arguments: [FlickerMethods.search.rawValue, FlickerConstants.apiKey]) + "&text=\(searchString)"
        guard let url = URL(string: urlString) else {print("URL is Not valid"); return}
        DataTaskManager().executeRequest(For: url) { (model, error) in
            if error == nil {
                guard let model = model else {print("Invalid Model"); return}
                self.createDisplayInfoFrom(model: model)
                self.dataFetchedSuccessfully(photosInfo: self.photoList)
            } else {
                self.fetchedWithError()
            }
        }
    }

    func createDisplayInfoFrom(model: DataModel) {
        photoList.removeAll()
        guard let photosModel = model.photos else {print("photos not available"); return}
        guard let photos = photosModel.photo else {print("photo array not available"); return}

        for photo in photos {
            let url = generateURLFor(photo: photo)
            let title = photo.title ?? ""
            let info = DisplayPhotoInfo(url: url, title: title)
            photoList.append(info)
        }
        
    }

    func generateURLFor(photo: PhotoModel) -> String {
        guard let server = photo.server else {print("Server Not available"); return ""}
        guard let id = photo.id else {print("id Not available"); return ""}
        guard let secret = photo.secret else {print("secret Not available"); return ""}
        return NetworkConstants.photosBaseURL + server + StringKey.slash + id + StringKey.underScore + secret + StringKey.underScore + StringKey.sizeQ + StringKey.jpg
        
    }

    // MARK:- ViewModelProtocolDelegates
    func dataFetchedSuccessfully(photosInfo: [DisplayPhotoInfo]) {
        delegate?.dataFetchedSuccessfully(photosInfo: photosInfo)
    }
    
    func fetchedWithError() {
        delegate?.fetchedWithError()
    }
}
