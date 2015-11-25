//
//  ViewController.swift
//  AdjustableHeaderViewDemo
//
//  Created by Broccoli on 15/11/24.
//  Copyright © 2015年 Broccoli. All rights reserved.
//

import UIKit

private let CellIdentifier = "DemoCell"

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController!.navigationBar.br_setBackgroundColor(UIColor(red: 0/255.0, green: 130/255.0, blue: 210/255.0, alpha: 0))
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, self.tableView.bounds.width, 100))
        imageView.image = UIImage(named: "stars")
        imageView.contentMode = .ScaleAspectFill
        
        let headerView = AdjustableHeaderView(inView: imageView, headerViewSize: CGSizeMake(UIScreen.mainScreen().bounds.width, 100), maxOffsetY: -120, delegate: self)
        tableView.tableHeaderView = headerView
    }
}

extension ViewController: AdjustableHeaderViewDelegate {
    func didScorllMaxOffset(maxOffset: CGFloat) {
        tableView.contentOffset.y = maxOffset
    }
    
    func adjustNaviBarAplha(alpha: CGFloat) {
            // 这里要判断一下 如果 tabbar 为空 怎么办
        let color = navigationController!.navigationBar.overlay!.backgroundColor!
        navigationController!.navigationBar.br_setBackgroundColor(color.colorWithAlphaComponent(alpha))
    }
}

extension ViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath)
        cell.textLabel!.text = "我是第\(indexPath.row)行"
        return cell
    }
}

extension ViewController {
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let headerView = tableView.tableHeaderView as! AdjustableHeaderView
        headerView.layoutHeaderView(scrollView.contentOffset)
    }
}
