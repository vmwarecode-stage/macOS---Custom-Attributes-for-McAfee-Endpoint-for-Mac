##  NOTE:  Adapted from https://github.com/tziegmann  ##
 

##  McAfee-IsManaged ##
	
isManaged=`sudo /Library/McAfee/agent/bin/cmdagent -i | grep GUID | cut -c 7-43`
if [ $isManaged != "N/A" ] ; 
then
result="Managed"
else
result="Unmanaged"
fi
echo $result


##  McAfee-AgentVersion  ##

Version=`cat /etc/cma.d/EPOAGENT3700MACX/config.xml | egrep "<Version>.*</Version>" |sed -e "s/<Version>\(.*\)<\/Version>/\1/"|tr -d " "`
echo $Version


##  McAfee-AntiMalwareVersion  ##

engver=`/usr/bin/defaults read /Library/Preferences/com.mcafee.ssm.antimalware.plist Update_EngineVersion`
echo $engver


##  McAfee-DATVersion  ##

datver=`/usr/bin/defaults read /Library/Preferences/com.mcafee.ssm.antimalware.plist Update_DATVersion | cut -b 1-4`
echo $datver

##  McAfee-FirewallStatus  ##

if [ -f "/Library/Preferences/com.mcafee.ssm.StatefulFirewall.plist" ]; then
result=`/usr/bin/defaults read /Library/Preferences/com.mcafee.ssm.StatefulFirewall IsFirewallEnabled`
fi
if [ "$result" = "1" ]; then
    echo "Enabled"
else
    echo "Disabled"
fi


##  McAfee-LastDATUpdateTime  ##

if [ -f "/Library/Preferences/com.mcafee.ssm.antimalware.plist" ]; then
result=`date -r "$(/usr/bin/defaults read /Library/Preferences/com.mcafee.ssm.antimalware Update_Last_Update_Time)" "+%Y-%m-%d %H:%M:%S"`
echo $result
else
echo "Not installed"
fi

##  McAfee-OASStatus  ##

result=`/usr/bin/defaults read /Library/Preferences/com.mcafee.ssm.antimalware OAS_Enable`
if [ "$result" = "1" ]; then
    echo "Enabled"
else
    echo "Disabled"
fi


##  McAfee-AMHotfixVersion  ##

AMHotfix=`cat /usr/local/McAfee/AntiMalware/var/HFSP-Version.xml | egrep "<Version0>.*</Version0>" |sed -e "s/<Version0>\(.*\)<\/Version0>/\1/"|tr -d " "|tr -d "\t"|tr -d "\n"|tr -d "\r"`
echo $AMHotfix


##  McAfee-ThreatPreventionVersion  ##

FMPVersion=`cat /usr/local/McAfee/fmp/config/FMPInfo.xml | egrep "<FMPVersion>.*</FMPVersion>" |sed -e "s/<FMPVersion>\(.*\)<\/FMPVersion>/\1/"|tr -d " "|tr -d "\t"|tr -d "\n"|tr -d "\r"`
BuildNumber=`cat /usr/local/McAfee/fmp/config/FMPInfo.xml | egrep "<BuildNumber>.*</BuildNumber>" |sed -e "s/<BuildNumber>\(.*\)<\/BuildNumber>/\1/"|tr -d " "|tr -d "\t"|tr -d "\n"|tr -d "\r"`
TPVersion="$FMPVersion.$BuildNumber"
echo $TPVersion
