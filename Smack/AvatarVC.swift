//
//  AvatarVC.swift
//  Smack
//
//  Created by Matt Deuschle on 9/17/17.
//  Copyright © 2017 Matt Deuschle. All rights reserved.
//

import UIKit

class AvatarVC: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var segmentControl: UISegmentedControl!

    var avatarType = AvatarType.light

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 0 {
            avatarType = .light
        } else {
            avatarType = .dark
        }
        collectionView.reloadData()
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
    }
}

extension AvatarVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColums: CGFloat = 3
        if UIScreen.main.bounds.width > 320 {
            numberOfColums = 4
        }
        let spaceBetweenCells: CGFloat = 10
        let padding: CGFloat = 40
        let cellDiminsion = ((collectionView.bounds.width - padding) - (numberOfColums - 1) * spaceBetweenCells) / numberOfColums
        return CGSize(width: cellDiminsion, height: cellDiminsion)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.shared.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.shared.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        dismiss(animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReusableCell.avatarCell.rawValue, for: indexPath) as? AvatarCell {
            cell.configCell(avatarType: avatarType, index: indexPath.item)
            return cell
        }
        return AvatarCell()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }

}
