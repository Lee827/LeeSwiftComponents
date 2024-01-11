//
//  BasicCustomCollectionView.swift
//  SwiftComponents
//
//  Created by KWUN LOK LEE on 15/12/2023.
//

open class BasicCustomCollectionView: UICollectionView {
  
  //Store a completion block as a property
  private var completion: (() -> Void)?;
  
  //Make a custom funciton to reload data with a completion handle
  open func reloadData(completion: @escaping() -> Void) {
    //Set the completion handle to the stored property
    self.completion = completion;
    //Call super
    super.reloadData();
  }
  
  //Override layoutSubviews
  override open func layoutSubviews() {
    super.layoutSubviews();
    //Call the completion
    self.completion?();
    //Set the completion to nil so it is reset and doesn't keep gettign called
    self.completion = nil;
  }
}
