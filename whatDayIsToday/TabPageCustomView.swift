//
//  TabPageView.swift
//  whatDayIsToday
//
//  Created by USER on 2022/06/02.
//

import UIKit

class TabPageCustomView: UIView {
    // MARK: -Properties
    private let cellID = "cellID"
    private var currentIndex = 0
    private var itemSize: CGSize!
    private let column = 2
    private let tabTitle = ["出来事", "誕生日"]
    var selectIndex: ((_ index: Int) -> Void)?
    // MARK: -Outllet, Action
    @IBOutlet var tabPageCollectionView: UICollectionView!
    // MARK: -LifeCycle Methods
    init(size: CGSize) {
        super.init(frame: .zero)
        itemSize = size
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
        layout.itemSize = CGSize(width: itemSize.width / CGFloat(column), height: itemSize.height)
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
        column
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)as! TabPageCollectionViewCell
        let parentVC = parentViewController as! TabPageViewController
        // 現在のvcのインデックスを取得
        parentVC.currentIndex = { index in
            self.currentIndex = index
        }
        cell.tabPageLabel.textColor = indexPath.row == currentIndex ? .red : .black
        cell.tabPageLabel.text = tabTitle[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //　選択したtabのインデックスをクロージャに渡す
        selectIndex?(indexPath.row)
    }
}
