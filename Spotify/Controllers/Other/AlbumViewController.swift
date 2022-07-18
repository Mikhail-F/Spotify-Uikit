//
//  AlbumViewController.swift
//  Spotify
//
//  Created by Fastick on 12.07.2022.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private let album: Album
    
    private var viewModels = [RecommendedTrackCellViewModel]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout{sectionIndex, _ -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
            
            let groupe = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(60)
                ),
                subitem: item,
                count: 1
            )
            
            let section = NSCollectionLayoutSection(group: groupe)
            // Добавляем сворачивающийся хедер
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(0.6)
                    ),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            ]
            return section
            }
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlbumTrackCollectionViewCell.self, forCellWithReuseIdentifier: AlbumTrackCollectionViewCell.identifier)
        collectionView.register(PlaylistHeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier
        )
        ApiCaller.shared.getAlbumDetails(for: self.album) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    self.viewModels = value.tracks.items.compactMap{
                        RecommendedTrackCellViewModel.init(
                            name: $0.name,
                            artworkURL: URL(string: $0.album?.images.first?.url ?? ""),
                            artistrName: $0.artists.first?.name ?? ""
                        )
                    }
                    self.collectionView.reloadData()
                case .failure(let error):
                    break
                }
            }
        }
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
                                                            
//    @objc private func didTapShare() {
//        guard let url = URL(string: "https://www.youtube.com/watch?v=VJhRnWd9tTM&list=LL&index=1&t=1083s") else {
//            return
//        }
//
//        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
//
//        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
//        present(vc, animated: true)
//    }
}

extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumTrackCollectionViewCell.identifier, for: indexPath)  as? AlbumTrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let model = viewModels[indexPath.row]
        cell.configure(viewModel: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier, for: indexPath) as? PlaylistHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let headerViewModel = PlaylistHeaderViewModel(
            name: album.name,
            ownerName: album.artists.first?.name,
            description: "Release Date: \(album.release_date.formattedDateString)",
            artworkURL: URL(string: album.images.first?.url ?? "")
        )
        header.configure(with: headerViewModel)
        header.delegate = self
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension AlbumViewController: PlaylistHeaderCollectionReusableViewDelegate{
    func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView) {
        print("Playing all")
    }
}
