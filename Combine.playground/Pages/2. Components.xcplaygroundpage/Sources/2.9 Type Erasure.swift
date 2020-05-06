import Foundation
import Combine

public func runTypeErasure(attachOn resources: inout Set<AnyCancellable>) {
    let subject = PassthroughSubject<Int, Never>()
    let publisher = subject.eraseToAnyPublisher()
    
    publisher.sink(receiveValue: { print($0) })
        .store(in: &resources)
    
//    subject.send(0)
//    publisher.send(1) //Error publisher interface was reduced
}
