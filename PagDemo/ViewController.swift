//
//  ViewController.swift
//  PagDemo
//
//  Created by apple on 2023/3/2.
//

import UIKit
import libpag

class ViewController: UIViewController {

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadPagResource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        pagView.frame = CGRect(x: (view.bounds.width - 300.0) / 2.0, y: (view.bounds.height - 300.0) / 2.0, width: 300.0, height: 300.0)
        playButton.frame = CGRect(x: (view.bounds.width - 120.0) / 2.0, y: pagView.frame.maxY + 10.0, width: 120.0, height: 30.0)
    }
    
    // MARK: - ui
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(pagView)
        view.addSubview(playButton)
    }
    
    private func loadPagResource() {
        guard let path = Bundle.main.path(forResource: "draw", ofType: "pag") else {
            return
        }
        
        guard let pagFile = PAGFile.load(path) else {
            return
        }
        
        self.pagView.setComposition(pagFile)
    }
    
    // MARK: - action
    
    @objc private func didTapPlay(_ sender: UIButton) {
        print("play")
        self.pagView.play()
    }
    
    // MARK: - view
    
    private lazy var pagView: PAGView = {
        let view = PAGView()
        view.setRepeatCount(1)
        view.add(self)
        return view
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("播放", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(didTapPlay(_:)), for: .touchUpInside)
        return button
    }()

}

// MARK: - PAGViewListener
extension ViewController: PAGViewListener {
    func onAnimationStart(_ pagView: PAGView!) {
        print("onAnimationStart")
    }
    
    func onAnimationEnd(_ pagView: PAGView!) {
        print("onAnimationEnd")
    }
    
    func onAnimationCancel(_ pagView: PAGView!) {
        print("onAnimationCancel")
    }
    
    func onAnimationRepeat(_ pagView: PAGView!) {
        print("onAnimationRepeat")
    }
    
    func onAnimationUpdate(_ pagView: PAGView!) {
        print("onAnimationUpdate: \(pagView.getProgress())")
    }
}
