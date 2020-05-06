import Foundation
import Combine

public func simpleSubscription(attachOn resources: inout Set<AnyCancellable>) {
    let myNotification = Notification.Name("MyNotification")
    let center = NotificationCenter.default
    let publisher = center.publisher(for: myNotification, object: nil)
        
    //: ### Normal Solution
    //    let observer = center.addObserver(forName: myNotification,
    //                                      object: nil,
    //                                      queue: nil) { notification in
//            print("Notification received!")
//    }
//    center.post(name: myNotification, object: nil)
//    center.removeObserver(observer)

    //: ### Subscription
    publisher.sink { (notification) in
        print("Notification received from a publisher!")
    }.store(in: &resources)
    center.post(name: myNotification, object: nil)
}
