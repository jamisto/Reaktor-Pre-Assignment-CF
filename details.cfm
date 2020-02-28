<cfinclude  template="inc/head.cfm">
<cfset fileObj =  fileOpen(expandPath("./status"))>
<cfset item = structNew()>
<cfset packageFound = false>
<cfset addThis = false>
<cfset item.name = url.package>
<cfset allInfo = "">

<cfoutput><h1>#url.package#</h1></cfoutput>
<cfloop condition="NOT #FileIsEOF(fileObj)#">
    <cfset line=fileReadLine(fileObj)>
    <cfset header="">
    
    <!--- If the start of another package is detected loop stops---->
    <cfif findNoCase("Package: " , line) AND packageFound EQ true>
        <cfbreak>
    </cfif>
    
    <!--- Once the requested package is found we can start collecting the information--->
    <cfif listFind("Package: #url.package#", line)>
        <cfset packageFound = true>
        <cfset allInfo = insert("</br> #line#", allInfo, len(allInfo))>
        <cfcontinue>
    </cfif>
    
    <!--- If a new header row is  found we examine wheter it is to be added--->
    <cfif reFindNoCase("(.*\w+:\s)", line) AND packageFound>
        <cfset addThis=false>
        <cfset header= reMatchNoCase("(.*\w+:\s)",line)>
        <cfset header = replace(header[1], ": ", "")>
    </cfif>
    
    <!--- If the header matches a desired topic the data is recored --->
    <cfif listFindNoCase("Description,Depends,Conflicts",header) AND packageFound>
        <cfoutput><h2>#header#</h2></cfoutput>
        <cfset addThis = true>
    </cfif>

    <!--- Adds information to the string--->
    <cfif packageFound AND addThis>
        <cfif findNoCase("#header#: ", line)>
            <cfoutput><p>#replace(line,"#header#: ", "")#</p></cfoutput>
        <cfelse>
            <cfoutput><p>#line#</p></cfoutput>
            <cfset allInfo = insert("</br> #line#", allInfo, len(allInfo))>
        </cfif>
    </cfif>
</cfloop>