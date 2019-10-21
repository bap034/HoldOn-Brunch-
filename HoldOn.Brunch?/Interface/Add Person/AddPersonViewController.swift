//
//  AddPersonViewController.swift
//  HoldOn.Brunch?
//
//  Created by Brett Petersen on 10/6/19.
//  Copyright © 2019 Brett Petersen. All rights reserved.
//

import Photos
import UIKit

// MARK: - AddPersonViewController
class AddPersonViewController: UIViewController {
	
	private let presenter: AddPersonPresenter
	
	private let containerView = UIView()
	private let selectImageView = SelectImageView()
	private let nameLabel = UILabel()
	private let nameTextField = UITextField()
	
	init(presenter: AddPersonPresenter) {
		self.presenter = presenter
		
		super.init(nibName: nil, bundle: nil)
		
		self.presenter.viewProtocol = self
	}
	required init?(coder aDecoder: NSCoder) { fatalError() }
}

// MARK: - UIViewController
extension AddPersonViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpSelf()
		setUpContainerView()
		setUpSelectImageView()
		setUpNameLabel()
		setUpNameTextField()
		
		activateConstraintsForContainerView()
		activateConstraintsForSelectImageView()
		activateConstraintsForNameLabel()
		activateConstraintsForNameTextField()
	}
}

// MARK: - View Setup
extension AddPersonViewController {
	private func setUpSelf() {
		view.backgroundColor = .white
	}
	private func setUpContainerView() {
		containerView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(containerView)
	}
	private func setUpSelectImageView() {
		selectImageView.onTapped = {
			self.presenter.onSelectImageTapped()
		}
		
		selectImageView.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(selectImageView)
	}
	private func setUpNameLabel() {
		nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
		nameLabel.text = "Name"
		
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(nameLabel)
	}
	private func setUpNameTextField() {
		nameTextField.borderStyle = .roundedRect
		nameTextField.delegate = self
		
		nameTextField.translatesAutoresizingMaskIntoConstraints = false
		containerView.addSubview(nameTextField)
	}
	
	// MARK: Constraints
	private func activateConstraintsForContainerView() {
		containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
		containerView.widthAnchor.constraint(equalToConstant: 200).isActive = true
		containerView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor).isActive = true
	}
	private func activateConstraintsForSelectImageView() {
		selectImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
		selectImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		selectImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
		selectImageView.heightAnchor.constraint(equalTo: selectImageView.widthAnchor).isActive = true
	}
	private func activateConstraintsForNameLabel() {
		nameLabel.topAnchor.constraint(equalTo: selectImageView.bottomAnchor, constant: 30).isActive = true
		nameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
		nameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
	}
	private func activateConstraintsForNameTextField() {
		nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
		nameTextField.centerXAnchor.constraint(equalTo: nameLabel.centerXAnchor).isActive = true
		nameTextField.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
		nameTextField.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
		nameTextField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
	}
}

// MARK: - Events
extension AddPersonViewController {
	@objc func onLeftNavigationItemTapped() {
		presenter.onCancelTapped()
	}
	@objc func onRightNavigationItemTapped() {
		presenter.onSaveTapped(name: nameTextField.text)
	}
	
	private func onCameraTapped() {
		PhotosManager.requestPhotoLibraryAuthorization(onAuthorized: {
			let picker = UIImagePickerController()
			picker.allowsEditing = true
			picker.sourceType = .camera
			picker.delegate = self
			self.present(picker, animated: true, completion: nil)
		}) {
			self.showTwoButtonAlertModal(title: "Oops!", message: "We need access to your camera if you want to take a photo.", okButtonTitle: "Go to Settings") {
				guard let safeURL = URL(string: UIApplication.openSettingsURLString) else { return }
				
				UIApplication.shared.open(safeURL, options: [:], completionHandler: nil)
			}
		}
	}
	private func onPhotoLibraryTapped() {
		PhotosManager.requestPhotoLibraryAuthorization(onAuthorized: {
			let picker = UIImagePickerController()
			picker.allowsEditing = true
			picker.sourceType = .photoLibrary
			picker.delegate = self
			self.present(picker, animated: true, completion: nil)
		}) {
			self.showTwoButtonAlertModal(title: "Oops!", message: "We need access to your photo library if you want to upload a photo.", okButtonTitle: "Go to Settings") {
				guard let safeURL = URL(string: UIApplication.openSettingsURLString) else { return }
				
				UIApplication.shared.open(safeURL, options: [:], completionHandler: nil)
			}
		}
	}
}

// MARK: - UITextFieldDelegate
extension AddPersonViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
	}
}

// MARK: - UIImagePickerControllerDelegate
extension AddPersonViewController: UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if picker.sourceType == .camera {
			PHPhotoLibrary.shared().performChanges({
				guard let sureImage = info[.originalImage] as? UIImage else { return }
				guard let sureData = sureImage.pngData() else { return }
				
				// Add the captured photo's file data as the main resource for the Photos asset.
				let creationRequest = PHAssetCreationRequest.forAsset()
				creationRequest.addResource(with: .photo, data: sureData, options: nil)
			}, completionHandler: nil)
		}
		
		if let image = info[.editedImage] as? UIImage {
			selectImageView.imageView.image = image
			
			let imageData = image.pngData()
			presenter.onNewImageSelected(imageData)
		}
		self.presentedViewController?.dismiss(animated: true, completion: nil)
	}
}

// MARK: - UINavigationControllerDelegate
extension AddPersonViewController: UINavigationControllerDelegate {}

// MARK: - AddPersonViewProtocol
extension AddPersonViewController: AddPersonViewProtocol {
	func setTitle(_ title: String) {
		self.title = title
	}
	
	func setUpLeftNavigationItem() {
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onLeftNavigationItemTapped))
	}
	
	func setUpRightNavigationItem() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(onRightNavigationItemTapped))
	}
	
	func enableRightNavigationItem(_ enable: Bool) {
		navigationItem.rightBarButtonItem?.isEnabled = enable
	}
	
	func showImageSelectAlertController() {
		let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		let takePhotoAction = UIAlertAction(title: "Camera", style: .default) { (action) in
			self.onCameraTapped()
		}
		let imageSelectAction = UIAlertAction(title: "Select Image", style: .default) { (action) in
			self.onPhotoLibraryTapped()
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alertController.addAction(takePhotoAction)
		alertController.addAction(imageSelectAction)
		alertController.addAction(cancelAction)
		self.present(alertController, animated: true, completion: nil)
	}
	
	func dismiss() {
		presentingViewController?.dismiss(animated: true, completion: nil)
	}
}
