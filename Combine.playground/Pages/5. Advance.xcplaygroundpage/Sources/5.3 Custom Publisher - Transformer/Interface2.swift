import Foundation
import Combine

public func runCustomTransformerPublisher(attachOn resources: inout Set<AnyCancellable>) {
 
    var logger = TimeLogger(sinceOrigin: true)
    let subject = PassthroughSubject<Int, Never>()
    let publisher = subject.shareReplay(capacity: 3)

    subject.send(0)

    subject.sink(receiveCompletion: {
        print("subscription1 completed \($0)", to: &logger) }
    ) {
        print("subscription1 received \($0)", to: &logger)
    }.store(in: &resources)

    subject.send(1)
    subject.send(2)
    subject.send(3)

    publisher.sink(receiveCompletion: {
        print("subscription2 completed: \($0)", to: &logger)
    }, receiveValue: {
        print("subscription2 received \($0)", to: &logger)
    }).store(in: &resources)

    subject.send(4)
    subject.send(5)
    subject.send(completion: .finished)

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        _ = publisher.sink(receiveCompletion: {
            print("subscription3 completed: \($0)", to: &logger)
        }, receiveValue: {
            print("subscription3 received \($0)", to: &logger)
        })
    }
    
}
