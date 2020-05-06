import Foundation
import Combine

public func runCustomCreatorPublisher(attachOn resources: inout Set<AnyCancellable>) {
    var logger = TimeLogger(sinceOrigin: true)
    let publisher = Publishers.timer(interval: .seconds(1), times: .max(6))
    
    let subscription = publisher.sink { time in
      print("Timer emits: \(time)", to: &logger)
    }
    
    resources.insert(subscription)

    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
      subscription.cancel()
    }
}
