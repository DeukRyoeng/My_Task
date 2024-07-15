//
//  File.swift
//  Pokemon_Contact
//
//  Created by DEUKRYEONG LEE on 7/14/24.
//


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        print("어 ~ 됐어 ~")
                        self?.image = image
                    }
                }else {
                    print("어 ~ 안돼 ~")
                }
            }
        }
    }
}