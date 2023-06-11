//
//  ViewController.swift
//  RectsView
//
//  Created by huy on 2023/06/06.
//

import UIKit

@IBDesignable class RectsView: UIView {

    // Properties which determin the intrinsic height
    @IBInspectable public var rectSize: CGFloat = 20 {
        didSet {
            calcContent()
            setNeedsLayout()
        }
    }

    @IBInspectable public var rectSpacing: CGFloat = 10 {
        didSet {
            calcContent()
            setNeedsLayout()
        }
    }

    @IBInspectable public var rowSpacing: CGFloat = 5 {
        didSet {
            calcContent()
            setNeedsLayout()
        }
    }

    @IBInspectable public var rectsCount: Int = 20 {
        didSet {
            calcContent()
            setNeedsLayout()
        }
    }


    // Calculte the content and its height
    private var rects = [CGRect]()
    func calcContent() {
        var x: CGFloat = 0
        var y: CGFloat = 0

        rects = []
        if rectsCount > 0 {
            for _ in 0..<rectsCount {
                let rect = CGRect(x: x, y: y, width: rectSize, height: rectSize)
                rects.append(rect)

                x += rectSize + rectSpacing
                if x + rectSize > frame.width {
                    x = 0
                    y += rectSize + rowSpacing
                }
            }
        }

        height = y + rectSize
        invalidateIntrinsicContentSize()
    }


    // Intrinc height
    @IBInspectable var height: CGFloat = 50
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        invalidateIntrinsicContentSize()
    }


    // Drawing
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let context = UIGraphicsGetCurrentContext()

        for rect in rects {
            context?.setFillColor(UIColor.red.cgColor)
            context?.fill(rect)
        }


        let attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)]
        let text = "\(height)"

        text.draw(at: CGPoint(x: 0, y: 0), withAttributes: attrs)
    }
}

class ViewController: UITableViewController {
    let CellId = "CellId"

    // Dummy content with different values per row
    var data: [(CGFloat, CGFloat, CGFloat, Int)] = [
        (10.0, 15.0, 13.0, 35),
        (20.0, 10.0, 16.0, 28),
        (30.0, 5.0, 19.0, 21)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "IntrinsicCell", bundle: nil), forCellReuseIdentifier: CellId)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as? IntrinsicCell ?? IntrinsicCell()

        // Dummy content with different values per row
        cell.rectSize = data[indexPath.row].0     // CGFloat((indexPath.row+1) * 10)
        cell.rectSpacing = data[indexPath.row].1  // CGFloat(20 - (indexPath.row+1) * 5)
        cell.rowSpacing = data[indexPath.row].2   // CGFloat(10 + (indexPath.row+1) * 3)
        cell.rectsCount = data[indexPath.row].3   // (5 - indexPath.row) * 7

        return cell
    }

    // Add/remove content when tapping on a row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var rowData = data[indexPath.row]
        rowData.3 = (indexPath.row % 2 == 0 ? rowData.3 + 5 : rowData.3 - 5)
        data[indexPath.row] = rowData
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}


// Simple cell holing an intrinsic rectsView
class IntrinsicCell: UITableViewCell {
    @IBOutlet private var rectsView: RectsView!

    var rectSize: CGFloat {
        get { return rectsView.rectSize }
        set { rectsView.rectSize = newValue }
    }

    var rectSpacing: CGFloat {
        get { return rectsView.rectSpacing }
        set { rectsView.rectSpacing = newValue }
    }

    var rowSpacing: CGFloat {
        get { return rectsView.rowSpacing }
        set { rectsView.rowSpacing = newValue }
    }

    var rectsCount: Int {
        get { return rectsView.rectsCount }
        set { rectsView.rectsCount = newValue }
    }
} 

