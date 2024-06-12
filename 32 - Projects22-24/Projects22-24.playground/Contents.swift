import UIKit

//challenge 1
let view: UIView = UIView()

extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        })
    }
}

view.bounceOut(duration: 0.5)


//challenge 2
extension Int {
    func times(_ closure: () -> Void) {
        guard self > 0 else { return }
        for _ in 0..<self {
            closure()
        }
    }
}

5.times {
    print("Hello")
}


//challenge 3
extension Array where Element: Comparable{
    mutating func remove(item: Element) {
        if let location = self.firstIndex(of: item) {
            self.remove(at: location)
        }
    }
}


var numbers = [1,2,3,4]
numbers.remove(at: 3)
print(numbers)
