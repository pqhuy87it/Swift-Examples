# UIBezierPath

To create a **Rectangle with rounded corners**, you use the API *UIBezierPath(roundedRect: CGRect, byRoundingCorners: UIRectCorner, cornerRadii: CGSize)*. This function gets **cornerRadii** as the horizontal and vertical corner radius. You can use oval rounded corners. But the vertical radius is rejected and not used. So you can only use rounded corners by circle. This happened in iOS 7.0 and still hasn't been fixed. My solution fixes this.

![Example](Example.png)
