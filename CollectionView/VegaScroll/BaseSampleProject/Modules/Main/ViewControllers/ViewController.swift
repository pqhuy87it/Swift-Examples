//
//  ViewController.swift
//  BaseSampleProject
//
//  Created by HuyPQ22 on 2021/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Enums
    
    enum AlertType: String {
        
        case simple = "Simple"
        case simpleWithImages = "Simple +Images"
        case oneTextField = "One TextField"
        case twoTextFields = "Login form"
        case dataPicker = "Date Picker"
        case pickerView = "Picker View"
        case countryPicker = "Country Picker"
        case phoneCodePicker = "Phone Code Picker"
        case currencyPicker = "Currency Picker"
        case imagePicker = "Image Picker"
        case photoLibraryPicker = "Photo Library Picker"
        case colorPicker = "Color Picker"
        case textViewer = "Text Viewer"
        case contactsPicker = "Contacts Picker"
        case locationPicker = "Location Picker"
        case telegramPicker = "Telegram Picker"
        
        var description: String {
            switch self {
            case .simple: return "3 different buttons"
            case .simpleWithImages: return "3 buttons with image"
            case .dataPicker: return "Select date and time"
            case .pickerView: return "Select alert's main view height"
            case .oneTextField: return "Input text"
            case .twoTextFields: return "2 TextFields"
            case .countryPicker: return "TableView"
            case .phoneCodePicker: return "TableView"
            case .currencyPicker: return "TableView"
            case .imagePicker: return "CollectionView, horizontal flow"
            case .photoLibraryPicker: return "Select photos from Photo Library"
            case .colorPicker: return "Storyboard & Autolayout"
            case .textViewer: return "TextView, not editable"
            case .contactsPicker: return "With SearchController"
            case .locationPicker: return "MapView With SearchController"
            case .telegramPicker: return "Similar to the Telegram"
            }
        }
        
        var image: UIImage {
            switch self {
            case .simple: return #imageLiteral(resourceName: "title")
            case .simpleWithImages: return #imageLiteral(resourceName: "two_squares")
            case .dataPicker: return #imageLiteral(resourceName: "calendar")
            case .pickerView: return #imageLiteral(resourceName: "picker")
            case .oneTextField: return #imageLiteral(resourceName: "pen")
            case .twoTextFields: return #imageLiteral(resourceName: "login")
            case .countryPicker: return #imageLiteral(resourceName: "globe")
            case .phoneCodePicker: return #imageLiteral(resourceName: "telephone")
            case .currencyPicker: return #imageLiteral(resourceName: "currency")
            case .imagePicker: return #imageLiteral(resourceName: "listings")
            case .photoLibraryPicker: return #imageLiteral(resourceName: "four_rect")
            case .colorPicker: return #imageLiteral(resourceName: "colors")
            case .textViewer: return #imageLiteral(resourceName: "title")
            case .contactsPicker: return #imageLiteral(resourceName: "user")
            case .locationPicker: return #imageLiteral(resourceName: "planet")
            case .telegramPicker: return #imageLiteral(resourceName: "library")
            }
        }
        
        var color: UIColor? {
            switch self {
            case .simple, .simpleWithImages, .telegramPicker:
                return UIColor(hex: 0x007AFF)
            case .oneTextField, .twoTextFields:
                return UIColor(hex: 0x5AC8FA)
            case .dataPicker, .pickerView, .contactsPicker, .locationPicker:
                return UIColor(hex: 0x4CD964)
            case .countryPicker, .phoneCodePicker, .currencyPicker, .textViewer:
                return UIColor(hex: 0xFF5722)
            case .imagePicker, .photoLibraryPicker:
                return UIColor(hex: 0xFF2DC6)
            case .colorPicker:
                return nil
            }
        }
    }
    
    fileprivate lazy var alerts: [AlertType] = [.simple,
                                                .simpleWithImages,
                                                .oneTextField,
                                                .twoTextFields,
                                                .dataPicker,
                                                .pickerView,
                                                .countryPicker,
                                                .phoneCodePicker,
                                                .currencyPicker,
                                                .imagePicker,
                                                .photoLibraryPicker,
                                                .colorPicker,
                                                .textViewer,
                                                .contactsPicker,
                                                .locationPicker,
                                                .telegramPicker]
    
    // MARK: UI Metrics
    
    struct UI {
        static let itemHeight: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 88 : 65
        static let lineSpacing: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 28 : 20
        static let xInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20
        static let topInset: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 40 : 28
    }
    
    // MARK: Properties
    
    fileprivate var alertStyle: UIAlertController.Style = .actionSheet
    
    fileprivate lazy var layout: VerticalScrollFlowLayout = {
        $0.minimumLineSpacing = UI.lineSpacing
        $0.sectionInset = UIEdgeInsets(top: UI.topInset, left: 0, bottom: 0, right: 0)
        $0.itemSize = itemSize
        
        return $0
    }(VerticalScrollFlowLayout())
    
    fileprivate var itemSize: CGSize {
        let width = UIScreen.main.bounds.width - 2 * UI.xInset
        return CGSize(width: width, height: UI.itemHeight)
    }
    
    // MARK: Initialize
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: ViewController LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.register(TypeOneCell.self, forCellWithReuseIdentifier: TypeOneCell.identifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        //$0.contentInsetAdjustmentBehavior = .never
        collectionView.bounces = true
        collectionView.backgroundColor = .white
        //$0.maskToBounds = false
        //$0.clipsToBounds = false
        collectionView.contentInset.bottom = UI.itemHeight
        collectionView.collectionViewLayout = layout
        
        layout.itemSize = itemSize
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }

    func show(alert type: AlertType) {
        switch type {
            
        case .simple:
            break
        case .simpleWithImages:
            break
        case .oneTextField:
            break
        case .twoTextFields:
            break
        case .dataPicker:
            break
        case .pickerView:
            break
        case .countryPicker:
            break
        case .phoneCodePicker:
            break
        case .currencyPicker:
            break
        case .imagePicker:
            break
        case .photoLibraryPicker:
            break
        case .colorPicker:
            break
        case .textViewer:
            break
        case .contactsPicker:
            break
        case .locationPicker:
            break
        case .telegramPicker:
            break
        }
    }
}

// MARK: - CollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Log("selected alert - \(alerts[indexPath.item].rawValue)")
        show(alert: alerts[indexPath.item])
    }
}

// MARK: - CollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alerts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: TypeOneCell.identifier, for: indexPath) as? TypeOneCell else { return UICollectionViewCell() }
        
        let alert = alerts[indexPath.item]

        item.imageView.image = alert.image
        item.imageView.tintColor = alert.color
        item.title.text = alert.rawValue
        item.subtitle.text = alert.description
        item.subtitle.textColor = .darkGray
        
        return item
    }
}

