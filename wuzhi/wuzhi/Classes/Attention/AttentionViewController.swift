//
//  AttentionViewController.swift
//  wuzhi
//
//  Created by vshiron on 16/10/10.
//  Copyright © 2016年 Apress. All rights reserved.
//

import UIKit
import Foundation


class AttentionViewController: BaseViewController {
    
    let attentionCollectionViewCellID = "attentionCollectionViewCellID"

    override func viewDidLoad() {
        
        super.viewDidLoad()

        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: newCollectionview())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "attentionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: attentionCollectionViewCellID)
        view.addSubview(collectionView)
        
        view.backgroundColor = UIColor.red
    }
    

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class newCollectionview: UICollectionViewFlowLayout {
    
    override func prepare() {
        //设置item大小
        itemSize = CGSize(width: 100 , height: 100)
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
        scrollDirection = .vertical
        
        
        // 2.设置collectionView的属性
        collectionView?.showsHorizontalScrollIndicator = false
        //不能弹跳
        collectionView?.bounces = false
        //开启分页
        collectionView?.isPagingEnabled = true
    }
    
}

extension AttentionViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: attentionCollectionViewCellID, for: indexPath)
        
        return item
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}


