# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'github-bests' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for github-bests
  pod 'Alamofire', '~> 4.7'
  pod 'SDWebImage'
  pod 'PromiseKit'


  target 'github-bestsTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Cuckoo'
    pod 'Quick'
    pod 'Nimble'
    pod 'KIF'
    pod 'iOSSnapshotTestCase'
  end
  
  
  target 'github-bestsIntegrationTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
    pod 'KIF'
    pod 'iOSSnapshotTestCase'
    pod 'Swifter', '~> 1.4.7'
  end

end



post_install do |installer|
  def merge_and_link_dirs(source, destination)
      if File.symlink?(source) then
          return
      end

      if File.directory?(source) then
          system "mv #{source}/* #{destination}"
          system "rmdir #{source}"
      end

      File.symlink("../#{destination}", source)
  end

  headers_dir = installer.config.project_pods_root + 'Headers/'

  # Work around for FBSnapshotTestCase with static linking.
  # This is needed because of buggy handling of the differing module and project names.
  # NOTE: Uncomment to resolve the build failure
  Dir.chdir(headers_dir) do
      merge_and_link_dirs('Private/FBSnapshotTestCase', 'Private/iOSSnapshotTestCase')
      merge_and_link_dirs('Public/FBSnapshotTestCase', 'Public/iOSSnapshotTestCase')
  end
end