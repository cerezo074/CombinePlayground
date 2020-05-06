import Foundation
import Combine

public func runCancellable(attachOn resources: inout Set<AnyCancellable>) {
    let data = [1,2,3,4,5,6].publisher
    
    let subscription = data
        .delay(for: .seconds(2), scheduler: DispatchQueue.main)
        .handleEvents(receiveCancel: {
            print("Received cancel request")
        }).sink(receiveCompletion: { print("received \($0)") },
                receiveValue: { print("received \($0)") })
    
    resources.insert(subscription)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        subscription.cancel()
    }
}
