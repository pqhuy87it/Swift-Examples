Pod::Spec.new do |s|
  s.name         = "CSMCollectionBatchUpdates"
  s.version      = "0.1"
  s.summary      = "Safely perform batch updates in UITableView and UICollectionView"
  s.description  = <<-DESC
                   CSMCollectionBatchUpdates` is a set of classes and extensions to UICollectionView and UITableView to perform safe batch updates of these views. Based in Badoo BMACollectionBatchUpdates
                   DESC
  s.homepage     = "https://github.com/Charlisim/ios-collection-batch-safe-updates-swift.git"
  s.license      = { :type => "MIT"}
  s.author       = { "Carlos Simon" => "csimonts@gmail.com" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = '8.0'

  s.source       = { :git => "https://github.com/Charlisim/ios-collection-batch-safe-updates-swift.git", :tag => s.version.to_s }
  s.source_files = "CSMCollectionBatchUpdates/CSMCollectionBatchUpdates"
  s.requires_arc = true
end