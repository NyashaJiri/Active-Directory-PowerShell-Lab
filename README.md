# Active Directory and PowerShell Automation Lab

## Overview

A Windows Server 2022 and Windows 11 lab built in VMware Workstation to practice Active Directory administration and automate user provisioning with PowerShell.

## Network Topology

- **Domain controller** — Windows Server 2022
- **Client** — Windows 11
- **Internal network** — `10.0.0.0/24`
- **Active Directory domain** — `vortex.local`

## Project Objectives

- Configure Active Directory Domain Services, DHCP, and NAT.
- Use PowerShell to create organizational units and import users from a CSV.
- Join a Windows 11 client to the domain and verify domain sign-in and DHCP address assignment.

## 1. Windows Server and Active Directory Setup

1. Map out the lab with a Windows Server VM, a Windows 11 client, and separate internet and internal network adapters on the server.
2. In Server Manager, select **Active Directory Domain Services**, **DHCP Server**, and **Remote Access**.
3. In the AD DS Configuration Wizard, choose **Add a new forest** and enter `vortex.local` as the root domain.

### Visual Guide

![VMware lab topology with a Windows Server domain controller and Windows 11 client](lab-topology.png)

<table>
  <tr>
    <td><img src="server-roles.png" alt="Server Manager showing AD DS, DHCP Server, and Remote Access selected" width="450"></td>
    <td><img src="new-forest.png" alt="AD DS Configuration Wizard with vortex.local entered as the root domain" width="450"></td>
  </tr>
  <tr>
    <td align="center"><b>Server role selection</b></td>
    <td align="center"><b>New forest configuration</b></td>
  </tr>
</table>


## 2. Network Adapter Setup

Configured the internet-facing adapter and verified connectivity from the server. Added a second adapter on the VMware LAN segment and configured its internal address.

![Internet NIC configuration](part-2-step-1.png)

![Success Internet ping test on DC Server](part-2-step-2.png)

![LAN Segment created successfully](part-2-step-7.png)

![Internal NIC Configuration](part-2-step-8.png)

![NIC (Internal) & NIC (Internet) Created](part-2-step-9.png)



## 3. DHCP Server Setup

Created a DHCP scope, set its address range and three-day lease, configured the router option, and authorized the DHCP server.

![Naming DHCP Scope](part-3-step-1.png)

![Setting Up IP Address Range](part-3-step-2.png)

![IP Address Lease Duration set to 3days](part-3-step-3.png)

![Router Gateway Setup](part-3-step-4.png)

![Authorize DHCP Server](part-3-step-5.png)



## 4. Routing and NAT

Enabled Routing and Remote Access, selected NAT, and assigned the internet-facing adapter as the external interface.

![Enable RAS](part-4-step-1.png)

![Select Nat](part-4-step-2.png)

![Select Internet NIC](part-4-step-3.png)



## 5. Bulk User Provisioning with PowerShell

Ran a PowerShell script to import users from a CSV and organize them into department OUs. Checked the import log and verified the created OUs and accounts in Active Directory Users and Computers.

![Click Green Icon To Run Script](part-5-step-4.png)

![Verifed Created Ous & Users](part-5-step-6.png)



## 6. Windows 11 Domain Join

Joined the Windows 11 client to vortex.local, signed in with a domain account, and verified that the client received a DHCP lease.

![Domain Joined Successfully](part-6-step-6.png)

![User Successfully Logged Onto Domain](part-6-step-8.png)

![Client PC Leased IP](part-6-step-9.png)

## Reference

[TechGneek's Active Directory and PowerShell Automation Lab](https://github.com/techgneek/Active-Directory-and-Powershell-Automation) provided the README structure.

