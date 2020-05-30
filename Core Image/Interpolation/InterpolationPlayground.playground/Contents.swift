//: # Interpolation Playground
//:
//: Based on [http://sol.gfxile.net/interpolation/index.html](http://sol.gfxile.net/interpolation/index.html)
//:
//: Simon Gladman / January 2016


import UIKit

func loop(_ interpolationFunction: (Double) -> Double )
{
    let n = 100

    for i in 0 ..< n
    {
        let v = Double(i) / Double(n)
        
        let _ = interpolationFunction(v)
    }
}

//: ## Linear Interpolation

loop { x in x }

//: ## Smoothstep

loop { x in (x * x * (3 - 2 * x)) } 

//: ## Smootherstep

loop { x in
    let x1 = x * 6 - 15
    let x2 = x * x1 + 10
    
    return (x * x * x * x2)
}

//: ## Kyle McDonald `smoothestStep()`
//: Taken from [https://twitter.com/kcimc/status/580738643347804160](https://twitter.com/kcimc/status/580738643347804160)

func smoothestStep(_ t: Double) -> Double
{
    var x = -20 * pow(t, 7)
    
    x += 70 * pow(t, 6)
    x -= 84 * pow(t, 5)
    x += 35 * pow(t, 4)
    
    return x
}

loop { t in smoothestStep(t) }

//: ## Squared

loop { x in (x * x) }


//: ## Inverse Squared

loop { x in 1 - (1 - x) * (1 - x) }

//: ## Cubed

loop { x in (x * x * x) }

//: ## Sin

loop { x in sin(x * Double.pi) }

//: ## Catmull-Rom

func catmullRom(_ t: Double, _ p0: Double, _ p1: Double, _ p2: Double, _ p3: Double) -> Double
{
    return 0.5 * (
        (2 * p1) +
        (-p0 + p2) * t +
        (2 * p0 - 5 * p1 + 4 * p2 - p3) * t * t +
        (-p0 + 3 * p1 - 3 * p2 + p3) * t * t * t
    )
}

let q = -15.0
let t = 7.5

loop { x in catmullRom(x, q, 0.0, 1.0, t) }

//: ## Elastic In

func elasticIn(_ x: Double, p: Double = 0.2) -> Double
{
    return pow(2, 10 * (x - 1)) * sin((x - p/4) * (2 * Double.pi) / p) + 1
}

loop { x in elasticIn(x) }

//: ## Elastic Out
//: Taken from [http://www.joshondesign.com/2013/03/01/improvedEasingEquations](http://www.joshondesign.com/2013/03/01/improvedEasingEquations)

func elasticOut(_ x: Double, p: Double = 0.2) -> Double
{
    return pow(2, -10 * x) * sin((x - p/4) * (2 * Double.pi) / p) + 1
}

loop { x in elasticOut(x) }

//: ## Wobble

func wobble(_ x: Double, wobbleCount: Double, wobbleHeight: Double) -> Double
{
    let wobbleHeight = sin(Double.pi * x) * wobbleHeight
    let wobbleOffset = sin(Double.pi * wobbleCount * x) * wobbleHeight
    
    return x + wobbleOffset
}

loop { x in wobble(x, wobbleCount: 30, wobbleHeight: 0.25) }

//: ## Gaussian

let 𝑒 = M_E
let 𝛑 = Double.pi

prefix operator √
prefix func √(x:Double) -> Double {return sqrt(x)}

func gaussian(_ x: Double, sigma: Double) -> Double
{
    func 𝛗(_ x: Double, σ: Double) -> Double
    {
        let σ² = σ * σ
        
        return (1.0 / √(𝛑 * 2 * σ²)) * pow(𝑒, -pow(x, 2) / (2 * σ²))
    }
    
    let max = 𝛗(0.0, σ: sigma)
    
    return (max - 𝛗(x, σ: sigma)) / max
}

loop { x in gaussian(x, sigma: 0.05) }

loop { x in gaussian(x, sigma: 0.15) }

loop { x in gaussian(x, sigma: 0.25) }

// end
