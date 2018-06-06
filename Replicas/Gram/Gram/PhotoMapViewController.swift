//
//  PhotoMapViewController.swift
//  Gram
//
//  Created by Kode Williams on 3/6/18.
//  Copyright © 2018 Kode Williams. All rights reserved.
//

import UIKit
import Parse

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var chosenPic: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseImage(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available.")
            vc.sourceType = .camera
        } else {
            print("Camera not available so we will use photo library instead.")
            vc.sourceType = .photoLibrary
        }
        
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func postImage(_ sender: UIBarButtonItem) {
        Post.postUserImage(image: chosenPic.image(for: .normal), withCaption: captionTextField.text!, withCompletion: nil)
        let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewNav")
        self.present(homeVC!, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        // let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        chosenPic.setImage(originalImage, for: .normal)
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
