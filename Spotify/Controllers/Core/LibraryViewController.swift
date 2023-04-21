//
//  LibraryViewController.swift
//  Spotify
//
//  Created by Fastick on 30.06.2022.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private let playlistsVC = LibraryPlaylistsViewController()
    private let albumsVC = LibraryAlbumsViewController()
    
    var toggleView = LibraryToggleView()
    
    private  let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.width * 2, height: scrollView.heigth)
        addChildren()
        view.addSubview(scrollView)
        
        view.addSubview(toggleView)
        toggleView.delegate = self
     
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        toggleView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: 200, height: 55)
        scrollView.frame = CGRect(x: 0, y: toggleView.bottom, width: view.width, height: view.heigth - view.safeAreaInsets.bottom - view.safeAreaInsets.top - 55)
    }
    
    private func addChildren() {
        addChild(playlistsVC)
        scrollView.addSubview(playlistsVC.view)
        playlistsVC.view.frame = scrollView.bounds
        playlistsVC.didMove(toParent: self)
        addChild(albumsVC)
        scrollView.addSubview(albumsVC.view)
        albumsVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.heigth)
        albumsVC.didMove(toParent: self)
    }
}

extension LibraryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.width - 100) {
            toggleView.update(for: .album)
        } else {
            toggleView.update(for: .playlist)
        }
    }
}

extension LibraryViewController: LibraryToggleViewDelegate {
    func libraryToggleViewDidTapPlaylists() {
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    func libraryToggleViewDidTapAlbums() {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
    }
}
