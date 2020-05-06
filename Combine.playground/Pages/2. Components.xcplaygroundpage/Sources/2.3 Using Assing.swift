import Foundation
import Combine

class User {
    
    var name: String = "Pablo" {
        didSet {
            print(name)
        }
    }
    
}

public func runAssign(attachOn resources: inout Set<AnyCancellable>) {
    let user = User()
    let publisher = ["Pedro", "Juan"].publisher
    
    publisher.assign(to: \.name, on: user)
        .store(in: &resources)
}
