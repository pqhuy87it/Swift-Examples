
import UIKit

class CoverStory: UICollectionViewCell , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
	
	let coverStoryCellID = "coverStoryCellID"
	
	lazy var coverStoryCollectionView: UICollectionView = {
		let flowLayout     = UICollectionViewFlowLayout()
		flowLayout.minimumInteritemSpacing  = 15
		flowLayout.minimumLineSpacing       = 25
		flowLayout.scrollDirection = .vertical
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
		collectionView.backgroundColor = .white
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
		collectionView.alwaysBounceVertical = false
		collectionView.alwaysBounceHorizontal = false
		collectionView.allowsSelection = true
		collectionView.isScrollEnabled = false
		collectionView.showsVerticalScrollIndicator = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.configureCollectionView()
	}
	
	private func configureCollectionView() {
		
		addSubview(coverStoryCollectionView)
		
		coverStoryCollectionView.register(CoverStoryDetailCell.self, forCellWithReuseIdentifier: coverStoryCellID)
		coverStoryCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
		coverStoryCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
		coverStoryCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		coverStoryCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

extension CoverStory {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return numberOfCoverStories
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let coverStoriesCell: CoverStoryDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.coverStoryCellID, for: indexPath) as! CoverStoryDetailCell
		return coverStoriesCell
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: UIScreen.main.bounds.width - 220.0, height: coverStoryCellHeight)
	}
}


