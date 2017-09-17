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

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    @IBAction func segmentControlTapped(_ sender: UISegmentedControl) {
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
    }
}

extension AvatarVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReusableCell.avatarCell.rawValue, for: indexPath) as? AvatarCell {
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
