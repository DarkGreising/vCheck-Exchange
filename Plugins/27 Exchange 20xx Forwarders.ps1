# Start of Settings
# Exchange Database Name Filter (forwarders) (regular expression, to select all use '.*')
$exDBFilter=".*"
# Exchange Forwarder Name Filter (regular expression, to select all use '.*')
$exFwdFilter=".*"
# End of Settings

# Changelog
## 2.0 : New plugin to find Forwarders (to a specified mailbox pattern)

$Title = "Exchange 20xx Forwarders"
$Comments = "Mailboxes which forward emails to other addresses"
$Author = "Phil Randal"
$PluginVersion = 2.0
$PluginCategory = "Exchange2010"

If ($2007Snapin -or $2010Snapin) {
    $Display = "Table"
    $Header = "Mailboxes which forward"
	If ($exFwdFilter -ne '.*') {
	  $Header += " to addresses matching '" + $exFwdFilter + "'"
	}
    Get-Mailbox -Resultsize Unlimited |
	  Where { $_.ServerName -match $exServerFilter } |
	  Where { $_.Database -match $exDBFilter } |	  
 	  Where { $_.ForwardingAddress -ne $null } |
	  Where { $_.ForwardingAddress -match $exFwdFilter } |
	  Select Name, ForwardingAddress, DeliverToMailboxAndForward |
	  Sort Name
}
