import Foundation
import Network

@objc(ExamplePlugin)
public class ExamplePlugin: CAPPlugin {

    @objc func open(_ call: CAPPluginCall) {
        let ip = call.getString("ip") ?? ""
        let port = call.getString("port") ?? ""
        let text = call.getString("text") ?? ""

        let nwConnection = NWConnection(host: NWEndpoint.Host(ip), port: NWEndpoint.Port(port)!, using: .tcp)
        nwConnection.stateUpdateHandler = { (newState) in
            switch (newState) {
            case .ready:
                nwConnection.send(content: text.data(using: .utf8), completion: NWConnection.SendCompletion.contentProcessed { (error) in
                    if let err = error {
                        call.reject("Error sending data: \(err)")
                    } else {
                        call.resolve(["success": true])
                    }
                })
            case .setup:
                break
            case .cancelled:
                call.reject("Connection cancelled")
            case .preparing:
                break
            default:
                call.reject("Connection failed")
            }
        }
        nwConnection.start(queue: DispatchQueue.global())
    }
}
