# Active Directory and PowerShell Automation Lab

## Overview

This project demonstrates the deployment and configuration of an **Active Directory environment using Windows Server 2022**. It covers setting up a Domain Controller, configuring DHCP services, implementing Remote Access and NAT, automating user account creation through PowerShell, and joining a Windows 11 client to the domain.

The main goal is to demonstrate how **automation and centralized administration can simplify IT operations, reduce repetitive manual tasks, and improve efficiency** in an enterprise environment.

## Network Topology

- **Domain controller** => Windows Server 2022
- **Client** => Windows 11
- **Internal network** => `10.0.0.0/24`
- **Active Directory domain** => `vortex.local`

## Project Objectives

- Set up **Active Directory Domain Services (ADDS)**.
- Configure **DHCP Server**.
- Set up **Remote Access and NAT** for internal network routing.
- Add **100 users and 5 Organizational Units (OUs)** via PowerShell.
- Join a **Windows 11 machine to the domain**.
- Authenticate users and verify **network connectivity**.

# Active Directory Deployment & PowerShell Automation 🚀

## 📺 Watch the Video:

[Watch the Active Directory lab video](https://youtu.be/DFqT5ZYG2TI)

- **In this video, I walk through the full Active Directory and PowerShell lab setup.**

## 1. Windows Server and Active Directory Setup

### Step 1. The lab topology.

![the Windows Server 2022 VM, Windows 11 client, and separate internet and internal network connections.](phase-1/lab-topology.png)

*Screenshot shows the Windows Server 2022 VM, Windows 11 client, and separate internet and internal network connections.*

### Step 2. Select the server roles in Server Manager.

![Active Directory Domain Services, DHCP Server, and Remote Access selected in Server Manager.](phase-1/server-roles.png)

*Screenshot shows Active Directory Domain Services, DHCP Server, and Remote Access selected in Server Manager.*

### Step 3. Start a new forest in the AD DS Configuration Wizard.

![vortex.local entered as the root domain in the AD DS Configuration Wizard.](phase-1/new-forest.png)

*Screenshot shows vortex.local entered as the root domain in the AD DS Configuration Wizard.*

## 2. Network Adapter Setup

### Step 1. Internet-facing adapter.

![the server's internet-facing adapter settings.](phase-2/part-2-step-1.png)

*Screenshot shows the server's internet-facing adapter settings.*

### Step 2. Test internet connectivity from the server.

![successful ping replies during the server connectivity test.](phase-2/part-2-step-2.png)

*Screenshot shows successful ping replies during the server connectivity test.*

### Step 3. Add a second network adapter.

![the Add button in VMware virtual machine settings.](phase-2/part-2-step-3.png)

*Screenshot shows the Add button in VMware virtual machine settings.*

### Step 4. Select Network Adapter.

![Network Adapter selected in the Add Hardware Wizard.](phase-2/part-2-step-4.png)

*Screenshot shows Network Adapter selected in the Add Hardware Wizard.*

### Step 5. Open LAN Segments.

![the LAN Segments button for the second network adapter.](phase-2/part-2-step-5.png)

*Screenshot shows the LAN Segments button for the second network adapter.*

### Step 6. Create the LAN segment.

![a new segment named LAN in the Global LAN Segments window.](phase-2/part-2-step-6.png)

*Screenshot shows a new segment named LAN in the Global LAN Segments window.*

### Step 7. Select the LAN segment for the internal adapter.

![the LAN segment selected for the second VMware network adapter.](phase-2/part-2-step-7.png)

*Screenshot shows the LAN segment selected for the second VMware network adapter.*

### Step 8. Configure the internal adapter.

![the internal adapter configured with 10.0.0.1 and the default gateway field left blank.](phase-2/part-2-step-8.png)

*Screenshot shows the internal adapter configured with 10.0.0.1 and the default gateway field left blank.*

### Step 9. Verify both adapters in Windows.

![the Internal and Internet adapters listed separately in Windows.](phase-2/part-2-step-9.png)

*Screenshot shows the Internal and Internet adapters listed separately in Windows.*

## 3. DHCP Server Setup

### Step 1. Create and name the DHCP scope.

![the name entered for the new DHCP scope.](phase-3/part-3-step-1.png)

*Screenshot shows the name entered for the new DHCP scope.*

### Step 2. Set the scope's address range.

![the IP address range configured for client leases.](phase-3/part-3-step-2.png)

*Screenshot shows the IP address range configured for client leases.*

### Step 3. Set the lease duration to three days.

![a three-day DHCP lease duration.](phase-3/part-3-step-3.png)

*Screenshot shows a three-day DHCP lease duration.*

### Step 4. Set the router option for clients.

![10.0.0.1 configured as the default gateway for DHCP clients.](phase-3/part-3-step-4.png)

*Screenshot shows 10.0.0.1 configured as the default gateway for DHCP clients.*

### Step 5. Authorize the DHCP server in Active Directory.

![the DHCP server authorization step in the DHCP console.](phase-3/part-3-step-5.png)

*Screenshot shows the DHCP server authorization step in the DHCP console.*

## 4. Routing and NAT

### Step 1. Open the Routing and Remote Access setup wizard.

![the server selected for Routing and Remote Access configuration.](phase-4/part-4-step-1.png)

*Screenshot shows the server selected for Routing and Remote Access configuration.*

### Step 2. Choose Network Address Translation (NAT).

![NAT selected in the Routing and Remote Access setup wizard.](phase-4/part-4-step-2.png)

*Screenshot shows NAT selected in the Routing and Remote Access setup wizard.*

### Step 3. Select the internet-facing adapter.

![the Internet adapter selected as the external NAT interface.](phase-4/part-4-step-3.png)

*Screenshot shows the Internet adapter selected as the external NAT interface.*

## 5. Bulk User Provisioning with PowerShell

### Downloads

- [Download the PowerShell script and CSV (ZIP)](phase-5/100%20Bulk%20Users%20Script%20%26%20CSV%20File.zip)

Extract both files to the same folder before running the script.

### Step 1. Prepare the user spreadsheet.

![the user spreadsheet with usernames, OUs, and account attributes.](phase-5/part-5-step-1.png)

*Screenshot shows the user spreadsheet with usernames, OUs, and account attributes.*

### Step 2. Locate the script and spreadsheet folder.

![PowerShell ISE opened in the folder containing the import files.](phase-5/part-5-step-2.png)

*Screenshot shows PowerShell ISE opened in the folder containing the import files.*

### Step 3. Open the PowerShell script.

![the Open Script button in PowerShell ISE.](phase-5/part-5-step-3.png)

*Screenshot shows the Open Script button in PowerShell ISE.*

### Step 4. Open and run the import script with the user CSV beside it.

![the Run Script button in PowerShell ISE.](phase-5/part-5-step-4.png)

*Screenshot shows the Run Script button in PowerShell ISE.*

### Step 5. Review the import log.

![PowerShell import log](phase-5/part-5-step-5.png)

*Screenshot shows OU creation, successful user imports, and an account-name error recorded in the import log.*

### Step 6. Verify accounts in Active Directory Users and Computers.

![the created organizational units and user accounts in Active Directory Users and Computers.](phase-5/part-5-step-6.png)

*Screenshot shows the created organizational units and user accounts in Active Directory Users and Computers.*

## 6. Windows 11 Domain Join

### Step 1. Open About your PC.

![the About your PC search result in Windows Settings.](phase-6/part-6-step-1.png)

*Screenshot shows the About your PC search result in Windows Settings.*

### Step 2. Open domain settings.

![the Domain or workgroup link on the About page.](phase-6/part-6-step-2.png)

*Screenshot shows the Domain or workgroup link on the About page.*

### Step 3. Change domain membership.

![the Change button in System Properties.](phase-6/part-6-step-3.png)

*Screenshot shows the Change button in System Properties.*

### Step 4. Enter the domain name.

![vortex.local entered in the Domain field.](phase-6/part-6-step-4.png)

*Screenshot shows vortex.local entered in the Domain field.*

### Step 5. Provide domain join credentials.

![the prompt for an account with permission to join the domain.](phase-6/part-6-step-5.png)

*Screenshot shows the prompt for an account with permission to join the domain.*

### Step 6. Join the Windows 11 client to vortex.local.

![the confirmation that the client joined the vortex.local domain.](phase-6/part-6-step-6.png)

*Screenshot shows the confirmation that the client joined the vortex.local domain.*

### Step 7. Sign in to the domain.

![the domain sign-in screen with the squidward.tentacles account.](phase-6/part-6-step-7.png)

*Screenshot shows the domain sign-in screen with the squidward.tentacles account.*

### Step 8. Verify the domain user session.

![the Windows 11 desktop signed in as Squidward Tentacles.](phase-6/part-6-step-8.png)

*Screenshot shows the Windows 11 desktop signed in as Squidward Tentacles.*

### Step 9. Verify the client received a DHCP lease.

![the client address lease listed in the DHCP console.](phase-6/part-6-step-9.png)

*Screenshot shows the client address lease listed in the DHCP console.*


## Project Outcomes & Key Achievements

- **Automated User Provisioning** – Used PowerShell to create Active Directory users and organizational units (OUs), reducing the need for manual account creation.
- **Network Configuration** – Successfully configured DHCP, NAT, and routing to provide IP address allocation and internet connectivity to domain clients.
- **Centralized User Management** – Established an Active Directory environment for managing domain users, accounts, and organizational units from a central location.
- **Successful Domain Integration** – Joined a Windows 11 client to the `vortex.local` domain and verified domain authentication and DHCP functionality.

## Potential Next Steps

- Implement Group Policy Objects (GPOs) to manage user and computer security settings.
- Configure Role-Based Access Control (RBAC) using AD security groups and NTFS permissions.
- Expand PowerShell automation for user onboarding and offboarding.
- Integrate Microsoft Entra Connect Sync to synchronize on-premises AD with Microsoft Entra ID.
- Configure Active Directory backup and recovery procedures.

This lab is one of the hands-on projects I've completed to develop and demonstrate my skills in Active Directory and Windows Server administration.

Feel free to connect with me on [LinkedIn](https://www.linkedin.com/in/nyasha-jiri-86a149334/), explore more of my IT projects and tutorials on my [YouTube Channel](https://youtube.com/@pingnyasha), or visit my [Portfolio Website](https://nyashajiri.com/).

**Built, tested, and documented by Nyasha Prince Jiri.**
