import UIKit

extension UIImageView {
    func loadImageFromURL(_ url: String, onCompletion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async { () -> Void in
            let url = URL(string: url)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(
                data: data!)
            DispatchQueue.main.async {
                onCompletion(image!)
            }
        }
    }
}
