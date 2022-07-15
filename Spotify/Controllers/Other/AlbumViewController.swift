//
//  AlbumViewController.swift
//  Spotify
//
//  Created by Fastick on 12.07.2022.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private let album: Album
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = .systemBackground
        
        ApiCaller.shared.getAlbumDetails(for: self.album) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    break
                case .failure(let error):
                    break
                }
            }
        }
    }
}
