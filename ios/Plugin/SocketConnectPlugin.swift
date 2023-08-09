import Foundation
import Capacitor
import Network

@objc(SocketConnectPlugin)
public class SocketConnectPlugin: CAPPlugin {

    @objc func open(_ call: CAPPluginCall) {
        guard let ip = call.getString("ip"),
              let portString = call.getString("port"),
              let port = NWEndpoint.Port(portString),
              let text = call.getString("text") else {
            call.reject("Missing or invalid parameters")
            return
        }

        let nwConnection = NWConnection(host: NWEndpoint.Host(ip), port: port, using: .tcp)
        nwConnection.stateUpdateHandler = { (newState: NWConnection.State) in
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
