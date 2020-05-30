class TempNotifier {
    var onChange: (Int) -> Void = {_ in }
    var currentTemp = 72
    init() {
        onChange = {[unowned self] temp in
            self.currentTemp = temp
        }
        
        // dont jump in deinit vi 2 cai strong noi vao nhau
//        onChange = { temp in
//            self.currentTemp = temp
//        }
    }
    
    func saySomething() {
        print(currentTemp)
    }
    
    deinit {
        print("deinit!")
    }
}

var temp1 : TempNotifier?
temp1 = TempNotifier()
temp1 = nil