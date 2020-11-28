/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import CoreText

class CTView: UIScrollView {
  // MARK: - Properties
  var imageIndex: Int!

  //1
  func buildFrames(withAttrString attrString: NSAttributedString,
                   andImages images: [[String: Any]]) {
    imageIndex = 0

    //3
    isPagingEnabled = true
    //4
    let framesetter = CTFramesetterCreateWithAttributedString(attrString as CFAttributedString)
    //4
    var pageView = UIView()
    var textPos = 0
    var columnIndex: CGFloat = 0
    var pageIndex: CGFloat = 0
    let settings = CTSettings()
    //5
    while textPos < attrString.length {
      //1
      if columnIndex.truncatingRemainder(dividingBy: settings.columnsPerPage) == 0 {
        columnIndex = 0
        pageView = UIView(frame: settings.pageRect.offsetBy(dx: pageIndex * bounds.width, dy: 0))
        addSubview(pageView)
        //2
        pageIndex += 1
      }
      //3
      let columnXOrigin = pageView.frame.size.width / settings.columnsPerPage
      let columnOffset = columnIndex * columnXOrigin
      let columnFrame = settings.columnRect.offsetBy(dx: columnOffset, dy: 0)

      //1
      let path = CGMutablePath()
      path.addRect(CGRect(origin: .zero, size: columnFrame.size))
      let ctframe = CTFramesetterCreateFrame(framesetter, CFRangeMake(textPos, 0), path, nil)
      //2
      let column = CTColumnView(frame: columnFrame, ctframe: ctframe)
      if images.count > imageIndex {
        attachImagesWithFrame(images, ctframe: ctframe, margin: settings.margin, columnView: column)
      }
      pageView.addSubview(column)
      //3
      let frameRange = CTFrameGetVisibleStringRange(ctframe)
      textPos += frameRange.length
      //4
      columnIndex += 1
    }
    contentSize = CGSize(width: CGFloat(pageIndex) * bounds.size.width,
                         height: bounds.size.height)
  }

  func attachImagesWithFrame(_ images: [[String: Any]],
                             ctframe: CTFrame,
                             margin: CGFloat,
                             columnView: CTColumnView) {
    //1
    let lines = CTFrameGetLines(ctframe) as NSArray
    //2
    var origins = [CGPoint](repeating: .zero, count: lines.count)
    CTFrameGetLineOrigins(ctframe, CFRangeMake(0, 0), &origins)
    //3
    var nextImage = images[imageIndex]
    guard var imgLocation = nextImage["location"] as? Int else {
      return
    }
    //4
    for lineIndex in 0..<lines.count {
      let line = lines[lineIndex] as! CTLine
      //5
      if let glyphRuns = CTLineGetGlyphRuns(line) as? [CTRun],
        let imageFilename = nextImage["filename"] as? String,
        let img = UIImage(named: imageFilename)  {
        for run in glyphRuns {
          // 1
          let runRange = CTRunGetStringRange(run)
          if runRange.location > imgLocation || runRange.location + runRange.length <= imgLocation {
            continue
          }
          //2
          var imgBounds: CGRect = .zero
          var ascent: CGFloat = 0
          imgBounds.size.width = CGFloat(CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, nil, nil))
          imgBounds.size.height = ascent
          //3
          let xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, nil)
          imgBounds.origin.x = origins[lineIndex].x + xOffset
          imgBounds.origin.y = origins[lineIndex].y
          //4
          columnView.images += [(image: img, frame: imgBounds)]
          //5
          imageIndex! += 1
          if imageIndex < images.count {
            nextImage = images[imageIndex]
            imgLocation = (nextImage["location"] as AnyObject).intValue
          }
        }
      }
    }
  }
}
