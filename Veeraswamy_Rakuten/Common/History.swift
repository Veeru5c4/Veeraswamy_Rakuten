
import Foundation
import CoreData

class History {
    var connectedDeviceList:[ConnectedDevice]!

    init() {
        connectedDeviceList = [ConnectedDevice]()
    }

    func count() -> Int {
        return connectedDeviceList.count
    }

    func object(at index: Int) -> Any {
        return connectedDeviceList[index]
    }

    func addObject(_ connectedDevice: ConnectedDevice) {
        connectedDeviceList.append(connectedDevice)
    }

    func removeObject(at index: Int) {
        connectedDeviceList.remove(at: index)
    }

    func save() {
        print("Save history count: \(connectedDeviceList.count)")
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: connectedDeviceList)
            UserDefaults.standard.set(data, forKey: "deviceList")
        } catch {
            print("Save history error: \(error)");
        }
    }

    func load() {
        if let data = UserDefaults.standard.data(forKey: "deviceList") {
            do {
                connectedDeviceList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [ConnectedDevice]
            } catch {
                print("Load history error: \(error)")
            }
        }
        if connectedDeviceList == nil {
            connectedDeviceList = [ConnectedDevice]()
        }
        print("Load history count: \(connectedDeviceList.count)")
    }
    
    func historyFilePath() -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectoryPath = paths[0]
        return URL(fileURLWithPath: documentsDirectoryPath).appendingPathComponent("history").absoluteString
    }

}
