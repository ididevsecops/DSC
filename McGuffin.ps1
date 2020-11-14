Configuration ServerConfiguration
{
  Import-DscResource -ModuleName PsDesiredStateConfiguration
  
  Node "localhost"
  {
    WindowsFeature InstallIIS {
      Ensure = "Present"
      Name   = "Web-Server"
    }
    File CreateMcGuffinFolder {
      Ensure          = "Present" # Ensure the directory is Present on the target node.
      Type            = "Directory" # The default is File.
      DestinationPath = "C:\MCGUFFIN"
    }
  }
}
