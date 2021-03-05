Configuration WebServer
{
  Import-DscResource -ModuleName PsDesiredStateConfiguration

  Node "localhost"
  {
    WindowsFeature InstallWebServer {
      Ensure = "Present"
      Name   = "Web-Server"
    }
    WindowsFeature InstallWebManagementService {
      Ensure    = "Present"
      Name      = "Web-Mgmt-Service"
      DependsOn = "[WindowsFeature]InstallWebServer"
    }
    WindowsFeature InstallWebManagementTools {
      Ensure    = "Present"
      Name      = "Web-Mgmt-Tools"
      DependsOn = "[WindowsFeature]InstallWebServer"
    }
    Service StartWebService {
      Name        = "W3SVC"
      StartupType = "Automatic"
      State       = "Running"
      DependsOn   = "[WindowsFeature]InstallWebServer"
    }
    Service StartWebManagementService {
      Name        = "WMSvc"
      StartupType = "Automatic"
      State       = "Running"
      DependsOn   = "[WindowsFeature]InstallWebManagementService"
    }
  }
}
