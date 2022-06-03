//
//  TabPageView.swift
//  whatDayIsToday
//
//  Created by USER on 2022/06/02.
//

import UIKit

class TabPageCustomView: UIView {
    private let cellID = "cellID"
    var selectIndex: ((_ index: Int) -> Void)?
    
    @IBOutlet var tabPageCollectionView: UICollectionView!

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .yellow
        nibInit()
        settingCollectionView()
    }
    private func settingCollectionView() {
        tabPageCollectionView.delegate = self
        tabPageCollectionView.dataSource = self
        tabPageCollectionView.register(UINib(nibName: "TabPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        // collectionViewを横スクロールにする。
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        tabPageCollectionView.setCollectionViewLayout(layout, animated: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func nibInit() {
        let nib = UINib(nibName: "TabPageCustomView", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        view.frame = bounds
        addSubview(view)
    }
}
extension TabPageCustomView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)as! TabPageCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectIndex?(indexPath.row)
    }
}
