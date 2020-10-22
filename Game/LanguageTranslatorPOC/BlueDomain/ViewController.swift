//
//  ViewController.swift
//  BlueDomain
//
//  Created by Faizyy on 25/03/20.
//  Copyright © 2020 faiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	// Constants
	fileprivate let kMinimumCellWidth: CGFloat = 55.0
	fileprivate let kDefaultCellPadding: CGFloat = 20

	let translationsDict = [
		"Bonjour": "good morning",
		"quel est votre nom": "what is your name",
		"Comment ça va": "how are you",
		"Comment est la vie": "how is life",
		"je vais bien": "I am fine",
	]

	var source:[String] = []
	var sourceOptions: [String] = []

	@IBOutlet weak var checkButton: UIButton!
	@IBOutlet weak var optionsWordCollection: UICollectionView!
	@IBOutlet weak var selectedWordsCollection: UICollectionView!
	@IBOutlet weak var speaker: UIButton!
	@IBOutlet weak var foreignLanguageLabel: UILabel!

	var alertView: UIView {
		let calculatedHeight = self.view.frame.height / 6

		let aView = UIView(frame: CGRect(x: self.view.frame.minX, y: self.view.frame.maxY-calculatedHeight, width: self.view.frame.width, height: calculatedHeight))
		aView.backgroundColor = UIColor(red:0.85, green:1.00, blue:0.72, alpha:1.00)

		let label = UILabel(frame: CGRect(x: 17, y: 20, width: self.view.frame.width, height: 30))
		let labelColor = UIColor(red:0.35, green:0.65, blue:0.00, alpha:1.00)
		label.text = "You are correct"
		label.textColor = labelColor
		label.font = UIFont(name: "ArialHebrew-Bold", size: 25)

		let imageView = UIImageView(frame: CGRect(x: self.view.frame.maxX-50, y: 20, width: 25, height: 25))
		let image = UIImage(systemName: "checkmark.square.fill")
		imageView.tintColor = labelColor
		imageView.image = image

		aView.addSubview(imageView)
		aView.addSubview(label)

		return aView
	}

	@IBAction func checkAnswer(_ sender: Any) {

		let question = foreignLanguageLabel.text ?? ""
		let answer = source.joined(separator: " ")

		if translationsDict[question] == answer {
			self.view.insertSubview(self.alertView, belowSubview: self.checkButton)
			checkButton.setTitle("CONTINUE", for: .normal)
			checkButton.isEnabled = false
		}
	}

	func setupSpeakerButton() {
		speaker.layer.cornerRadius = 15
		speaker.backgroundColor = UIColor(red:0.13, green:0.69, blue:0.97, alpha:1.00)
		speaker.layer.borderColor = UIColor.clear.cgColor
		speaker.layer.borderWidth = 1
		speaker.layer.masksToBounds = false
		speaker.layer.shadowOpacity = 0.9
		speaker.layer.shadowColor = UIColor(red:0.09, green:0.60, blue:0.84, alpha:1.00).cgColor
		speaker.layer.shadowRadius = 0
		speaker.layer.shadowOffset = CGSize(width: 0, height: 5)
	}

	func setupDelegateAndDatasource() {
		selectedWordsCollection.delegate = self
		selectedWordsCollection.dataSource = self
		selectedWordsCollection.isScrollEnabled = false
		selectedWordsCollection.dragInteractionEnabled = true
		selectedWordsCollection.dragDelegate = self
		selectedWordsCollection.dropDelegate = self

		optionsWordCollection.delegate = self
		optionsWordCollection.dataSource = self
		optionsWordCollection.isScrollEnabled = false
	}

	func setupCheckButton() {
		checkButton.backgroundColor = UIColor(red:0.35, green:0.80, blue:0.01, alpha:1.00)
		checkButton.layer.masksToBounds = false
		checkButton.layer.shadowColor = UIColor(red:0.35, green:0.66, blue:0.01, alpha:1.00).cgColor
		checkButton.layer.shadowOpacity = 1
		checkButton.layer.shadowRadius = 0
		checkButton.layer.shadowOffset = CGSize(width: 0, height: 3)

	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		setupSpeakerButton()
		setupCheckButton()
		setupDelegateAndDatasource()

		selectedWordsCollection.collectionViewLayout = LeftAlignedCollectionViewFlowLayout()
		optionsWordCollection.collectionViewLayout = CenterAlignedCollectionViewFlowLayout()

		let randomElement = translationsDict.randomElement()
		foreignLanguageLabel.text = randomElement?.key

		self.sourceOptions = randomElement!.value.components(separatedBy: " ")

		let allValues = translationsDict.reduce([]) { (result, keyAndValue) in
			return result + keyAndValue.value.components(separatedBy: " ")
		}
		self.sourceOptions.append(contentsOf: allValues[0...7])
		self.sourceOptions = Array(Set(self.sourceOptions))
		self.sourceOptions.shuffle()
	}
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		return collectionView.tag == 1 ? self.source.count : self.sourceOptions.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		let datasource = collectionView.tag == 1 ? source : sourceOptions
		let cellId = collectionView.tag == 1 ? "cell1" : "cell2"

		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WordCell

		cell.textLabel.text = datasource[indexPath.row]

		let size = CGSize(width: 250, height: 1000)
		let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
		let estimatedFrame = NSString(string: datasource[indexPath.row]).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)

		cell.textLabel.frame = CGRect(x: 0, y: 0, width: estimatedFrame.width+kDefaultCellPadding, height: cell.textLabel.frame.height)

		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		let datasource = collectionView.tag == 1 ? source : sourceOptions

		let size = CGSize(width: 250, height: 1000)
		let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
		let estimatedFrame = NSString(string: datasource[indexPath.row]).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)

		let finalWidth = estimatedFrame.width+kDefaultCellPadding < kMinimumCellWidth ? kMinimumCellWidth : estimatedFrame.width+kDefaultCellPadding

		return CGSize(width: finalWidth, height: 50)

	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		// first collectionView
		if collectionView.tag == 1 {
			let cell = collectionView.cellForItem(at: indexPath) as! WordCell
			let cellToAnimate = cell.copyView() as? WordCell

			cell.textLabel.isHidden = true

			// Update Datasource of second collectionView
			// Insert item into second collectionView
			source.remove(at: indexPath.item)

			selectedWordsCollection.reloadData()

			// Animate the cell
			guard let dummyCell = cellToAnimate else {return}

			// find index cell in second collectionview
			let findIndex = sourceOptions.firstIndex(of: cell.textLabel.text!)
			let findIndexPath = IndexPath(item: findIndex!, section: 0)

			// Fetch the frame of the new cell added to the second collectionView
			let destinationCell = optionsWordCollection.cellForItem(at: findIndexPath) as? WordCell
			let frameWRTView = optionsWordCollection.convert(destinationCell!.frame, to: self.view)

			dummyCell.frame = collectionView.convert(cell.frame, to: self.view)
			self.view.addSubview(dummyCell)

			UIView.animate(withDuration: 0.2, animations: {
				dummyCell.frame = frameWRTView
			}) { (_) in
				// Unhide the destination cell and remove the dummyView
				destinationCell?.textLabel.isHidden = false
				destinationCell?.backgroundColor = .white
				destinationCell?.layer.borderWidth = 2
				destinationCell?.layer.shadowOpacity = 1

				cell.textLabel.isHidden = false
				dummyCell.removeFromSuperview()
			}

			cell.isUserInteractionEnabled = true
		} else {
			// Make cell grey
			let cell = collectionView.cellForItem(at: indexPath) as! WordCell
			let cellToAnimate = cell.copyView() as? WordCell

			cell.textLabel.isHidden = true

			UIView.animate(withDuration: 1, animations: {
				cell.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
				cell.layer.borderWidth = 0
				cell.layer.shadowOpacity = 0
			}, completion: nil)


			// Update Datasource of first collectionView
			// Insert item into first collectionView
			source.append(cell.textLabel.text!)
			let newIndexPath = IndexPath(row:source.count-1, section:0)
			selectedWordsCollection.insertItems(at: [newIndexPath])

			// Animate the cell
			guard let dummyCell = cellToAnimate else {return}

			// Fetch the frame of the new cell added to the first collectionView
			let destinationCell = selectedWordsCollection.cellForItem(at: newIndexPath)
			destinationCell?.isHidden = true
			let frameWRTView = selectedWordsCollection.convert(destinationCell!.frame, to: self.view)

			dummyCell.frame = collectionView.convert(cell.frame, to: self.view)
			self.view.addSubview(dummyCell)

			UIView.animate(withDuration: 0.2, animations: {
				dummyCell.frame = frameWRTView
			}) { (_) in
				// Unhide the destination cell and remove the dummyView
				destinationCell?.isHidden = false
				dummyCell.removeFromSuperview()
			}

			cell.isUserInteractionEnabled = false
		}
	}

}

extension ViewController: UICollectionViewDragDelegate, UICollectionViewDropDelegate {

	func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
		let item = self.source[indexPath.row]
		let itemProvider = NSItemProvider(object: item as NSString)
		let dragItem = UIDragItem(itemProvider: itemProvider)
		dragItem.localObject = item

		return [dragItem]
	}

	func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
		return true
	}

	func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {

		guard let destinationIndexPath = coordinator.destinationIndexPath else {
			return
		}

		coordinator.items.forEach { dropItem in
			guard let sourceIndexPath = dropItem.sourceIndexPath else {
				return
			}
			collectionView.performBatchUpdates({
				let word = source[sourceIndexPath.row]
				source.remove(at: sourceIndexPath.row)
				source.insert(word, at: destinationIndexPath.row)
				collectionView.deleteItems(at: [sourceIndexPath])
				collectionView.insertItems(at: [destinationIndexPath])
			}, completion: { _ in
				coordinator.drop(dropItem.dragItem,
								 toItemAt: destinationIndexPath)
			})
		}
	}

	func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
		return UICollectionViewDropProposal(
			operation: .move,
			intent: .insertAtDestinationIndexPath)
	}

}

extension UICollectionViewCell {
	func copyView() -> AnyObject {
		let archivedView = try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)

		return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(archivedView!) as AnyObject

	}
}
