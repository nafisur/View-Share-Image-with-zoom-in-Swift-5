//
//  ImageVC.swift
//
//
//  Created by Nafisur on 24/06/20.
//  Copyright © 2020 cdac. All rights reserved.
//

import UIKit

class ImageVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.setNeedsLayout()
        }
        imageView.sd_setImage(with: URL(string: imageUrl!), placeholderImage:UIImage(named: "placeholder"), options: [.progressiveLoad, .continueInBackground], context: nil)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func shareButtonTapped(_ sender: Any) {
       
        let imageToShare = imageView.image
        guard let image = imageToShare else { return }
        let objectsToShare = [image] as [Any]
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToTwitter,
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.message,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.copyToPasteboard,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.airDrop
        ]
        self.present(activityViewController, animated: true, completion: nil)

        activityViewController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                return
            }

        }
    }//func
}

extension ImageVC: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > scrollView.maximumZoomScale {
            scrollView.zoomScale = scrollView.maximumZoomScale
        } else if scrollView.zoomScale < scrollView.minimumZoomScale {
            scrollView.zoomScale = scrollView.minimumZoomScale
        }
    }
}
