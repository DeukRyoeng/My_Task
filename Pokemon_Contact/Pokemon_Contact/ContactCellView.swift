//
//  ContactCellView.swift
//  Pokemon_Contact
//
//  Created by DEUKRYEONG LEE on 7/11/24.
//

import UIKit
import SnapKit

class ContactCellView:UITableViewCell {
    
    static let identifier = "ContactCell"
    //전역변수로 선언
    
    let image:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return  imageView
        
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "파이리"
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "010-0000-0000"
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addContentView()
        autoLayout()

    }
    
    required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    private func addContentView() {
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(numberLabel)
    }
    
    private func autoLayout() {
        image.snp.makeConstraints {
            $0.size.width.height.equalTo(80)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(30)
            $0.top.equalTo(30)
            
        
        }
        numberLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(50)
            $0.top.equalTo(30)

        }
    }
    
}
