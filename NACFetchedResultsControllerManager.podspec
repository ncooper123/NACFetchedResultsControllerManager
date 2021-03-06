Pod::Spec.new do |s|
  s.name         = "NACFetchedResultsControllerManager"
  s.version      = "0.0.9"
  s.summary      = "A helper class for connecting NSFetchedResultsControllers to UITableViews."

  s.description  = <<-DESC
                   A helper class for connecting NSFetchedResultsControllers to UITableViews. Provides basic functionality for attaching/detaching the instance, along with a few other special-case tools that may be useful.
                   DESC

  s.homepage = "https://github.com/ncooper123/"
  s.license = { :type => 'BSD' }
  s.author = { "Nathan" => "ncooper@uno.edu" }
  s.platform = :ios
  s.requires_arc = true
  s.source = { :git => "https://github.com/ncooper123/NACFetchedResultsControllerManager.git", :branch => "master", :tag => '0.0.9' }
  s.resources = ["new-icon.png","*.xib"]
  s.source_files = "*.{h,m}"

end
