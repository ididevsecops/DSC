Configuration McGuffinVirtualMachine
{
  Import-DscResource -ModuleName PsDesiredStateConfiguration
  Import-DSCResource -ModuleName NetworkingDsc
  
  Node "localhost"
  {
    Firewall AllowWinRmHttpInbound {
      Ensure      = "Present"
      Name        = "AllowWinRmHttpInbound"
      DisplayName = "Allow WinRM HTTP Inbound"
      Group       = "Windows Remote Management"
      Enabled     = "True"
      Profile     = ("Domain", "Private", "Public")
      Direction   = "Inbound"
      Protocol    = "TCP"
      LocalPort   = ("5985")
      Description = "Allow WinRM HTTP Inbound"
    }
    Firewall AllowWinRmHttpsInbound {
      Ensure      = "Present"
      Name        = "AllowWinRmHttpsInbound"
      DisplayName = "Allow WinRM HTTPS Inbound"
      Group       = "Windows Remote Management"
      Enabled     = "True"
      Profile     = ("Domain", "Private", "Public")
      Direction   = "Inbound"
      Protocol    = "TCP"
      LocalPort   = ("5986")
      Description = "Allow WinRM HTTPS Inbound"
    }
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
    Service StartWindowsRemoteManagementService {
      Name        = "WinRM"
      StartupType = "Automatic"
      State       = "Running"
    }
    File CreateMcGuffinFolder {
      Ensure          = "Present" # Ensure the directory is Present on the target node.
      Type            = "Directory" # The default is File.
      DestinationPath = "C:\MCGUFFIN"
    }
  }
}
