import Foundation
import UIKit
struct Person {
    let name: String?
    let surName: String
    let date: Date
    let age: Int16
    var imagePerson:Data {
        didSet { _ = UIImage(data: imagePerson)! }
    }
    
//    lazy var mainImage: UIImage = {
//        UIImage(data: imagePerson)!
//    }()
}
