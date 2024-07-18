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
    
    let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFill
//        imageView.layer.borderWidth = 2
//        imageView.layer.cornerRadius = 35
//        imageView.layer.borderColor = UIColor.black.cgColor
//        imageView.layer.masksToBounds = true
        return  imageView
    }()
    let containerView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.cornerRadius = 35
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.gray.cgColor
        return view
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
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(containerView)
        
    }
    
    private func autoLayout() {
        containerView.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(70)  // 컨테이너 뷰의 크기 설정
        }
        
        profileImageView.snp.makeConstraints {
            $0.size.width.height.equalTo(65)
            $0.centerX.equalTo(containerView.snp.centerX)
            $0.centerY.equalTo(containerView.snp.centerY)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(30)
            $0.top.equalTo(30)
        }
        numberLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(30)
            
        }
    }
    
}


