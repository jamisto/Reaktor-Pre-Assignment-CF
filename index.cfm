<cfinclude  template="inc/head.cfm">

<cfset fileObj =  fileOpen(expandPath("./status"))>
<select id="package">
    <cfloop condition="NOT #FileIsEOF(fileObj)#">
        <cfset line=fileReadLine(fileObj)>
        <cfif findNoCase("Package: ", line)>
            <option><cfoutput>#Replace(line,"Package: ", "")#</cfoutput></option>
        </cfif>
    </cfloop>
</select>
<button id="package-button">ok</button>

<script type="text/javascript">
    console.log("toimii")
    $("#package-button").click(()=>{
        let selectedPackage = $("#package").val();
        console.log(selectedPackage)
        let target = window.open("http://localhost:8500/details.cfm?package=" + selectedPackage, "_blank")
        target.focus();
    })
</script>